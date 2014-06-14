//
//  RoundRobinScheduling.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "RoundRobinScheduling.h"
#import "Command.h"

@implementation RoundRobinScheduling

-(void)schedule:(NSArray *)commands
        success:(Success)success
        failure:(Failure)failure
{
    for (Command *cmd in commands)
    {
        [cmd execute:^(NSDictionary *result)
         {
             success(success);
         }
             failure:^(NSError *error)
         {
             failure(failure);
         }];
    }
}
@end
