//
//  TWRSignInViewController.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/7/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRAuthenticationManager.h"
#import "TWRButton.h"
#import "TWRCoreDataClient.h"
#import "TWRErrorHandler.h"
#import "TWRErrorProvider.h"
#import "TWRFeedViewController.h"
#import "TWRFormView.h"
#import "TWRRequiredValidator.h"
#import "TWRSignInViewController.h"
#import "TWRTextFormField.h"
#import "TWRUIConstants.h"
#import "TWRWebServiceClient.h"

@interface TWRSignInViewController () <TWRErrorProviderDelegate, TWRTextFieldViewDelegate>

@property (strong, nonatomic) IBOutlet TWRFormView *formView;
@property (strong, nonatomic) IBOutlet TWRTextFormField *usernameField;
@property (strong, nonatomic) IBOutlet TWRTextFormField *passwordField;
@property (strong, nonatomic) IBOutlet TWRButton *signInButton;
@property (assign, nonatomic) BOOL shouldShowFormErrorAlert;

@end

@implementation TWRSignInViewController

#pragma mark - View Controller Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInButton.type = TWRButtonTypeDisabledClickable;
    [self setupForm];
    [self.formView errorProvider].delegate = self;
}

#pragma mark - Instance Methods

- (void)setupForm {
    self.usernameField.textFieldHintText = NSLocalizedString (@"text_field_form_username_hint", nil);
    self.passwordField.textFieldHintText = NSLocalizedString (@"text_field_form_password_hint", nil);
    [self setupFormValidators];
    self.usernameField.textFieldViewDelegate = self;
    self.passwordField.textFieldViewDelegate = self;
}

- (void)setupFormValidators {
    [self.usernameField
        addValidator:[[TWRRequiredValidator alloc]
                         initWithErrorMessage:NSLocalizedString (@"text_field_form_username_empty_error", nil)]];
    [self.passwordField
        addValidator:[[TWRRequiredValidator alloc]
                         initWithErrorMessage:NSLocalizedString (@"text_field_form_password_empty_error", nil)]];
}

#pragma mark - IBActions

- (IBAction)singinClick:(UIButton *)sender {
    self.shouldShowFormErrorAlert = YES;
    [self.formView requestValidation];
    if (![self.formView isValid]) {
        return;
    }
    [self displayOverLay];
    __weak __typeof__(self) weakSelf = self;
    [TWRWebServiceClient
        signInWithUsername:self.usernameField.textFieldText
                  password:self.passwordField.textFieldText
                   handler:^(BOOL succeeded, NSError *_Nullable error) {
                     [weakSelf hideOverlay];
                     if (error) {
                         [TWRErrorHandler handleGenericError:error context:weakSelf];
                         return;
                     }
                     [weakSelf dismissViewControllerAnimated:YES
                                                  completion:^{
                                                    dispatch_async (dispatch_get_main_queue (), ^{
                                                      [TWRCoreDataClient createUserIfNeeded:TWRUser.currentUser];
                                                      [TWRAuthenticationManager proceedToApp];
                                                    });
                                                  }];
                   }];
}

- (IBAction)closeButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TWRErrorProviderDelegate

- (void)validationStateChanged:(__unused TWRErrorProvider *)errorProvider
                         state:(BOOL)valid
                 errorMessages:(NSArray<NSString *> *)errorMessages {
    if (valid) {
        self.signInButton.type = TWRButtonTypePrimary;
        return;
    }
    if (self.shouldShowFormErrorAlert) {
        self.signInButton.type = TWRButtonTypeDisabledClickable;
        NSSet *errorSet = [NSSet setWithArray:errorMessages];
        NSString *alertTitle = NSLocalizedString (@"text_field_form_error_title", nil);
        NSString *alertMessage;
        if ([errorSet count] == 1) {
            alertMessage = [errorSet anyObject];
        } else {
            alertMessage = NSLocalizedString (@"text_field_form_multiple_error", nil);
        }
        [self showAlertWithTitle:alertTitle message:alertMessage];
    }
    self.shouldShowFormErrorAlert = NO;
}

#pragma mark - TWRTextFieldViewDelegate Methods

- (void)textFieldViewDidEndEditing:(TWRTextFormField *)textFieldView {
    [self.formView requestValidation];
}

@end
