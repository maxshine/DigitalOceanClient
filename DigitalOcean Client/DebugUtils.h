//
//  DebugUtils.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DebugUtils : NSObject

+(void)method_entry: (const char*) filename: (const char*) funcname;
+(void)method_exit: (const char*) filename: (const char*) funcname;
+(void)debug:(NSString*)debug_str;
+(void)debug:(NSString*)debug_str withFormat:(NSString*)format,...;

@end
