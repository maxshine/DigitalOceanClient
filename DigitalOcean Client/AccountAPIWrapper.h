//
//  AccountAPIWrapper.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Constants.h"
#import "APIInvoker.h"
#import "DebugUtils.h"

#ifndef ACCOUNTAPIWRAPPER_H

#define ACCOUNTAPIWRAPPER_H

@interface AccountAPIWrapper : NSObject

+(NSDictionary*) getAccountDetails;

@end
#endif
