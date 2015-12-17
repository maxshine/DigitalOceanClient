//
//  Constants.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef CONSTANTS_H

#define CONSTANTS_H

@interface Constants : NSObject

+(Constants*) instance;
-(void) persist;

@property (copy) NSString* http_url_prefix;
@property (copy) NSString* https_url_prefix;
@property (copy, atomic) NSString* auth_header;
@property (copy, atomic) NSString* token;
@property (copy, atomic) NSString* refresh_token;
@property (copy) NSString* callback_url;
@property (copy) NSString* client_id;
@property (copy) NSString* client_secrete;
@property (copy) NSString* digitalocean_login_url;
@property (copy, atomic) NSString* user_name;
@property (copy, atomic) NSString* user_email;
@property (copy, atomic) NSString* user_uuid;
@property (assign) NSUInteger timeout;
@property (assign, atomic) BOOL isAuthNeed;

@end
#endif

