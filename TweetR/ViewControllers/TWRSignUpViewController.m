//
//  TWRSignUpViewController.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRAuthenticationManager.h"
#import "TWRButton.h"
#import "TWRCompareValidator.h"
#import "TWRConstants.h"
#import "TWRCoreDataClient.h"
#import "TWRErrorHandler.h"
#import "TWRErrorProvider.h"
#import "TWRFeedViewController.h"
#import "TWRFonts.h"
#import "TWRFormView.h"
#import "TWRRegularExpressionValidator.h"
#import "TWRRequiredValidator.h"
#import "TWRSignUpViewController.h"
#import "TWRTextFormField.h"
#import "TWRUIConstants.h"
#import "TWRUser.h"
#import "TWRWebServiceClient.h"

@interface TWRSignUpViewController () <TWRErrorProviderDelegate, TWRTextFieldViewDelegate>

@property (strong, nonatomic) IBOutlet TWRTextFormField *usernameField;
@property (strong, nonatomic) IBOutlet TWRTextFormField *emailField;
@property (strong, nonatomic) IBOutlet TWRTextFormField *passwordField;
@property (strong, nonatomic) IBOutlet TWRTextFormField *confirmPasswordField;
@property (strong, nonatomic) IBOutlet TWRButton *signupButton;
@property (strong, nonatomic) IBOutlet TWRFormView *formView;
@property (strong, nonatomic) TWRCompareValidator *confirmPasswordValidator;
@property (assign, nonatomic) BOOL shouldShowFormErrorAlert;

@end

@implementation TWRSignUpViewController

#pragma mark - View Controller Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signupButton.type = TWRButtonTypeDisabledClickable;
    [self setupForm];
    [self.formView errorProvider].delegate = self;
}

#pragma mark - Instance Methods

- (void)setupForm {
    self.usernameField.textFieldHintText = NSLocalizedString (@"text_field_form_username_hint", nil);
    self.emailField.textFieldHintText = NSLocalizedString (@"text_field_form_email_hint", nil);
    self.passwordField.textFieldHintText = NSLocalizedString (@"text_field_form_password_hint", nil);
    self.confirmPasswordField.textFieldHintText = NSLocalizedString (@"text_field_form_confirm_password_hint", nil);
    [self setupFormValidators];
    self.usernameField.textFieldViewDelegate = self;
    self.emailField.textFieldViewDelegate = self;
    self.passwordField.textFieldViewDelegate = self;
    self.confirmPasswordField.textFieldViewDelegate = self;
}

- (void)setupFormValidators {
    [self.usernameField
        addValidator:[[TWRRequiredValidator alloc]
                         initWithErrorMessage:NSLocalizedString (@"text_field_form_username_empty_error", nil)]];
    [self.emailField
        addValidator:[[TWRRequiredValidator alloc]
                         initWithErrorMessage:NSLocalizedString (@"text_field_form_email_empty_error", nil)]];
    [self.emailField addValidator:[[TWRRegularExpressionValidator alloc]
                                      initWithPattern:TWR_EMAIL_REG_EX
                                         errorMessage:NSLocalizedString (@"text_field_form_email_invalid_error", nil)]];
    [self.passwordField
        addValidator:[[TWRRequiredValidator alloc]
                         initWithErrorMessage:NSLocalizedString (@"text_field_form_password_empty_error", nil)]];
    [self.confirmPasswordField
        addValidator:[[TWRRequiredValidator alloc]
                         initWithErrorMessage:NSLocalizedString (@"text_field_form_confirm_password_empty_error",
                                                                 nil)]];
    TWRCompareValidator *confirmPasswordValidator =
        [[TWRCompareValidator alloc] initWithCompareToValue:self.passwordField.textFieldText
                                               errorMessage:@"text_field_form_password_dont_match_error"];
    self.confirmPasswordValidator = confirmPasswordValidator;
    [self.confirmPasswordField addValidator:self.confirmPasswordValidator];
}

- (void)updateConfirmPasswordValidator:(TWRCompareValidator *)oldValidator
                          newValidator:(TWRCompareValidator *)newValidator {
    [self.confirmPasswordField removeValidator:oldValidator];
    [self.confirmPasswordField addValidator:newValidator];
}

#pragma - IBActions

- (IBAction)signupClick:(UIButton *)sender {
    self.shouldShowFormErrorAlert = YES;
    [self.formView requestValidation];
    if (![self.formView isValid]) {
        return;
    }
    [self displayOverLay];
    __weak __typeof__(self) weakSelf = self;
    [TWRWebServiceClient
        signupWithUsername:self.usernameField.textFieldText
                  password:self.passwordField.textFieldText
                     email:self.emailField.textFieldText
                   handler:^(BOOL succeeded, NSError *_Nullable error) {
                     [weakSelf hideOverlay];
                     if (error || !succeeded) {
                         [TWRErrorHandler handleGenericError:error context:weakSelf];
                         return;
                     }
                     [weakSelf dismissViewControllerAnimated:YES
                                                  completion:^{
                                                    dispatch_async (dispatch_get_main_queue (), ^{
                                                      [TWRAuthenticationManager proceedToApp];
                                                      [TWRCoreDataClient createUserIfNeeded:TWRUser.currentUser];
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
        self.signupButton.type = TWRButtonTypePrimary;
        return;
    }
    if (self.shouldShowFormErrorAlert) {
        self.signupButton.type = TWRButtonTypeDisabledClickable;
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
    if ([textFieldView isEqual:self.passwordField]) {
        TWRCompareValidator *confirmPasswordValidator = [[TWRCompareValidator alloc]
            initWithCompareToValue:self.passwordField.textFieldText
                      errorMessage:NSLocalizedString (@"text_field_form_password_dont_match_error", nil)];
        [self updateConfirmPasswordValidator:self.confirmPasswordValidator newValidator:confirmPasswordValidator];
        self.confirmPasswordValidator = confirmPasswordValidator;
    }
    [self.formView requestValidation];
}

@end
