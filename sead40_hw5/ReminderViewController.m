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
#import "Person.h"
#import "ViewController.h"

@interface ReminderViewController ()

@property(nonatomic, strong)CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *textFieldReminder;


@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Set text fiel delegate
  self.textFieldReminder.delegate = self;
  
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
  reminder.name = self.textFieldReminder.text;
  reminder.reminderCoord = [PFGeoPoint geoPointWithLatitude:self.myTappedCoord.latitude longitude:self.myTappedCoord.longitude];
  
  NSLog(@"Fired notification coord: %@",reminder.reminderCoord);
  
  [reminder saveInBackground];
  
  NSArray *notificationObjectsArray = [[NSArray alloc]initWithObjects:reminder,self.textFieldReminder.text, nil];
  NSArray *notificationKeysArray = [[NSArray alloc] initWithObjects:@"Reminder",@"ReminderTitle", nil];
  
   NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:notificationObjectsArray forKeys:notificationKeysArray];
  
  //NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder forKey:@"Reminder"]; //withObjects for more than one
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kReminderNotification object:self userInfo:userInfo];
  
  [self.navigationController popToRootViewControllerAnimated:true];
  
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
  [textField resignFirstResponder];
  
  return true;
  
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
