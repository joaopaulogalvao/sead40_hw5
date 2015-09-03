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

@interface ReminderViewController ()

@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderNotification:) name:kReminderNotification object:nil];
  
  PFQuery *pizzaQuery = [Reminder query];
  
  [pizzaQuery findObjectsInBackgroundWithBlock:^(NSArray *reminders, NSError *error) {
    
    Reminder *firstReminder = [reminders firstObject];
    
    NSLog(@"%@",firstReminder.name);
  }];
  
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:CLLocationCoordinate2DMake(47.6235, -122.3363) radius:200 identifier:@"Code Fellows"];
    //[self.locationManager startMonitoringForREgion: region];
  
  }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reminderNotification:(NSNotification *)notification {
  NSLog(@"notification fired!");
  NSDictionary *userInfo = notification.userInfo;
  if (userInfo) {
    
   // NSString *value = userInfo[@"Hello"];
    
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
