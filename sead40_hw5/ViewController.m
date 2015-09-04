//
//  ViewController.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 8/31/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import "Reminder.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>
#import "ReminderViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationCoordinate2D coordinate;

-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  UIBarButtonItem *barButtonAddReminder = [[UIBarButtonItem alloc]init];
  
  
  //self.navigationItem.leftBarButtonItem = barButtonAddReminder;
  self.navigationController.navigationItem.leftBarButtonItem = barButtonAddReminder;
  
  //Init Location Manager
  self.locationManager = [[CLLocationManager alloc]init];
  
  //Set the delegate
  self.locationManager.delegate = self;
  self.mapView.delegate = self;
  
  //After checking the location fires the delegate method didChangeAuthorizationStatus
  [self.locationManager requestAlwaysAuthorization]; // change to always
  
  //Update location
  [self.locationManager startUpdatingLocation];
  
  //Show user location on the map
  self.mapView.showsUserLocation = YES;
  
  //Handle received notification
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleReceivedNotification:) name:kReminderNotification object:nil];
  
  //Add Gesture recognizer
  self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
  
  self.longPressGestureRecognizer.minimumPressDuration = 0.7;

  [self.mapView addGestureRecognizer:self.longPressGestureRecognizer];
  
  //Create the signup view
  PFSignUpViewController *signupViewController = [[PFSignUpViewController alloc] init];
  signupViewController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton;
  
  //Set ourselves as the delegate
  [signupViewController setDelegate:self];
  
  //Present the view controller
  [self presentViewController:signupViewController animated:true completion:nil];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  
}

#pragma mark - Parse signup delegate
-(void)signUpViewController:(PFSignUpViewController * __nonnull)signUpController didSignUpUser:(PFUser * __nonnull)user{
  
  //Dismiss the signupView after signup
  [self dismissViewControllerAnimated:true completion:nil];
  
}

-(void)logInViewController:(PFLogInViewController * __nonnull)logInController didLogInUser:(PFUser * __nonnull)user{
  
  //Dismiss the loginView after login
  [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - My Actions
- (IBAction)showLA:(id)sender {
  
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(34.0500, -118.2500), 100000, 100000) animated:true];
  
}

- (IBAction)showSeattle:(id)sender {
  
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude), 10000, 10000) animated:true];
  
}

- (IBAction)showSydney:(id)sender {
  
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(-33.8650, 151.2094), 100000, 100000) animated:true];
  
}

-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture{
  
  NSLog(@"long press gesture");
  //Check if the gesture began
  if (self.longPressGestureRecognizer.state != UIGestureRecognizerStateBegan) {
    return;
  }
  
  //Make a point when the map is touched
  CGPoint longPoint = [self.longPressGestureRecognizer locationInView:self.mapView];
  
  //Convert a point to coordinate
  self.coordinate = [self.mapView convertPoint:longPoint toCoordinateFromView:self.mapView];
  
  //NSUInteger numberOfTouches = [self.longPressGestureRecognizer numberOfTouches];
  
  //Log coord infos
  NSLog(@"Long press location was %.0f, %.0f", longPoint.x, longPoint.y);
  NSLog(@"World coordinate was longitude %f, latitude %f", self.coordinate.longitude, self.coordinate.latitude);
  
  
  //Place a pin on the map
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  annotation.coordinate = CLLocationCoordinate2DMake(self.coordinate.latitude, self.coordinate.longitude);
  annotation.title = @"My reminder";
  [self.mapView addAnnotation:annotation];
  
  
  
}

#pragma mark - Notification
-(void)handleReceivedNotification:(NSNotification *)notification {
  
  Reminder *myReceivedReminder = notification.userInfo[@"Reminder"];
  
  MKCircle *circle = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(myReceivedReminder.reminderCoord.latitude, myReceivedReminder.reminderCoord.longitude) radius:200];
  
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:CLLocationCoordinate2DMake(myReceivedReminder.reminderCoord.latitude, myReceivedReminder.reminderCoord.longitude) radius:200 identifier:@"Entered Region"];
    
    [self.locationManager startMonitoringForRegion:region];
    //47.6235
    //-122.3363
    
  }

  [self.mapView addOverlay:circle];
  
}

#pragma mark - Location Manager Delegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

  
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
  
   NSLog(@"Entered region!");
  
  
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  
  //Set to store only significant location changes in Parse
  CLLocation *location = locations.lastObject;
  
  NSString *coordinateString = [NSString stringWithFormat:@"%f %f",location.coordinate.latitude,location.coordinate.longitude];
  
  NSData *coordinateData = [coordinateString dataUsingEncoding:NSUTF8StringEncoding];
  
  // this data will come back as data, and I convert it as a string to get back from Kinesis.
  
  NSMutableDictionary *coorDict = [[NSMutableDictionary alloc] init];
  
  [coorDict setValue:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
  [coorDict setValue:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"longitude"];
  
  coordinateData = [NSJSONSerialization dataWithJSONObject:coorDict options:NSJSONWritingPrettyPrinted error:nil];
  
//  NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:coordinateData options:NSJSONReadingMutableContainers error:nil];
  
  //NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:location, nil];
  
  //NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
  //[dict setValue:arr forKey:@"locations"];
  
  //NSLog(@"JSON representation for dictionary is %@",coorDict);
  
  //NSLog(@"lat: %f, long: %f, speed: %f",location.coordinate.latitude, location.coordinate.longitude, location.speed);
  
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  
  if (status==3) {
    [self.mapView setShowsUserLocation:YES];
    NSLog(@"Showing User Location");
  }
  
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier  isEqual: @"toDetail"]) {
    ReminderViewController *reminderView = segue.destinationViewController;
    reminderView.myTappedCoord = self.coordinate;
  }
  
}


#pragma mark - MKMapViewDelegate
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
  
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc]initWithOverlay:overlay];
  
  circleRenderer.strokeColor = [UIColor blueColor];
  
  return circleRenderer;
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  
  //Don't show annotation for current user
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  
  //Create a pinView
  MKPinAnnotationView *pinView =(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
  pinView.annotation = annotation;
  
  //Initialize the annotation
  if (!pinView) {
    pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
  }
  
  //Drop a pinView
  pinView.animatesDrop = true;
  
  //Change its color
  pinView.pinColor = MKPinAnnotationColorRed;
  
  //Show a callout
  pinView.canShowCallout = true;
  
  pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  
  return pinView;
  
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
  
  NSLog(@"clicked");
  
  //If you fire a notification from here, the other view is not even created yet. It will do nothing.
    
  [self performSegueWithIdentifier:@"toDetail" sender:self];
    
  
}




@end































