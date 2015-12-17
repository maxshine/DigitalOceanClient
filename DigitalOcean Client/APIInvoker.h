//
//  APIInvoker.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//
#ifndef APIINVOKER_H

#define APIINVOKER_H

#import <Foundation/Foundation.h>
#import "DebugUtils.h"
#import "Constants.h"

@interface APIInvoker : NSObject

@property (nonatomic, copy) NSString* base_url;
@property (nonatomic, strong) NSData* data;
@property (nonatomic, copy) NSString* method;
@property (atomic, strong) NSDictionary* headers;
@property (atomic, strong) NSMutableDictionary* response;
@property (atomic, assign) BOOL isDone;
@property (atomic, assign) BOOL isProgress;
@property (atomic, strong) NSOperationQueue* queue;

-(NSDictionary*) invoke;
-(void) get;
-(void) put;
-(void) post;
-(void) del;

-(APIInvoker*) init:(NSString*) method withURL:(NSString*)url withHeaders: (NSDictionary*)headers withData:(NSData*)data;

@end
#endif
