//
//  TWRAuthenticationManager.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRAuthenticationManager.h"
#import "TWRAuthenticationViewController.h"
#import "TWRFeedViewController.h"
#import <Parse/Parse.h>

static NSString *const AUTH_VIEW_CONTROLLER_NAME = @"TWRAuthenticationViewController";
static NSString *const USER_FEED_VIEW_CONTROLLER_NAME = @"TWRFeedViewController";

@implementation TWRAuthenticationManager

+ (void)handleAppLaunch {
    if ([PFUser currentUser]) {
        TWRFeedViewController *feedViewController =
            [[TWRFeedViewController alloc] initWithNibName:USER_FEED_VIEW_CONTROLLER_NAME bundle:nil];
        UINavigationController *navController =
            [[UINavigationController alloc] initWithRootViewController:feedViewController];
        [UIApplication sharedApplication].delegate.window.rootViewController = navController;
    } else {
        TWRAuthenticationViewController *authViewController =
            [[TWRAuthenticationViewController alloc] initWithNibName:AUTH_VIEW_CONTROLLER_NAME bundle:nil];
        UINavigationController *navController =
            [[UINavigationController alloc] initWithRootViewController:authViewController];
        [UIApplication sharedApplication].delegate.window.rootViewController = navController;
    }
}

+ (void)proceedToApp {
    UINavigationController *navController = [TWRAuthenticationManager getRootNavigationController];
    [navController pushViewController:[[TWRFeedViewController alloc] init] animated:YES];
}

+ (UINavigationController *)getRootNavigationController {
    UIViewController *appRootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([appRootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)appRootViewController;
    }
    return nil;
}

@end
