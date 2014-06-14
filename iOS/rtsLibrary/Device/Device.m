//
//  Device.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "Device.h"

@implementation Device

-(id)initWithCommunicationService:(Communication*)communication
{
    self = [super init];
    if (self)
    {
        self.communication = communication;
    }
    return self;
}


-(void)start:(Success)success
     failure:(Failure)failure
{
    NSAssert(YES, @"This method must be implemented in child classes");
}

-(void)stop:(Success)success
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


@end
