//
//  ViewController.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 8/31/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  //Init Location Manager
  self.locationManager = [[CLLocationManager alloc]init];
  
  //Set the delegate
  self.locationManager.delegate = self;
  
  //After checking the location fires the delegate method didChangeAuthorizationStatus
  [self.locationManager requestWhenInUseAuthorization];
  
  //Update location
  [self.locationManager startUpdatingLocation];
  
  //Show user location on the map
  self.mapView.showsUserLocation = YES;
  
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
  
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(47.6097, -122.3331), 100000, 100000) animated:true];
  
}

- (IBAction)showSydney:(id)sender {
  
  [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(-33.8650, 151.2094), 100000, 100000) animated:true];
  
}

#pragma mark - Location Manager Delegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
  
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  
  if (status==3) {
    [self.mapView setShowsUserLocation:YES];
    NSLog(@"Showing User Location");
  }
  
}



@end































