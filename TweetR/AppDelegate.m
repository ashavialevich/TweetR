//
//  AppDelegate.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "AppDelegate.h"
#import "TWRAuthenticationManager.h"
#import "TWRDataStore.h"
#import "TWRWebServiceClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TWRWebServiceClient installWebHooks];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [TWRAuthenticationManager handleAppLaunch];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[TWRDataStore sharedInstance] saveContext];
}

@end
