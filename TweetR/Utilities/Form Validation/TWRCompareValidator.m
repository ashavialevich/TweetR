//
//  TWRCompareValidator.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCompareValidator.h"

@interface TWRCompareValidator ()

@property (assign, nonatomic, readwrite) BOOL isValid;
@property (assign, nonatomic) TWRComparisonOperator comparisonOperator;

@end

@implementation TWRCompareValidator

- (nonnull instancetype)initWithCompareToValue:(nonnull NSObject *)value errorMessage:(nonnull NSString *)errorMessage {
    self = [self initWithCompareToValue:value errorMessage:errorMessage comparisonOperator:TWRComparisonOperatorEqual];
    if (self != nil) {
        _isValid = YES;
        _compareToValue = value;
        _comparisonOperator = TWRComparisonOperatorEqual;
    }
    return self;
}

- (nonnull instancetype)initWithCompareToValue:(NSObject *)value
                                  errorMessage:(NSString *)errorMessage
                            comparisonOperator:(TWRComparisonOperator)comparisonOperator {
    self = [super initWithErrorMessage:errorMessage];
    if (self != nil) {
        _isValid = YES;
        _compareToValue = value;
        _comparisonOperator = comparisonOperator;
    }
    return self;
}

- (BOOL)valid {
    return self.isValid;
}

- (BOOL)performValidation {
    NSObject *mine = self.validatable.value;
    NSObject *theirs = self.compareToValue;
    if ([theirs conformsToProtocol:@protocol (TWRValidatable)]) {
        theirs = ((NSObject<TWRValidatable> *)theirs).value;
    }
    return [self validateValue:mine valueToCompare:theirs];
}

- (BOOL)validateValue:(NSObject *)value valueToCompare:(NSObject *)valueToCompare {
    if (![valueToCompare respondsToSelector:@selector (compare:)]) {
        self.isValid = YES;
        return self.isValid;
    }
    NSComparisonResult result
    = (NSComparisonResult)[valueToCompare performSelector:@selector (compare:) withObject:value];
    switch (self.comparisonOperator) {
        case TWRComparisonOperatorEqual: {
            self.isValid = [value isEqual:valueToCompare];
            break;
        }
        case TWRComparisonOperatorGreaterThan: {
            return self.isValid = result == NSOrderedAscending;
        }
        case TWRComparisonOperatorGreaterThanOrEqual: {
            return self.isValid = (result == NSOrderedAscending || result == NSOrderedSame);
        }
        case TWRComparisonOperatorLessThan: {
            return self.isValid = result == NSOrderedDescending;
        }
        case TWRComparisonOperatorLessThanOrEqual: {
            return self.isValid = (result == NSOrderedDescending || result == NSOrderedSame);
        }
    }
    return self.isValid;
}

@end
