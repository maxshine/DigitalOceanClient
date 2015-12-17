//
//  DetailViewController.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 10/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DetailViewController.h"
#import "Constants.h"

@interface DetailViewController ()

@property (strong, nonatomic) NSArray* actions;

@end

@implementation DetailViewController

@synthesize statusImage;
@synthesize dropletName;
@synthesize dropletConfiguration;
@synthesize createdTimestamp;
@synthesize IPV4Configuration;
@synthesize IPV6Configuration;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([Constants instance].isAuthNeed) {
        [self performSegueWithIdentifier:@"AuthenticationSegue" sender:self];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.actions = @[@"Power On", @"Power Off", @"Power Cycle", @"Reboot", @"Shutdown", @"Password Reset", @"Resize", @"Restore", @"Rename", @"Upgrade", @"Take snapshot"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadContentWithDropletDetails:(DODroplet *)droplet
{
    NSString* green_path = [[NSBundle mainBundle] pathForResource:@"green" ofType:@"png"];
    NSString* red_path = [[NSBundle mainBundle] pathForResource:@"red" ofType:@"png"];
    NSString* black_path = [[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"];
    UIImage* image = nil;
    if (droplet.locked) {
        image = [UIImage imageWithContentsOfFile:black_path];
    } else if ([droplet.status compare:@"active"] == NSOrderedSame) {
        image = [UIImage imageWithContentsOfFile:green_path];
    } else {
        image = [UIImage imageWithContentsOfFile:red_path];
    }
    self.statusImage.image = image;
    
    self.dropletName.text = droplet.name;
    self.dropletConfiguration.text = [NSString stringWithFormat:@"%d cores/ %@ / %d GB / %@", droplet.vcpus, droplet.size_slug, droplet.disk, droplet.region.slug];
    self.createdTimestamp.text = droplet.created_at;
    if (droplet.v4_networks.count > 0) {
        for (DONetwork* n in droplet.v4_networks) {
            if ([n.type compare:@"public"] == NSOrderedSame) {
                self.IPV4Configuration.text = n.ip_address;
                break;
            }
        }
    } else {
        self.IPV4Configuration.text = @"No Public IPV4 Network";
    }
    if (droplet.v6_networks.count > 0) {
        for (DONetwork* n in droplet.v6_networks) {
            if ([n.type compare:@"public"] == NSOrderedSame) {
                self.IPV6Configuration.text = n.ip_address;
                break;
            }
        }
    } else {
        self.IPV6Configuration.text = @"No Public IPV6 Network";
    }
    
}

#pragma mark - Picker View Datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.actions.count;
}

#pragma mark - Picker View Delegate

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.actions[row];
}

@end
