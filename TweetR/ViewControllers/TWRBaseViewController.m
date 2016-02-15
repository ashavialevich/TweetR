//
//  TWRBaseViewController.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRBaseViewController.h"
#import "TWRErrorHandler.h"

static CGFloat const BAR_BUTTON_HEIGHT = 40.0f;
static CGFloat const BAR_BUTTON_WIDTH = 40.0f;

@interface TWRBaseViewController ()

@property (strong, nonatomic) UIView *loadingOverlay;

@end

@implementation TWRBaseViewController

#pragma mark - View Controller Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Instance Methods

- (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake (0, 0, BAR_BUTTON_HEIGHT, BAR_BUTTON_WIDTH)];
    return button;
}

- (void)pushViewController:(Class)vcClass {
    if ([vcClass isSubclassOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
    }
}

- (void)presentViewcontroller:(Class)vcClass {
    if ([vcClass isSubclassOfClass:[UIViewController class]]) {
        [self.navigationController presentViewController:[[vcClass alloc] init] animated:YES completion:nil];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    NSString *defaultActionTitle = NSLocalizedString (@"ok", "OK");
    UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction =
        [UIAlertAction actionWithTitle:defaultActionTitle style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:defaultAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showGenericErrorAlertView {
    NSString *alertTitle = NSLocalizedString (@"alert_view_generic_error_title", "We Are Sorry...");
    NSString *alertMessage
        = NSLocalizedString (@"alert_view_generic_error_message",
                             @"Something with our services isn't working. We appologize for any inconveniences as our "
                             @"team is making every effort to fix the issue. Please try again later.");
    [self showAlertWithTitle:alertTitle message:alertMessage];
}

- (void)displayOverLay {
    UIView *loadingOverlay = [[UIView alloc] initWithFrame:self.view.frame];
    loadingOverlay.backgroundColor = [UIColor blackColor];
    loadingOverlay.alpha = 0.5;
    [self.view addSubview:loadingOverlay];
    self.loadingOverlay = loadingOverlay;
}

- (void)hideOverlay {
    [self.loadingOverlay removeFromSuperview];
}

@end
