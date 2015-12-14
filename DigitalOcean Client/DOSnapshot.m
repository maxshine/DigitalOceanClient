//
//  DOSnapshot.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DOSnapshot.h"

@implementation DOSnapshot

@synthesize ID;
@synthesize name;
@synthesize type;
@synthesize slug;
@synthesize distribution;
@synthesize public;
@synthesize regions;
@synthesize min_disk_size;
@synthesize created_at;

-(DOSnapshot*) initWithObject:(NSDictionary*)o
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
