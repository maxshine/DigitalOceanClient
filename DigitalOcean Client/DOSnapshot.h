//
//  DOSnapshot.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DOSNAPSHOT_H

#define DOSNAPSHOT_H

@interface DOSnapshot : NSObject

@property (assign) long ID;
@property (copy) NSString* name;
@property (copy) NSString* type;
@property (copy) NSString* distribution;
@property (copy) NSString* slug;
@property (assign) BOOL public;
@property (retain) NSArray* regions;
@property (assign) int min_disk_size;
@property (copy) NSString* created_at;

-(DOSnapshot*) initWithObject:(NSDictionary*)o;

@end

#endif
