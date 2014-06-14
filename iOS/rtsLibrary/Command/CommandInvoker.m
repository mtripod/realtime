//
//  CommandInvoker.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "CommandInvoker.h"

@interface CommandInvoker()

@property (atomic) NSMutableArray *commands;

@end

@implementation CommandInvoker


+ (CommandInvoker *)instance
{
    static dispatch_once_t onceToken;
    static CommandInvoker *instance;
    dispatch_once(&onceToken, ^{
        instance = [[CommandInvoker alloc] init];
    });
    return instance;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.commands = [NSMutableArray new];
    }
    return self;
}

-(void)addCommand:(Command*)command
{
    [self.commands addObject:command];
}
-(void)removeCommand:(Command*)command
{
    [self.commands removeObject:command];
}

-(void)removedAllCommands
{
    [self.commands removeAllObjects];
}

-(void)executeCommandsWithStrategy:(SchedulingStrategy*)scheduling
                           success:(Success)success
                           failure:(Failure)failure

{
    [scheduling schedule:self.commands success:^(NSDictionary *result)
    {
        
        
    } failure:^(NSError *error) {
        
    }];
}

@end
