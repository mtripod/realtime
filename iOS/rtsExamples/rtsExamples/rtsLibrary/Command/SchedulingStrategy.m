//
//  SchedulingStrategy.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "SchedulingStrategy.h"

@implementation SchedulingStrategy

-(void)schedule :(NSArray*)commands
         success:(Success)success
         failure:(Failure)failure

{
    NSAssert(YES, @"This method must be implemented in child classes");
}

@end
