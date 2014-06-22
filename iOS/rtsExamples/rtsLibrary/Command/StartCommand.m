//
//  StartCommand.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "StartCommand.h"

@implementation StartCommand


-(void)execute:(Success)success failure:(Failure)failure
{    
    [self.device start:^(NSDictionary *result)
    {
        success(success);
    } failure:^(NSError *error)
    {
        failure(failure);
    }];
}
@end
