//
//  SchedulingStrategy.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface SchedulingStrategy : NSObject

-(void)schedule :(NSArray*)commands
         success:(Success)success
         failure:(Failure)failure;

@end
