//
//  AuthenticationWebView.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 12/4/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationWebView : UIWebView <UIWebViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (atomic, strong) NSMutableData* data;
@property (atomic, assign) BOOL isAuthDone;

@end
