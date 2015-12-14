//
//  MasterViewController.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 10/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DODroplet.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, atomic)  NSArray<DODroplet*>* dropletList;

@end

