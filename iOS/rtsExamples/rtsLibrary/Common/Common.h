//
//  Common.h
//  rtsExamples
//
//  Created by Carlos Matias Tripode on 6/14/14.
//  Copyright (c) 2014 Carlos Matias Tripode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(NSDictionary *result);
typedef void (^Failure)(NSError *error);


@interface Common : NSObject

@end
