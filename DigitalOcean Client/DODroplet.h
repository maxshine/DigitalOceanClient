//
//  Droplet.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DOImage.h"
#import "DORegion.h"
#import "DONetwork.h"

#ifndef DODROPLET_H

#define DODROPLET_H

@interface DODroplet : NSObject

@property (nonatomic, assign) long ID;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) int memory; // memory size in megabytes
@property (nonatomic, assign) int vcpus;
@property (nonatomic, assign) int disk; // size of disk in gigabytes
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, copy) NSString* created_at;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* size_slug;
@property (nonatomic, copy) NSNumber* price_monthly;
@property (nonatomic, copy) NSNumber* price_hourly;
@property (nonatomic, strong) NSMutableArray<NSNumber*>* backup_ids;
@property (nonatomic, strong) NSMutableArray<NSNumber*>* snapshot_ids;
@property (nonatomic, strong) NSMutableArray<NSString*>* features;
@property (nonatomic, strong) DOImage* image;
@property (nonatomic, strong) NSMutableArray<DONetwork*>* v4_networks;
@property (nonatomic, strong) NSMutableArray<DONetwork*>* v6_networks;
@property (nonatomic, strong) DORegion* region;

-(DODroplet*) initWithObject:(NSDictionary*)o;

@end

#endif
