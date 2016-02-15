//
//  TWRTextFormField.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/14/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRTextFormField.h"
#import "TWRColors.h"
#import "TWRFonts.h"

static NSString *const NIB_NAME = @"TWRTextFormField";

@interface TWRTextFormField ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIView *dividerView;

@end

@implementation TWRTextFormField

@synthesize textFieldFont = _textFieldFont, textFieldHintText = _textFieldHintText;

#pragma mark - Accessors Public

- (UIKeyboardType)keyboardType {
    return self.textField.keyboardType;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.textField.keyboardType = keyboardType;
}

- (UIFont *)textFieldFont {
    if (_textFieldFont == nil) {
        _textFieldFont = TWR_FONT_REGULAR;
    }
    return _textFieldFont;
}

- (void)setTextFieldFont:(UIFont *)textFieldFont {
    _textFieldFont = textFieldFont;
    self.textField.font = _textFieldFont;
}

- (NSString *)textFieldHintText {
    return self.textField.placeholder;
}

- (void)setTextFieldHintText:(NSString *)textFieldHintText {
    self.textField.placeholder = textFieldHintText;
}

- (NSString *)textFieldText {
    return self.textField.text;
}

- (void)setTextFieldText:(NSString *)textFieldText {
    BOOL requiresValidation = ![self isValid];
    self.textField.text = textFieldText;
    if (requiresValidation) {
        [self requestValidation];
    }
}

#pragma mark - Initializers
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        [bundle loadNibNamed:NIB_NAME owner:self options:nil];
        [_view setFrame:[self bounds]];
        [self addSubview:self.view];
        [self setTextFieldDelegate:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        [bundle loadNibNamed:NIB_NAME owner:self options:nil];
        [_view setFrame:[self bounds]];
        [self addSubview:self.view];
        [self setTextFieldDelegate:self];
    }
    return self;
}

#pragma mark - Public API

- (void)setTextFieldDelegate:(nullable id<UITextFieldDelegate>)delegate {
    if ([delegate conformsToProtocol:@protocol (UITextFieldDelegate)]) {
        self.textField.delegate = delegate;
    }
}

- (BOOL)textFieldHasFocus {
    return [self.textField isFirstResponder];
}

- (void)loseFocus {
    if (![self isValid]) {
        [self requestValidation];
    }
    [self.textField resignFirstResponder];
}

/**
 @abstract changes the field color to pale red and the red colored bottom border line if invalid.
 changes back to default if isValid
 @discussion call this method evrytime the validation is performed
 */
- (void)checkAndUpdateState:(BOOL)isValid {
    static int invalidCount = 0;
    if (isValid && invalidCount > 0) {
        [self.view setBackgroundColor:[UIColor clearColor]];
        [self.dividerView setBackgroundColor:[UIColor lightGrayColor]];
    } else if (!isValid) {
        invalidCount++;
        [self.view setBackgroundColor:TWRUIColorFromRGB (TWR_FORM_FIELD_ERROR)];
        [self.dividerView setBackgroundColor:[UIColor redColor]];
    }
}

#pragma mark - Override TDBaseFormFieldView

- (nullable NSObject *)value {
    return self.textFieldText;
}

- (void)validationStateDidChange:(BOOL)isValid {
    [self checkAndUpdateState:isValid];
}


#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)__unused textField {
    [self loseFocus];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.textFieldViewDelegate respondsToSelector:@selector (textFieldViewDidBeginEditing:)]) {
        [self.textFieldViewDelegate textFieldViewDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.textFieldViewDelegate respondsToSelector:@selector (textFieldViewDidEndEditing:)]) {
        [self.textFieldViewDelegate textFieldViewDidEndEditing:self];
    }
}

@end
