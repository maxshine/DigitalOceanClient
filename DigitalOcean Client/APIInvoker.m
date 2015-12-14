//
//  APIInvoker.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "APIInvoker.h"
#import "DebugUtils.h"
#import "Constants.h"
#import "DebugUtils.h"


@implementation APIInvoker

@synthesize method;
@synthesize base_url;
@synthesize headers;
@synthesize data;
@synthesize response;
@synthesize isDone;
@synthesize isProgress;
@synthesize queue;

-(APIInvoker*) init:(NSString*) _method withURL:(NSString*)_url withHeaders: (NSDictionary*)_headers withData:(NSData*)_data
{
    self.method = [_method uppercaseString];
    self.base_url = _url;
    self.headers = _headers;
    self.data = _data;
    self.response = [[NSMutableDictionary alloc] init];
    self.isDone = NO;
    self.isProgress = NO;
    self.queue = [NSOperationQueue new];
    return self;
}

-(NSDictionary*) invoke
{
    [DebugUtils method_entry:__FILE__ :__func__];
    self.isDone = NO;
    self.isProgress = YES;
    if ([self.method compare:@"POST"] == NSOrderedSame) {
        [self post];
    } else if ([self.method compare:@"GET"] == NSOrderedSame) {
        [self get];
    } else if ([self.method compare:@"DELETE"] == NSOrderedSame) {
        [self del];
    }
    int i = 0;
    while (!self.isDone && i<=[[Constants instance] timeout]) {
        [NSThread sleepForTimeInterval:1.0];
        i++;
    }
    if (i > [[Constants instance] timeout]) {
        [DebugUtils debug:@"Request timeout"];
        return nil;
    }
    
    [DebugUtils method_exit:__FILE__ :__func__];
    return self.response;
}

-(void) get
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSURL *URL = [NSURL URLWithString:self.base_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    for (NSString* key in [self.headers keyEnumerator]) {
        [request setValue:[self.headers valueForKey:key] forHTTPHeaderField:key];
    }
    [NSURLConnection sendAsynchronousRequest:[request copy]
                                       queue:self.queue
                           completionHandler:^(NSURLResponse *_response,
                                               NSData *_data, NSError *connectionError)
     {
         if (_data.length > 0)
         {
             NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:_data options:0 error:NULL];
             [self.response setValue:obj forKey:@"json body"];
         }
         [self.response setValue:_response forKey:@"response meta"];
         [self.response setValue:connectionError forKey:@"error"];
         self.isDone = YES;
         self.isProgress = NO;
     }];
    [DebugUtils method_exit:__FILE__ :__func__];
}

-(void) del
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSURL *URL = [NSURL URLWithString:self.base_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    for (NSString* key in [self.headers keyEnumerator]) {
        [request setValue:[self.headers valueForKey:key] forHTTPHeaderField:key];
    }
    [NSURLConnection sendAsynchronousRequest:[request copy]
                                       queue:self.queue
                           completionHandler:^(NSURLResponse *_response,
                                               NSData *_data, NSError *connectionError)
     {
         if (_data.length > 0)
         {
             NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:_data options:0 error:NULL];
             [self.response setValue:obj forKey:@"json body"];
         }
         
         [self.response setValue:_response forKey:@"response meta"];
         [self.response setValue:connectionError forKey:@"error"];
         self.isDone = YES;
         self.isProgress = NO;
     }];
    [DebugUtils method_exit:__FILE__ :__func__];
}

-(void) post
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSURL *URL = [NSURL URLWithString:self.base_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:self.method];
    [request setHTTPBody:self.data];
    for (NSString* key in [self.headers keyEnumerator]) {
        [request setValue:[self.headers valueForKey:key] forHTTPHeaderField:key];
    }
    [NSURLConnection sendAsynchronousRequest:[request copy]
                                       queue:self.queue
                           completionHandler:^(NSURLResponse *_response,
                                               NSData *_data, NSError *connectionError)
     {
         if (_data.length > 0)
         {
             NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:_data options:0 error:NULL];
             [self.response setValue:obj forKey:@"json body"];
         }
         [self.response setValue:_response forKey:@"response meta"];
         [self.response setValue:connectionError forKey:@"error"];
         self.isDone = YES;
         self.isProgress = NO;
     }];
    [DebugUtils method_exit:__FILE__ :__func__];
}

-(void) put
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSURL *URL = [NSURL URLWithString:self.base_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:self.method];
    [request setHTTPBody:self.data];
    for (NSString* key in [self.headers keyEnumerator]) {
        [request setValue:[self.headers valueForKey:key] forHTTPHeaderField:key];
    }
    [NSURLConnection sendAsynchronousRequest:[request copy]
                                       queue:self.queue
                           completionHandler:^(NSURLResponse *_response,
                                               NSData *_data, NSError *connectionError)
     {
         if (_data.length > 0)
         {
             NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:_data options:0 error:NULL];
             [self.response setValue:obj forKey:@"json body"];
         }
         [self.response setValue:_response forKey:@"response meta"];
         [self.response setValue:connectionError forKey:@"error"];
         self.isDone = YES;
         self.isProgress = NO;
     }];
    [DebugUtils method_exit:__FILE__ :__func__];
}

@end
