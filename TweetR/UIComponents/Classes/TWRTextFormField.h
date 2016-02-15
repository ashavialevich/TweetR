//
//  TWRTextFormField.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/14/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRBaseFormFieldView.h"

@protocol TWRTextFieldViewDelegate;

/**
 @abtract View representing text form field. This class/view can be greatly expanded upon by exposing more properties
 allowing for much more customization. I have only added a bare minimum for what I need for the coding exercise, but the
 idea is that this is a generic component that can allow for more customization without view controller really worrying
 about it other than setting the properties and manipulated exposed API.
 */
@interface TWRTextFormField : TWRBaseFormFieldView <UITextFieldDelegate>

/**
 @abstract Delegate that will receive TWRTextFieldViewDelegate protocol methods callbacks.
 */
@property (nullable, weak, nonatomic) id<TWRTextFieldViewDelegate> textFieldViewDelegate;

/**
 @abstract TWRTextField provides a default implementation for UITextFieldDelegate; use this method to override this
 implementation with another implementation of UITextFieldDelegate.
 @param delegate The delegate that implements the UITextFieldDelegate protocol.
 */
- (void)setTextFieldDelegate:(nullable id<UITextFieldDelegate>)delegate;

/**
 @abstract Provides the font for this view's text field.
 */
@property (nonnull, strong, nonatomic) UIFont *textFieldFont;

/**
 @abstract Provides text for the placeholder in this view's text field.
 */
@property (nonnull, strong, nonatomic) NSString *textFieldHintText;

/**
 @abstract Provides the text for this view's text field.
 */
@property (nullable, strong, nonatomic) NSString *textFieldText;

/**
 @abstract Provide the keyboard type for this view's text field.
 */
@property (nonatomic) UIKeyboardType keyboardType;

/**
 @abstract Return YES if this view's text field is the first responder.
 */
- (BOOL)textFieldHasFocus;

/**
 @abstract Will resign first responder on this view's text field.
 */
- (void)loseFocus;

@end

/**
 @abstract Amount Field Protocol for amount change notifications.
 */
@protocol TWRTextFieldViewDelegate <NSObject>

@optional

/**
 @abstract Notifies the implementor that editing began for the specified text field view.
 @param textFieldView The text field view for which editing began.
 */
- (void)textFieldViewDidBeginEditing:(nonnull TWRTextFormField *)textFieldView;

/**
 @abstract Notifies the implementor that editing ended for the specified text field view.
 @param textFieldView The text field view for which editing ended.
 */
- (void)textFieldViewDidEndEditing:(nonnull TWRTextFormField *)textFieldView;

@end
