//
//  DOImage.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DOImage.h"

@implementation DOImage

@synthesize ID;
@synthesize name;
@synthesize distribution;
@synthesize slug;
@synthesize public;
@synthesize regions;
@synthesize created_at;
@synthesize type;
@synthesize min_disk_size;

-(DOImage*) initWithObject:(NSDictionary *)o
{
    self.ID = [[o valueForKey:@"id"] longValue];
    self.name = [o valueForKey:@"name"];
    self.distribution = [o valueForKey:@"distribution"];
    self.slug = [o valueForKey:@"slug"];
    self.public = [[o valueForKey:@"public"] boolValue];
    self.regions = [o valueForKey:@"regions"];
    self.created_at = [o valueForKey:@"created_at"];
    self.type = [o valueForKey:@"type"];
    self.min_disk_size = [[o valueForKey:@"min_disk_size"] integerValue];
    return self;
}

@end
