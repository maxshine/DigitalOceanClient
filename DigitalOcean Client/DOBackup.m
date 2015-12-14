//
//  DOBackup.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DOBackup.h"

@implementation DOBackup

@synthesize ID;
@synthesize name;
@synthesize slug;
@synthesize created_at;
@synthesize regions;
@synthesize type;
@synthesize public;
@synthesize distribution;
@synthesize min_disk_size;

-(DOBackup*)initWithObject:(NSDictionary *)o
{
    self.ID = [[o valueForKey:@"id"] longValue];
    self.name = [o valueForKey:@"name"];
    self.type = [o valueForKey:@"type"];
    self.public = [[o valueForKey:@"public"] boolValue];
    self.min_disk_size = [[o valueForKey:@"min_disk_size"] longValue];
    self.slug = [o valueForKey:@"slug"];
    self.created_at = [o valueForKey:@"created_at"];
    self.regions = [o valueForKey:@"regions"];
    self.distribution = [o valueForKey:@"distribution"];
    return self;
}

@end
