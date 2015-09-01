//
//  Stack.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/1/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (instancetype)init
{
  self = [super init];
  if (self = [super init]) {
    self.myStackArray = [[NSMutableArray alloc]init];
    self.count = 0;
  }
  return self;
}

-(void)push:(id)myObject{
  
  [self.myStackArray addObject:myObject];
  self.count = self.myStackArray.count;
  
}

-(id)pop{
  id object = nil;
  
  if (self.myStackArray.count > 0) {
    
    //Make it the last object in the stack
    object = [self.myStackArray lastObject];
    
    //Remove it from the stack
    [self.myStackArray removeLastObject];
    
    //Count again
    self.count = self.myStackArray.count;
  }
  
  return object;
}

@end
