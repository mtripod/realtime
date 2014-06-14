//
//  Command.m
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import "Command.h"

@interface Command()

@end

@implementation Command

-(id)initWithReceiver:(Device *)device
{
    self = [super init];
    if (self)
    {
        self.device = device;
    }
    return self;
}


-(void)execute:(Success)success failure:(Failure)failure
{
    NSAssert(YES, @"This method must be implemented in child classes");
}
@end
