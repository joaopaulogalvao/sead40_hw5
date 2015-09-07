//
//  ReminderViewController.h
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/2/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ReminderViewController : UIViewController<UITextFieldDelegate>

@property CLLocationCoordinate2D myTappedCoord;

@end
