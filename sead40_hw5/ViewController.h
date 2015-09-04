//
//  ViewController.h
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 8/31/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,UIGestureRecognizerDelegate, MKMapViewDelegate,PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate>


@property(nonatomic, strong)CLLocationManager *locationManager;

- (IBAction)showLA:(id)sender;
- (IBAction)showSeattle:(id)sender;
- (IBAction)showSydney:(id)sender;

@end

