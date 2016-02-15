//
//  TWRCompareValidator.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRValidator.h"

/**
 @abstract TWRComparisonOperator enum values.
 */
typedef NS_ENUM (NSInteger, TWRComparisonOperator) {
    /** Less than comparison operator */
    TWRComparisonOperatorLessThan = 0,
    /** Less than or equal comparison operator */
    TWRComparisonOperatorLessThanOrEqual,
    /** Equal comparison operator */
    TWRComparisonOperatorEqual,
    /** Greater than comparison operator */
    TWRComparisonOperatorGreaterThan,
    /** Greater than or equal comparison operator */
    TWRComparisonOperatorGreaterThanOrEqual
};

@interface TWRCompareValidator : TWRValidator

/**
 @abstract Value to be compared to during validation.
 */
@property (nonnull, strong, nonatomic) NSObject *compareToValue;

/**
 @abstract Creates an instance of TWRCompareValidator class.
 @param value The value that will be compared. Supports NSObject and TWRValidatables.
 @param errorMessage The error message displayed to the user.
 @return An instance of TWRCompareValidator class.
 */
- (nonnull instancetype)initWithCompareToValue:(nonnull NSObject *)value errorMessage:(nonnull NSString *)errorMessage;

/**
 @abstract Creates an instance of TWRCompareValidator class.
 @param value The value that will be compared. Supports NSObject and TWRValidatables.
 @param errorMessage The error message displayed to the user.
 @param comparisonOperator Comparison operator to be used for validation.
 @return An instance of TWRCompareValidator class.
 */
- (nonnull instancetype)initWithCompareToValue:(nonnull NSObject *)value
                                  errorMessage:(nonnull NSString *)errorMessage
                            comparisonOperator:(TWRComparisonOperator)comparisonOperator NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithErrorMessage
__attribute__ ((unavailable ("Must use initWithCompareToValue:errorMessage:comparisonOperator: instead.")));

@end
