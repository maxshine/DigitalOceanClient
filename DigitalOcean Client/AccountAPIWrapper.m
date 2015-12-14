//
//  AccountAPIWrapper.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "AccountAPIWrapper.h"
#import "Constants.h"
#import "APIInvoker.h"
#import "DebugUtils.h"

@implementation AccountAPIWrapper


+(NSDictionary *) getAccountDetails;
{
    
    [DebugUtils method_entry: __FILE__: __func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@", const_inst.https_url_prefix, @"/v2/account"] withHeaders:headers withData:nil];
    [invoker invoke];
    
    if ([invoker.response valueForKey:@"response meta"] == nil) {
        return nil;
    }
    
    NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"account"];
    [DebugUtils method_exit: __FILE__: __func__];
    return result;
}

@end
