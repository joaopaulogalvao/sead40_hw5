//
//  Person.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 8/31/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "Person.h"

@implementation Person



-(instancetype)initWithName:(NSString *)locationName {
  
  if (self = [super init]) {
    _locationName = locationName;
    
  }
  return self;
  
}


@end
