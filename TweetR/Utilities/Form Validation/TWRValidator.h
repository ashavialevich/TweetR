//
//  TWRValidator.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWRValidatable.h"

/**
 @discussion The base implementation for a validator. Implement this class to add your own validation.
 */
@interface TWRValidator : NSObject

/**
 @abstract The validatable associated with the validator. This must be set.
 */
@property (nullable, weak, atomic, readwrite) NSObject<TWRValidatable> *validatable;

/**
 @abstract The current state of the validatable. Invoke "performValidation" to update the state.
 */
- (BOOL)valid;

/**
 @abstract The error message to display when the validatable is invalid.
 */
- (nullable NSString *)errorMessage;

/**
 @abstract Performs a validation of the validatable using this validator.
 @discussion The state of the validator is only updated after this method is invoked.
 */
- (BOOL)performValidation;

/**
 @abstract Creates an instance of TDValidator class.
 @param errorMessage The error message displayed to the user.
 @return An instance of TDValidator class.
 */
- (nonnull instancetype)initWithErrorMessage:(nonnull NSString *)errorMessage;

- (nullable instancetype)init __attribute__ ((unavailable ("Must use initWithErrorMessage: instead.")));

@end
