//
//  Constants.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "Constants.h"
#import "DebugUtils.h"

static Constants* instance = nil;

@implementation Constants

@synthesize http_url_prefix;
@synthesize https_url_prefix;
@synthesize digitalocean_login_url;
@synthesize callback_url;
@synthesize token;
@synthesize refresh_token;
@synthesize user_email;
@synthesize user_name;
@synthesize user_uuid;
@synthesize auth_header;
@synthesize client_id;
@synthesize client_secrete;
@synthesize timeout;
@synthesize isAuthNeed;

+(Constants*) instance
{
    if (!instance) {
        instance = [super alloc];
        instance = [instance init];
    }
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init
{
    self = [super init];
    if (instance) {
        self.https_url_prefix = @"http://api.digitalocean.com";
        self.https_url_prefix = @"https://api.digitalocean.com";
        self.digitalocean_login_url = @"https://cloud.digitalocean.com/login";
        self.callback_url = @"https://myladder.techisfunny.info:8443/OauthHandlers/DigitalOceanHandler";
        self.client_id = @"5e0f0609064c54e048a91459037d04ee3a89337ebdd6f01c874505df161bd528";
        self.timeout = 15;
        self.isAuthNeed = NO;
        NSString* path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        NSData* data = [NSData dataWithContentsOfFile:path ];
        NSError * error = nil;
        NSPropertyListFormat format;
        NSDictionary* dict = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:&error];
        if (!dict) {
            NSLog(@"Error load property: %@", error);
        }
        
        self.token = [dict valueForKey:@"token"];
        self.refresh_token = [dict valueForKey:@"refresh_token"];
        self.user_name = [dict valueForKey:@"user_name"];
        self.user_email = [dict valueForKey:@"user_email"];
        self.user_uuid = [dict valueForKey:@"user_uuid"];
        
        self.auth_header = [[NSString alloc] initWithFormat:@"Bearer %@", self.token];
        return instance;
    }
    
    return self;
}

- (void) persist
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSError* error = nil;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:instance.token forKey:@"token"];
    [dict setValue:instance.token forKey:@"refresh_token"];
    [dict setValue:instance.token forKey:@"user_name"];
    [dict setValue:instance.token forKey:@"user_email"];
    [dict setValue:instance.token forKey:@"user_uuid"];
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:dict format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    if(!data) {
        NSLog(@"Error to transfrom plist into data : %@", error);
    }
    
    [data writeToFile:path atomically:true];
}

@end
