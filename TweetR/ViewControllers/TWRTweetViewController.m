//
//  TWRTweetViewController.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/7/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRButton.h"
#import "TWRColors.h"
#import "TWRCoreDataClient.h"
#import "TWRErrorHandler.h"
#import "TWRTweetViewController.h"
#import "TWRUIConstants.h"
#import "TWRWebServiceClient.h"
#import <Parse/Parse.h>

static NSInteger const TWEET_MAX_CHARACTERS = 140;

@interface TWRTweetViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *tweetTextField;
@property (strong, nonatomic) IBOutlet UIView *keyboardToolbarView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *keyboardToolbarBottomOffset;
@property (strong, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet TWRButton *tweetButton;
@property (strong, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation TWRTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.characterCountLabel.text = [NSString stringWithFormat:@"%ld", (long)TWEET_MAX_CHARACTERS];
    self.tweetButton.type = TWRButtonTypeDisabled;
    self.tweetTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

#pragma mark - IBActions

- (IBAction)closeVCClick:(UIButton *)sender {
    if (self.tweetTextField.isFirstResponder) {
        [self.tweetTextField resignFirstResponder];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postTweetClick:(UIButton *)sender {
    TWRTweet *newTweet = [[TWRTweet alloc] init];
    newTweet.user = [TWRUser currentUser];
    newTweet.tweetContent = self.tweetTextField.text;
    newTweet.isNew = YES;
    [self displayOverLay];
    __weak __typeof__(self) weakSelf = self;
    [TWRWebServiceClient postTweet:newTweet
                           handler:^(BOOL succeeded, NSError *_Nullable error) {
                             [weakSelf hideOverlay];
                             if (error) {
                                 [TWRErrorHandler handleGenericError:error context:weakSelf];
                                 return;
                             }
                             [weakSelf dismissViewControllerAnimated:YES completion:nil];
                           }];
}

#pragma mark - UITextViewDelegate Methods

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView isEqual:self.tweetTextField]) {
        BOOL textExists = textView.text.length > 0;
        self.placeholderLabel.hidden = textExists;
        NSInteger charachtersLeft = TWEET_MAX_CHARACTERS - textView.text.length;
        self.characterCountLabel.text = [NSString stringWithFormat:@"%ld", (long)charachtersLeft];
        self.tweetButton.type = textExists ? TWRButtonTypePrimary : TWRButtonTypeDisabled;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger oldLength = [textView.text length];
    NSUInteger replacementLength = [text length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    BOOL returnKey = [text rangeOfString:@"\n"].location != NSNotFound;
    return newLength <= TWEET_MAX_CHARACTERS || returnKey;
}

#pragma mark - Instance Methods

- (void)keyboardWillShow:(NSNotification *)notification {
    NSTimeInterval animationDuration =
        [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardBounds =
        [(NSValue *)[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [self showToolbarForKeyboardBounds:keyboardBounds animationDuration:animationDuration];
}

- (void)showToolbarForKeyboardBounds:(CGRect)keyboardBounds animationDuration:(NSTimeInterval)animationDuration {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:animationDuration
                     animations:^{
                       self.keyboardToolbarBottomOffset.constant = keyboardBounds.size.height;
                       [self.view layoutIfNeeded];
                     }];
}

@end
