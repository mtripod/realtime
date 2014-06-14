//
//  Communication.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "Communication.h"

@implementation Communication


-(void)connect:(Success)success
       failure:(Failure)failure
{
    NSAssert(YES, @"This method must be implemented in child classes");
}
-(void)disconnect:(Success)success
          failure:(Failure)failure
{
    NSAssert(YES, @"This method must be implemented in child classes");
}


-(void)send:(NSDictionary*)data
    success:(Success)success
    failure:(Failure)failure
{
    NSAssert(YES, @"This method must be implemented in child classes");
}

-(void)receive:(NSDictionary*)data
       success:(Success)success
       failure:(Failure)failure
{
    NSAssert(YES, @"This method must be implemented in child classes");
}

-(BOOL)isConnected
{
    NSAssert(YES, @"This method must be implemented in child classes");
    return NO;
}

-(NSDictionary*)status
{
    NSAssert(YES, @"This method must be implemented in child classes");
    return nil;
}

@end
