//
//  DORegion.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DORegion.h"

@implementation DORegion

@synthesize name;
@synthesize slug;
@synthesize sizes;
@synthesize features;
@synthesize available;


-(DORegion*)initWithObject:(NSDictionary *)o
{
    self.name = [o valueForKey:@"name"];
    self.slug = [o valueForKey:@"slug"];
    self.sizes = [o valueForKey:@"sizes"];
    self.features = [o valueForKey:@"features"];
    self.available = [[o valueForKey:@"available"] boolValue];
    return self;
}

@end
