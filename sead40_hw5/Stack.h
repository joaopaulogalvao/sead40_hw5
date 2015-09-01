//
//  Stack.h
//  sead40_hw5
//
//  Created by Joao Paulo Galvao Alves on 9/1/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

-(void)push:(id)myObject;
-(id)pop;

@property(nonatomic, strong) NSMutableArray *myStackArray;
@property(nonatomic)NSInteger count;

@end
