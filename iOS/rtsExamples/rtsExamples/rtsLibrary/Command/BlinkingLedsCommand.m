//
//  BlinkingLedsCommand.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "BlinkingLedsCommand.h"

@implementation BlinkingLedsCommand


-(void)execute:(Success)success failure:(Failure)failure
{
    // check if it is connected first
    
    [self.device send:@{@"key1":@"value1"} success:^(NSDictionary *result) {
        success(success);
    } failure:^(NSError *error) {
        failure(failure);
    }];
}

@end
