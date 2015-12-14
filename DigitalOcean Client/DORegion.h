//
//  DORegion.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DORegion : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* slug;
@property (nonatomic, strong) NSArray<NSString*>* sizes;
@property (nonatomic, strong) NSArray<NSString*>* features;
@property (nonatomic, assign) BOOL available;

-(DORegion*) initWithObject:(NSDictionary*)o;


@end
