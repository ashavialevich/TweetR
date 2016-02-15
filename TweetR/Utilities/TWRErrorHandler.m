//
//  TWRErrorHandler.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRBaseViewController.h"
#import "TWRErrorHandler.h"
#import <UIKit/UIKit.h>

@implementation TWRErrorHandler

+ (void)handleGenericError:(nonnull NSError *)error context:(nonnull NSObject *)context {
    dispatch_async (dispatch_get_main_queue (), ^{
      if ([context isKindOfClass:[TWRBaseViewController class]]) {
          TWRBaseViewController *controller = (TWRBaseViewController *)context;
          NSString *alertTitle = NSLocalizedString (@"alert_view_generic_error_title", nil);
          NSString *alertMessate = error.localizedDescription;
          [controller showAlertWithTitle:alertTitle message:alertMessate];
      }
    });
}

@end
