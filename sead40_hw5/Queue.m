//
//  Queue.m
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/1/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "Queue.h"

@implementation Queue

- (instancetype)init
{
  self = [super init];
  if (self = [super init]) {
    self.myArray = [[NSMutableArray alloc]init];
    self.count = 0;
  }
  return self;
}

-(void)enqueue:(id)myObject{
  
  [self.myArray addObject:myObject];
  
}

-(id)dequeue{
  
  id object = nil;
  
  if (self.myArray.count > 0) {
    
    //Get the object with index 0
    object = [self.myArray objectAtIndex:0];
    
    //Remove this object(FIFO)
    [self.myArray removeObjectAtIndex:0];
    
    //Count again
    self.count = self.myArray.count;
  }
  
  return object;
}

@end
