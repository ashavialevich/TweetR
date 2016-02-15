//
//  TWRBaseFormFieldView.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/14/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWRValidatable.h"

/**
 @discussion The base view for all form fields. Form fields should implement this class
 to get basic validation handling for free.
 
 The following method must be override for validation to work:
 
 Override this method to return the current value of the form field. This is required for validation.
 - (nullable NSObject *)value;
 
 Override this method to receive callbacks when the state of the form fields validation has changed.
 - (void)validationStateDidChange:(BOOL)isValid;
 */
@interface TWRBaseFormFieldView : UIView <TWRValidatable>

@end
