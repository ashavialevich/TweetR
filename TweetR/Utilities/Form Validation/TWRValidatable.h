//
//  TWRValidatable.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWRErrorProvider;
@class TWRValidator;

@protocol TWRValidatable <NSObject>

/**
 @abstract The current value of the validatable. This is the value that will be used by the validators.
 */
- (nullable NSObject *)value;

/**
 @abstract Adds validators to the validatable.
 */
- (void)addValidator:(nonnull TWRValidator *)validator;

/**
 @abstract Removes a validator from the validatable.
 */
- (void)removeValidator:(nonnull TWRValidator *)validator;

/**
 @abstract Get the collection of validators associated with the validatable.
 */
- (nonnull NSArray<TWRValidator *> *)validators;

/**
 @abstract Get the error provider associated with the validatable.
 */
- (nullable TWRErrorProvider *)errorProvider;

/**
 @abstract Set the error provider associate it with the error provider.
 */
- (void)setErrorProvider:(nullable TWRErrorProvider *)errorProvider;

/**
 @abstract Get the current state of the validatable.
 @return True if the validatable is valid. Otherwise, returns false.
 */
- (BOOL)isValid;

/**
 @abstract Request that a validation is performed on the validatable.
 @discussion This will perform a validation on all validatables assocated with the error provider.
 */
- (void)requestValidation;

/**
 @abstract This method is invoked when the state of the validatable changes.
 @discussion Implement this method to update the state of the validatable. For example, highlight the validatable
 in red.
 */
- (void)validationStateDidChange:(BOOL)isValid;

@end
