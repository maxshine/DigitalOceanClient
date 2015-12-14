//
//  AuthenticationViewController.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 12/3/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "Constants.h"
@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Constants* const_inst = [Constants instance];
    webView.delegate = (id<UIWebViewDelegate>) webView;

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:const_inst.digitalocean_login_url]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
