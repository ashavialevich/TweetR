//
//  TWRErrorProvider.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWRValidatable.h"

@protocol TWRErrorProviderDelegate;

/**
 @discussion The ErrorProvider class provides a mechanism to validate a collection of TWRValidatables. Implement the
 TWRErrorProviderDelegate delegate to receive a callback when the validation state changes.
 */
@interface TWRErrorProvider : NSObject

/**
 @abstract The delegate for the error provide.
 @discussion Set the delegate to receive callbacks when the state of the validatables changes.
 */
@property (nullable, weak, atomic) NSObject<TWRErrorProviderDelegate> *delegate;

/**
 @abstract Boolean value that indicates that all registered validatables are valid.
 @discussion YES indicates all validatables are valid and NO indicates that there is at least one invalid validatable.
 */
@property (nonatomic, readonly) BOOL valid;

/**
 @abstract A collection of error message for the current state.
 @discussion The array is empty when the state is valid.
 */
@property (nonnull, atomic, readonly) NSArray<NSString *> *errorMessages;

/**
 @abstract Registers a validatable with the error provider.
 */
- (void)registerValidatable:(nonnull NSObject<TWRValidatable> *)validatable;

/**
 @abstract Unregisters a validatable with the error provider.
 */
- (void)unregisterValidatable:(nonnull NSObject<TWRValidatable> *)validatable;

/**
 @abstract Performs a validation on all registered validatables. The delegate will be invoked if the state changes.
 */
- (void)performValidation;

@end

/**
 @abstract Implement this protocol to receive callback notifications when the state of the error provider changes.
 */
@protocol TWRErrorProviderDelegate <NSObject>

/**
 @abstract This method is invoked when the state of the error provider changes.
 @param errorProvider The error provider that invoked this method.
 @param valid The new state of the error provider.
 @param errorMessages The error messages for the current state.
 */
- (void)validationStateChanged:(nonnull TWRErrorProvider *)errorProvider
                         state:(BOOL)valid
                 errorMessages:(nonnull NSArray<NSString *> *)errorMessages;
@end
