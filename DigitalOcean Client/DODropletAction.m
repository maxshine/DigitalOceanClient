//
//  DODopletAction.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DODropletAction.h"

@implementation DODropletAction

@synthesize ID;
@synthesize started_at;
@synthesize completed_at;
@synthesize region;
@synthesize resource_id;
@synthesize resource_type;
@synthesize region_slug;
@synthesize status;
@synthesize type;

-(DODropletAction*)initWithObject:(NSDictionary*)o
{
    self.ID = [[o valueForKey:@"id"] longValue];
    self.type = [o valueForKey:@"type"];
    self.status = [o valueForKey:@"status"];
    self.resource_id = [[o valueForKey:@"resource_id"] longValue];
    self.resource_type  = [o valueForKey:@"resource_type"];
    self.started_at = [o valueForKey:@"started_at"];
    self.completed_at = [o valueForKey:@"completed_at"];
    self.region = [o valueForKey:@"region"];
    self.region_slug = [o valueForKey:@"region_slug"];
    
    return self;
}

@end
