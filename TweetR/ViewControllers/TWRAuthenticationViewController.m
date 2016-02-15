//
//  TWRAuthenticationViewController.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRAuthenticationViewController.h"
#import "TWRButton.h"
#import "TWRSignInViewController.h"
#import "TWRSignUpViewController.h"
#import "TWRUIConstants.h"

@interface TWRAuthenticationViewController ()
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet TWRButton *signupButton;
@property (strong, nonatomic) IBOutlet TWRButton *signinButton;

@end

@implementation TWRAuthenticationViewController

#pragma mark - View Controller Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.signinButton.type = self.signupButton.type = TWRButtonTypeSecondary;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidDisappear:animated];
}

#pragma IBActions

- (IBAction)signInClick:(UIButton *)sender {
    [self presentViewcontroller:[TWRSignInViewController class]];
}

- (IBAction)signUpClick:(UIButton *)sender {
    [self presentViewcontroller:[TWRSignUpViewController class]];
}

@end
