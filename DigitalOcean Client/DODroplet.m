//
//  Droplet.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DODroplet.h"
#import "DOImage.h"
#import "DONetwork.h"
#import "DORegion.h"

@implementation DODroplet

@synthesize ID;
@synthesize name;
@synthesize memory;
@synthesize vcpus;
@synthesize disk;
@synthesize locked;
@synthesize created_at;
@synthesize status;
@synthesize backup_ids;
@synthesize snapshot_ids;
@synthesize features;
@synthesize image;
@synthesize size_slug;
@synthesize v4_networks;
@synthesize v6_networks;
@synthesize region;

-(DODroplet*) initWithObject:(NSDictionary *)o
{
    self.ID = [[o valueForKey:@"id"] longValue];
    self.name = [o valueForKey:@"name"];
    self.memory = [[o valueForKey:@"memory"] integerValue];
    self.size_slug = [[o valueForKey:@"size"] valueForKey:@"slug"];
    self.vcpus = [[o valueForKey:@"vcpus"] integerValue];
    self.disk = [[o valueForKey:@"disk"] integerValue];
    self.locked = [[o valueForKey:@"locked"] boolValue];
    self.created_at = [o valueForKey:@"created_at"];
    self.status = [o valueForKey:@"status"];
    self.backup_ids = [NSMutableArray arrayWithArray:[o valueForKey:@"backup_ids"]];
    self.snapshot_ids = [NSMutableArray arrayWithArray:[o valueForKey:@"snapshot_ids"]];
    self.features = [NSMutableArray arrayWithArray:[o valueForKey:@"features"]];
    self.image = [[DOImage alloc] initWithObject:[o valueForKey:@"image"]];
    NSArray* _v4_networks = [[o valueForKey:@"networks"] valueForKey:@"v4"];
    NSArray* _v6_networks = [[o valueForKey:@"networks"] valueForKey:@"v6"];
    self.v4_networks = [[NSMutableArray alloc] init];
    self.v6_networks = [[NSMutableArray alloc] init];
    NSUInteger i = 0;
    while (i < [_v4_networks count]) {
        DONetwork* n = [[DONetwork alloc] initWithObject:[_v4_networks objectAtIndex:i]];
        n.family = @"V4";
        [self.v4_networks addObject:n];
        i++;
    }
    i = 0;
    while (i < [_v6_networks count]) {
        DONetwork* n = [[DONetwork alloc] initWithObject:[_v6_networks objectAtIndex:i]];
        n.family = @"V6";
        [self.v6_networks addObject:n];
        i++;
    }
    self.region = [[DORegion alloc] initWithObject:[o valueForKey:@"region"]];
        
    return self;
}

@end
