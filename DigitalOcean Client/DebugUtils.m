//
//  DebugUtils.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DebugUtils.h"
#import <stdarg.h>

@implementation DebugUtils


+(void)method_entry: (const char*)filename: (const char*) funcname
{
    NSLog(@"%s:%s ENTRY\n", filename, funcname);
}

+(void)method_exit: (const char*)filename: (const char*) funcname
{
    NSLog(@"%s:%s EXIT\n", filename, funcname);
}

+(void)debug:(NSString *)debug_str
{
    NSLog(@"%@\n", debug_str);
}

+(void)debug:(NSString *)debug_str withFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSLog(@"%@\n", str);
}

@end
