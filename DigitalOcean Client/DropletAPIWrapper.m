//
//  DropletAPIWrapper.m
//  DigitalOcean Client
//
//  Created by Gao Yang on 11/12/15.
//  Copyright © 2015 Personal. All rights reserved.
//

#import "DropletAPIWrapper.h"


@implementation DropletAPIWrapper


+(DODroplet*)createNewDroplet:(NSDictionary *)NewDropletProperties
{
    [DebugUtils method_entry:__FILE__ :__func__];
    if ([NSJSONSerialization isValidJSONObject:NewDropletProperties])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:NewDropletProperties options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@", const_inst.https_url_prefix, @"/v2/droplets"] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"droplet"];
        DODroplet* droplet = [[DODroplet alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(BOOL)deleteDroplet: (long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"DELETE"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@/%@", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:nil];
    [invoker invoke];

    [DebugUtils method_exit:__FILE__ :__func__];
    if ([(NSHTTPURLResponse*)[invoker response] statusCode] == 204) {
        return true;
    }
    return false;
    
}

+(DODroplet*)getDropletById:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@/%@", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:nil];
    [invoker invoke];

    NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"droplet"];
    DODroplet* droplet = [[DODroplet alloc] initWithObject:result];
    [DebugUtils method_exit:__FILE__ :__func__];
    return droplet;
}

+(NSArray<DODroplet*>*) listAllDroplets;
{
    
    [DebugUtils method_entry:__FILE__ :__func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@", const_inst.https_url_prefix, @"/v2/droplets"] withHeaders:headers withData:nil];
    [invoker invoke];
    
    NSArray* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"droplets"];
    NSMutableArray<DODroplet*>* droplets = [[NSMutableArray array] init];
    NSUInteger i = 0;
    while (i < [result count]) {
        NSDictionary* o = [result objectAtIndex:i];
        DODroplet* droplet = [[DODroplet alloc] initWithObject:o];
        [droplets addObject:droplet];
        i++;
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return droplets;
    
}

+(NSArray<DODropletAction*>*) listActionsForDroplet : (long) DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:nil];
    [invoker invoke];

    NSArray* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"actions"];
    NSMutableArray<DODropletAction*>* actions = [[NSMutableArray array] init];
    NSUInteger i = 0;
    while (i < [result count]) {
        NSDictionary* o = [result objectAtIndex:i];
        DODropletAction* action = [[DODropletAction alloc] initWithObject:o];
        [actions addObject:action];
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return actions;
}

+(NSArray<DOSnapshot*>*) listSnapshotForDroplet : (long) DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/snapshots", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:nil];
    [invoker invoke];

    NSArray* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"snapshots"];
    NSMutableArray<DOSnapshot*>* snapshots = [[NSMutableArray array] init];
    NSUInteger i = 0;
    while (i < [result count]) {
        NSDictionary* o = [result objectAtIndex:i];
        DOSnapshot* snapshot = [[DOSnapshot alloc] initWithObject:o];
        [snapshots addObject:snapshot];
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return snapshots;
}
+(NSArray<DOBackup*>*) listBackupForDroplet : (long) DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                           withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/backups", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:nil];
    [invoker invoke];

    NSArray* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"backups"];
    NSMutableArray<DOBackup*>* backups = [[NSMutableArray array] init];
    NSUInteger i = 0;
    while (i < [result count]) {
        NSDictionary* o = [result objectAtIndex:i];
        DOBackup* backup = [[DOBackup alloc] initWithObject:o];
        [backups addObject:backup];
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return backups;
}

+(DODropletAction*) enableDropletBackup : (long) DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"enable_backups" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) disableDropletBackup:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"disable_backups" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) rebootDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"reboot" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) powercycleDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"power_cycle" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) shutdownDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"shutdown" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) poweroffDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"power_off" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) poweronDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"power_on" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) enableIP6Droplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"enable_ipv6" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) passwordResetDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"password_reset" forKey:@"type"];
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) snapshotDroplet:(long)DropletId withName:(NSString *)name
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"password_reset" forKey:@"type"];
    [post_body setValue:name forKey:@"name"];
    
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) renameDroplet:(long)DropletId withName:(NSString *)name
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"rename" forKey:@"type"];
    [post_body setValue:name forKey:@"name"];
    
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) rebuildDroplet:(long)DropletId withImageName:(NSString *)name
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"rebuild" forKey:@"type"];
    [post_body setValue:name forKey:@"name"];
    
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) restoreDroplet:(long)DropletId withBackupID:(long)backupID
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"restore" forKey:@"type"];
    [post_body setValue:[[NSNumber alloc] initWithLong:backupID] forKey:@"image"];
    
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) resizeDroplet:(long)DropletId withSize:(NSString *)size
{
    [DebugUtils method_entry:__FILE__ :__func__];
    NSDictionary* post_body = [[NSDictionary alloc] init];
    [post_body setValue:@"resize" forKey:@"type"];
    [post_body setValue:size forKey:@"size"];
    [post_body setValue:[[NSNumber alloc] initWithBool:true] forKey:@"disk"];
    
    if ([NSJSONSerialization isValidJSONObject:post_body])
    {
        NSData* data = [NSJSONSerialization dataWithJSONObject:post_body options:0 error:nil];
        NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
        Constants* const_inst = [Constants instance];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:const_inst.auth_header forKey:@"Authorization"];
        APIInvoker* invoker = [[APIInvoker alloc] init:@"POST"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue]] withHeaders:headers withData:data];
        [invoker invoke];

        NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
        DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
        return droplet;
        
    }
    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

+(DODropletAction*) checkActionStatus:(long)ActionId forDroplet:(long)DropletId
{
    [DebugUtils method_entry:__FILE__ :__func__];
    
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    Constants* const_inst = [Constants instance];
    [headers setValue:@"application/json" forKey:@"Content-Type"];
    [headers setValue:const_inst.auth_header forKey:@"Authorization"];
    APIInvoker* invoker = [[APIInvoker alloc] init:@"GET"
                                               withURL:[[NSString alloc] initWithFormat:@"%@%@/%@/actions/%@", const_inst.https_url_prefix, @"/v2/droplets", [[[NSNumber alloc] initWithLong:DropletId] stringValue], [[[NSNumber alloc] initWithLong:ActionId] stringValue]] withHeaders:headers withData:nil];
    [invoker invoke];

    NSDictionary* result = [[invoker.response valueForKey:@"json body"] valueForKey:@"action"];
    DODropletAction* droplet = [[DODropletAction alloc] initWithObject:result];
    return droplet;

    [DebugUtils method_exit:__FILE__ :__func__];
    return nil;
}

@end
