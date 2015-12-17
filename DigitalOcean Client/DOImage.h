//
//  DOImage.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DOIMAGE_H

#define DOIMAGE_H

@interface DOImage : NSObject

@property (nonatomic, assign) long ID;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString*  distribution;
@property (nonatomic, copy) NSString* slug;
@property (nonatomic, assign) BOOL public;
@property (nonatomic, strong) NSArray<NSString*>* regions;
@property (nonatomic, copy) NSString* created_at;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, assign) int min_disk_size;

-(DOImage*) initWithObject:(NSDictionary*) o;

@end

#endif
