//
//  CommandInvoker.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"
#import "SchedulingStrategy.h"

@interface CommandInvoker : NSObject

+ (CommandInvoker*)instance;

-(void)addCommand:(Command*)command;
-(void)removeCommand:(Command*)command;

-(void)removedAllCommands;

-(void)executeCommandsWithStrategy:(SchedulingStrategy*)scheduling
                           success:(Success)success
                failure:(Failure)failure;

@end
