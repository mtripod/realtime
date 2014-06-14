//
//  Communication.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface Communication : NSObject

-(void)connect:(Success)success
     failure:(Failure)failure;

-(void)disconnect:(Success)success
     failure:(Failure)failure;


-(void)send:(NSDictionary*)data
        success:(Success)success
          failure:(Failure)failure;

-(void)receive:(NSDictionary*)data
       success:(Success)success
       failure:(Failure)failure;

-(BOOL)isConnected;

-(NSDictionary*)status;

@end
