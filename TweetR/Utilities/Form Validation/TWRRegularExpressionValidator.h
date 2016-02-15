//
//  TWRRegularExpressionValidator.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRValidator.h"

/**
 @discussion This validator compares the "RegularExpession" with the value of the validatable.
 */
@interface TWRRegularExpressionValidator : TWRValidator

/**
 @abstract Creates an instance of TWRRegularExpressionValidator class.
 @param emailValue The emailValue that will be compared. Supports NSObject and TWRValidatables.
 @param errorMessage The error message displayed to the user.
 @return An instance of TWRRegularExpressionValidator class.
 */
- (nonnull instancetype)initWithPattern:(nonnull NSString *)regexPattern errorMessage:(nonnull NSString *)errorMessage;

- (nullable instancetype)init __attribute__ ((unavailable ("Must use initWithErrorMessage: instead.")));

@end
