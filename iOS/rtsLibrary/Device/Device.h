//
//  Device.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Communication.h"



@interface Device : NSObject

@property (nonatomic) Communication *communication;

-(id)initWithCommunicationService:(Communication*)communication;

-(void)start:(Success)success
            failure:(Failure)failure;

-(void)stop:(Success)success
    failure:(Failure)failure;

-(void)send:(NSDictionary*)data
        success:(Success)success
    failure:(Failure)failure;

-(void)receive:(NSDictionary*)data
    success:(Success)success
    failure:(Failure)failure;

@end
