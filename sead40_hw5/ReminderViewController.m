//
//  ReminderViewController.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/2/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ReminderViewController.h"
#import "Reminder.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ReminderViewController ()

@property(nonatomic, strong)CLLocationManager *locationManager;


@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)fireNotification:(id)sender {
  
  NSLog(@"notification fired!");
  
  //Save Point location to Parse
  Reminder *reminder = [Reminder object];
  reminder.name = @"My reminder";
  reminder.reminderCoord = [PFGeoPoint geoPointWithLatitude:reminder.reminderCoord.latitude longitude:reminder.reminderCoord.longitude];
  
  NSLog(@"Fired notification coord: %@",reminder.reminderCoord);
  
  [reminder saveInBackground];
  
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Data" forKey:@"Hello"];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kReminderNotification object:self userInfo:userInfo];
  
  
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:CLLocationCoordinate2DMake(reminder.reminderCoord.latitude, reminder.reminderCoord.longitude) radius:200 identifier:@"Entered Region"];
    
    [self.locationManager startMonitoringForRegion:region];
    
  }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
