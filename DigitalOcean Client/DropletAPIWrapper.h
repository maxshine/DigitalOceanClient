//
//  DropletAPIWrapper.h
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DODroplet;
@class DOSnapshot;
@class DOBackup;
@class DODropletAction;

@interface DropletAPIWrapper : NSObject

+(NSArray<DODroplet*>*) listAllDroplets;
+(DODroplet*) getDropletById : (long) DropletId;
+(DODroplet*) createNewDroplet : (NSDictionary*) NewDropletProperties;
+(BOOL) deleteDroplet : (long) DropletId;
+(NSArray<DOSnapshot*>*) listSnapshotForDroplet : (long) DropletId;
+(NSArray<DOBackup*>*) listBackupForDroplet : (long) DropletId;
+(NSArray<DODropletAction*>*) listActionsForDroplet : (long) DropletId;

+(DODropletAction*) enableDropletBackup : (long) DropletId;
+(DODropletAction*) disableDropletBackup : (long) DropletId;
+(DODropletAction*) rebootDroplet : (long) DropletId;
+(DODropletAction*) powercycleDroplet : (long) DropletId;
+(DODropletAction*) shutdownDroplet : (long) DropletId;
+(DODropletAction*) poweroffDroplet : (long) DropletId;
+(DODropletAction*) poweronDroplet : (long) DropletId;
+(DODropletAction*) restoreDroplet : (long) DropletId withBackupID: (long) backupID;
+(DODropletAction*) passwordResetDroplet : (long) DropletId;
+(DODropletAction*) resizeDroplet : (long) DropletId withSize: (NSString*)size;
+(DODropletAction*) rebuildDroplet : (long) DropletId withImageName: (NSString*)name;
+(DODropletAction*) renameDroplet : (long) DropletId withName: (NSString*)name;
+(DODropletAction*) snapshotDroplet : (long) DropletId withName:(NSString*)name;
+(DODropletAction*) enableIP6Droplet : (long) DropletId;
+(DODropletAction*) checkActionStatus : (long) ActionId forDroplet : (long) DropletId;


@end
