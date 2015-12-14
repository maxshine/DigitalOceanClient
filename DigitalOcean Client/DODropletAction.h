//
//  DODopletAction.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DODropletAction : NSObject

@property (assign) long ID;
@property (copy) NSString* status;
@property (copy) NSString* type;
@property (copy) NSString* started_at;
@property (copy) NSString* completed_at;
@property (assign) long resource_id;
@property (retain) NSArray* resource_type;
@property (copy) NSString* region;
@property (copy) NSString* region_slug;

-(DODropletAction*)initWithObject:(NSDictionary*)o;

@end
