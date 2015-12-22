//
//  DetailViewController.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 10/30/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@property (strong, nonatomic) NSArray* actions;

@end

@implementation DetailViewController

@synthesize currentDroplet;
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
    [self loadContentWithCurrentDropletDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadContentWithCurrentDropletDetails
{
    if (self.currentDroplet) {
        NSString* green_path = [[NSBundle mainBundle] pathForResource:@"green" ofType:@"png"];
        NSString* red_path = [[NSBundle mainBundle] pathForResource:@"red" ofType:@"png"];
        NSString* black_path = [[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"];
        UIImage* image = nil;
        if (self.currentDroplet.locked) {
            image = [UIImage imageWithContentsOfFile:black_path];
        } else if ([self.currentDroplet.status compare:@"active"] == NSOrderedSame) {
            image = [UIImage imageWithContentsOfFile:green_path];
        } else {
            image = [UIImage imageWithContentsOfFile:red_path];
        }
        self.statusImage.image = image;
        
        self.dropletName.text = self.currentDroplet.name;
        self.dropletConfiguration.text = [NSString stringWithFormat:@"%d cores/ %@ / %d GB / %@", self.currentDroplet.vcpus, self.currentDroplet.size_slug, self.currentDroplet.disk, self.currentDroplet.region.slug];
        self.createdTimestamp.text = self.currentDroplet.created_at;
        if (self.currentDroplet.v4_networks.count > 0) {
            for (DONetwork* n in self.currentDroplet.v4_networks) {
                if ([n.type compare:@"public"] == NSOrderedSame) {
                    self.IPV4Configuration.text = n.ip_address;
                    break;
                }
            }
        } else {
            self.IPV4Configuration.text = @"No Public IPV4 Network";
        }
        if (self.currentDroplet.v6_networks.count > 0) {
            for (DONetwork* n in self.currentDroplet.v6_networks) {
                if ([n.type compare:@"public"] == NSOrderedSame) {
                    self.IPV6Configuration.text = n.ip_address;
                    break;
                }
            }
        } else {
            self.IPV6Configuration.text = @"No Public IPV6 Network";
        }
    }
}


-(void) loadContentWithDropletDetails:(DODroplet *)droplet
{
    self.currentDroplet = droplet;
    NSString* green_path = [[NSBundle mainBundle] pathForResource:@"green" ofType:@"png"];
    NSString* red_path = [[NSBundle mainBundle] pathForResource:@"red" ofType:@"png"];
    NSString* black_path = [[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"];
    UIImage* image = nil;
    if (self.currentDroplet.locked) {
        image = [UIImage imageWithContentsOfFile:black_path];
    } else if ([self.currentDroplet.status compare:@"active"] == NSOrderedSame) {
        image = [UIImage imageWithContentsOfFile:green_path];
    } else {
        image = [UIImage imageWithContentsOfFile:red_path];
    }
    self.statusImage.image = image;
    
    self.dropletName.text = self.currentDroplet.name;
    self.dropletConfiguration.text = [NSString stringWithFormat:@"%d cores/ %@ / %d GB / %@", self.currentDroplet.vcpus, self.currentDroplet.size_slug, self.currentDroplet.disk, self.currentDroplet.region.slug];
    self.createdTimestamp.text = self.currentDroplet.created_at;
    if (self.currentDroplet.v4_networks.count > 0) {
        for (DONetwork* n in self.currentDroplet.v4_networks) {
            if ([n.type compare:@"public"] == NSOrderedSame) {
                self.IPV4Configuration.text = n.ip_address;
                break;
            }
        }
    } else {
        self.IPV4Configuration.text = @"No Public IPV4 Network";
    }
    if (self.currentDroplet.v6_networks.count > 0) {
        for (DONetwork* n in self.currentDroplet.v6_networks) {
            if ([n.type compare:@"public"] == NSOrderedSame) {
                self.IPV6Configuration.text = n.ip_address;
                break;
            }
        }
    } else {
        self.IPV6Configuration.text = @"No Public IPV6 Network";
    }
}

- (IBAction)ActionSubmit:(id)sender {
    NSInteger selectedIndex = [self.ActionPickerView selectedRowInComponent:0];
    DODropletAction* action = nil;
    DODroplet* droplet = nil;
    UIAlertController* successAlert = [UIAlertController alertControllerWithTitle:@"Success" message:@"The operation is Done" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* successAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [successAlert addAction:successAction];
    
    UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"The operation may encouneter problem" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* errorAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [errorAlert addAction:errorAction];
    
    if (selectedIndex != -1 && self.currentDroplet != nil) {
        switch ((enum DropletActionsEnumeration)selectedIndex) {
            case POWERON:
                action = [DropletAPIWrapper poweronDroplet:self.currentDroplet.ID];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                droplet = [DropletAPIWrapper getDropletById:self.currentDroplet.ID];
                [self loadContentWithDropletDetails:droplet];
                break;
            case POWEROFF:
                action = [DropletAPIWrapper poweroffDroplet:self.currentDroplet.ID];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                droplet = [DropletAPIWrapper getDropletById:self.currentDroplet.ID];
                [self loadContentWithDropletDetails:droplet];
                break;
            case POWERCYCLE:
                action = [DropletAPIWrapper powercycleDroplet:self.currentDroplet.ID];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                droplet = [DropletAPIWrapper getDropletById:self.currentDroplet.ID];
                [self loadContentWithDropletDetails:droplet];
                break;
            case REBOOT:
                action = [DropletAPIWrapper rebootDroplet:self.currentDroplet.ID];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                droplet = [DropletAPIWrapper getDropletById:self.currentDroplet.ID];
                [self loadContentWithDropletDetails:droplet];
                break;
            case SHUTDOWN:
                action = [DropletAPIWrapper shutdownDroplet:self.currentDroplet.ID];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                droplet = [DropletAPIWrapper getDropletById:self.currentDroplet.ID];
                [self loadContentWithDropletDetails:droplet];
                break;
            case RENAME:
                action = [DropletAPIWrapper renameDroplet:self.currentDroplet.ID withName:@""];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                droplet = [DropletAPIWrapper getDropletById:self.currentDroplet.ID];
                [self loadContentWithDropletDetails:droplet];
                break;
            case RESIZE:
                break;
            case RESTORE:
                break;
            case PASSWORDRESET:
                action = [DropletAPIWrapper passwordResetDroplet:self.currentDroplet.ID];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                break;
            case UPGRADE:
                break;
            case TAKESNAPSHOT:
                action = [DropletAPIWrapper snapshotDroplet:self.currentDroplet.ID withName:@""];
                if ([self checkStatusForDropletAction:action.ID OnDroplet:self.currentDroplet.ID atInverval:3.0 untilTimeout:30.0]) {
                    [self presentViewController:successAlert animated:YES completion:nil];
                } else {
                    [self presentViewController:errorAlert animated:YES completion:nil];
                }
                break;
            default:
                break;
        }
    }
}

- (BOOL)checkStatusForDropletAction: (long)actionId OnDroplet: (long)dropletId atInverval: (NSTimeInterval)interval untilTimeout: (NSTimeInterval)timeout
{
    NSTimeInterval i = 0;
    enum DropletActionsEnumeration status = [DropletAPIWrapper checkActionStatus:actionId forDroplet:dropletId];
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.hidesWhenStopped = YES;
    [spinner startAnimating];
    while (i <= timeout && status != COMPLETED) {
        [NSThread sleepForTimeInterval:interval];
        status = [DropletAPIWrapper checkActionStatus:actionId forDroplet:dropletId];
        i += interval;
    }
    [spinner stopAnimating];
    if (i > timeout) {
        return NO;
    }
    return YES;
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
