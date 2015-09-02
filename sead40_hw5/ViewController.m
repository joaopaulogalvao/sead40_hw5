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


@interface ViewController ()

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  UIBarButtonItem *barButtonAddReminder = [[UIBarButtonItem alloc]init];
  
  
  //self.navigationItem.leftBarButtonItem = barButtonAddReminder;
  self.navigationController.navigationItem.leftBarButtonItem = barButtonAddReminder;
  
  
  //Test Parse
  PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
  testObject[@"foo"] = @"bar";
  [testObject saveInBackground];
  
  //Init Location Manager
  self.locationManager = [[CLLocationManager alloc]init];
  
  //Set the delegate
  self.locationManager.delegate = self;
  self.mapView.delegate = self;
  
  //After checking the location fires the delegate method didChangeAuthorizationStatus
  [self.locationManager requestWhenInUseAuthorization];
  
  //Update location
  [self.locationManager startUpdatingLocation];
  
  //Show user location on the map
  self.mapView.showsUserLocation = YES;
  
  //Add Gesture recognizer
  self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
  
  self.longPressGestureRecognizer.minimumPressDuration = 0.7;

  [self.mapView addGestureRecognizer:self.longPressGestureRecognizer];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  
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
  CLLocationCoordinate2D coordinate = [self.mapView convertPoint:longPoint toCoordinateFromView:self.mapView];
  
  //NSUInteger numberOfTouches = [self.longPressGestureRecognizer numberOfTouches];
  
  //Log coord infos
  NSLog(@"Long press location was %.0f, %.0f", longPoint.x, longPoint.y);
  NSLog(@"World coordinate was longitude %f, latitude %f", coordinate.longitude, coordinate.latitude);
  
  //Place a pin on the map
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  annotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
  annotation.title = @"My reminder";
  [self.mapView addAnnotation:annotation];
  
  
  
}

#pragma mark - Location Manager Delegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
  
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  
  //Set to store only significant location changes in Parse
  CLLocation *location = locations.lastObject;
//  NSString *coordinateString = [NSString stringWithFormat:@"%f %f",location.coordinate.latitude,location.coordinate.longitude];
//  NSData *coordinateData = [coordinateString dataUsingEncoding:NSUTF8StringEncoding];
  
  // this data will come back as data, and I convert it as a string to get back from Kinesis.
  
  NSLog(@"lat: %f, long: %f, speed: %f",location.coordinate.latitude, location.coordinate.longitude, location.speed);
  
}



-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  
  if (status==3) {
    [self.mapView setShowsUserLocation:YES];
    NSLog(@"Showing User Location");
  }
  
}

#pragma mark - MKMapViewDelegate

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
  
  [self performSegueWithIdentifier:@"toDetail" sender:self];
  
//  UIViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"reminderView"];
//  
//  [self.navigationController pushViewController:detail animated:true];
  
  
}



@end































