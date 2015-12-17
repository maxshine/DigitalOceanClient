//
//  DONetwork.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/5/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DONETWORK_H

#define DONETWORK_H

@interface DONetwork : NSObject

@property (nonatomic, copy) NSString* ip_address;
@property (nonatomic, copy) NSString* netmask;
@property (nonatomic, copy) NSString* gateway;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* family;

-(DONetwork*) initWithObject:(NSDictionary *)o;

@end
#endif

