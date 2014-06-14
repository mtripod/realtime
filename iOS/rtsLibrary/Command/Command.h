//
//  Command.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"

@interface Command : NSObject

@property (nonatomic) Device *device;

-(id)initWithReceiver:(Device*)device;

-(void)execute:(Success)success
       failure:(Failure)failure;

@end
