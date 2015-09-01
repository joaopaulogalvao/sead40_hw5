//
//  Queue.h
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/1/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

-(void)enqueue:(id)myObject;
-(id)dequeue;

@property(nonatomic, strong) NSMutableArray *myArray;
@property(nonatomic) NSUInteger count;

@end
