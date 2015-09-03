//
//  Reminder.h
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/2/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *name;

@end
