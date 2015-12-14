//
//  DONetwork.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DONetwork.h"

@implementation DONetwork

@synthesize ip_address;
@synthesize netmask;
@synthesize gateway;
@synthesize type;
@synthesize family;


-(DONetwork*) initWithObject:(NSDictionary *)o
{
    self.ip_address = [o valueForKey:@"ip_address"];
    self.netmask = [o valueForKey:@"netmask"];
    self.gateway = [o valueForKey:@"gateway"];
    self.type = [o valueForKey:@"type"];
    self.family = @"V4";
    
    return self;
}



@end
