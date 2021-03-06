//
//  AppDelegate.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 8/31/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "AppDelegate.h"
#import "Keys.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Reminder.h"
#import "Constants.h"
#import "ReminderViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
  if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    UILocalNotification *myReminderNotif = [[UILocalNotification alloc]init];
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:myReminderNotif];
    //[application registerUserNotificationSettings:settings];
  }
  
  
  [Reminder registerSubclass];
  
  // Initialize Parse.
  [Parse setApplicationId:kApplicationID
                clientKey:kClientKey];
  
  
  return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  NSLog(@"Local reminder notification!");
  
  UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
  
  UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
  
  ReminderViewController *controller = (ReminderViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"reminderView"];
  
  [navigationController pushViewController:controller animated:YES];
  
//  ReminderViewController *reminderView = [[ReminderViewController alloc]init];
//  
//  NSDictionary *viewDict = [NSDictionary dictionaryWithObject:reminderView forKey:@"Reminder"];
//  
//  [[NSNotificationCenter defaultCenter] postNotificationName:kReminderNotification object:self userInfo:viewDict];
  
  
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  
  
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
