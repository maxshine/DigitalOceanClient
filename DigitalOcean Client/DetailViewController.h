//
//  DetailViewController.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 10/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DODroplet.h"
#import "DORegion.h"
#import "DONetwork.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *dropletName;
@property (weak, nonatomic) IBOutlet UILabel *dropletConfiguration;
@property (weak, nonatomic) IBOutlet UILabel *createdTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *IPV4Configuration;
@property (weak, nonatomic) IBOutlet UILabel *IPV6Configuration;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(void) loadContentWithDropletDetails:(DODroplet*)droplet;

@end

