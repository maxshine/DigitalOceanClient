//
//  AuthenticationWebView.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 12/4/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "AuthenticationWebView.h"
#import "Constants.h"

@implementation UIView(muv)

- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end

@implementation AuthenticationWebView
@synthesize data;
@synthesize isAuthDone;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.isAuthDone = NO;

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    Constants* const_inst = [Constants instance];
    if ([request.URL.absoluteString compare:@"https://cloud.digitalocean.com/"] == NSOrderedSame)
    {
        Constants* const_inst = [Constants instance];
        NSString* str = [[[NSString alloc] initWithFormat:@"https://cloud.digitalocean.com/v1/oauth/authorize?client_id=%@&scope=read write&redirect_uri=%@&response_type=code", const_inst.client_id, const_inst.callback_url] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        return NO;
    }
    
    if ([request.URL.absoluteString hasPrefix:const_inst.callback_url])
    {
        [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        return NO;
    }
    return YES;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    NSURLCredential *cred;
    cred = [NSURLCredential credentialForTrust:trust];
    [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data
{
    if (!self.data)
    {
        self.data = [NSMutableData dataWithData:_data];
    }
    else
    {
        [self.data appendData:_data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    Constants* const_inst = [Constants instance];
    if (self.data.length > 0)
    {
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:NULL];
        const_inst.token = [obj valueForKey:@"access_token"];
        const_inst.refresh_token = [obj valueForKey:@"refresh_token"];
        NSDictionary* user_obj = [obj valueForKey:@"info"];
        const_inst.user_name = [user_obj valueForKey:@"user_name"];
        const_inst.user_email = [user_obj valueForKey:@"user_email"];
        const_inst.user_uuid = [user_obj valueForKey:@"user_uuid"];
        if (const_inst.token != nil)
        {
            const_inst.auth_header = [[NSString alloc] initWithFormat:@"Bearer %@", const_inst.token];
            const_inst.isAuthNeed = NO;
            self.isAuthDone = YES;
            id responder = [self firstAvailableUIViewController];
            [(UIViewController*) responder dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


@end
