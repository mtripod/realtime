//
//  ArduinoBoard.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "ArduinoBoard.h"

@implementation ArduinoBoard

-(void)start:(Success)success
     failure:(Failure)failure
{
    [self.communication connect:^(NSDictionary *result)
    {
        success(success);
    } failure:^(NSError *error)
    {
        failure(failure);
    }];
}

-(void)stop:(Success)success
    failure:(Failure)failure
{
    [self.communication disconnect:^(NSDictionary *result)
    {
        success(success);
    } failure:^(NSError *error)
    {
        failure(failure);
    }];
}

-(void)send:(NSDictionary*)data
    success:(Success)success
    failure:(Failure)failure
{
    [self.communication send:data success:^(NSDictionary *result)
    {
        success(success);
    } failure:^(NSError *error)
    {
        failure(failure);
    }];
}

-(void)receive:(NSDictionary*)data
       success:(Success)success
       failure:(Failure)failure

{
    [self.communication receive:data success:^(NSDictionary *result)
    {
        success(success);
    } failure:^(NSError *error)
    {
        failure(failure);
    }];
}

@end
