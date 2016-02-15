//
//  TWRErrorProvider.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRErrorProvider.h"
#import "TWRValidator.h"

@interface TWRErrorProvider ()

@property (nonnull, strong, atomic) NSMutableArray<NSString *> *validatorErrors;
@property (nonnull, strong, atomic) NSMutableArray<NSObject<TWRValidatable> *> *validatables;

@end

@implementation TWRErrorProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _validatables = [[NSMutableArray alloc] init];
        _validatorErrors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)registerValidatable:(nonnull NSObject<TWRValidatable> *)validatable {
    [self.validatables addObject:validatable];
}

- (void)unregisterValidatable:(nonnull NSObject<TWRValidatable> *)validatable {
    [self.validatables removeObject:validatable];
}

- (BOOL)valid {
    return self.validatorErrors.count == 0;
}

- (nonnull NSArray<NSString *> *)errorMessages {
    return [self.validatorErrors copy];
}

- (void)performValidation {
    // initial thought was to only invoke the delegate callback on state change, for now, calling it every time in order
    // to display alert
    //    NSMutableArray *oldValidatorErrors = self.validatorErrors.copy;
    //    [self.validatorErrors removeAllObjects];
    //
    //    BOOL didStateChange = NO;
    //
    //    for (NSObject<TWRValidatable> *validatable in self.validatables) {
    //        BOOL wasValid = [validatable isValid];
    //        BOOL isValid = [self performValidation:validatable];
    //        if (wasValid != isValid) {
    //            didStateChange = YES;
    //            [validatable validationStateDidChange:[validatable isValid]];
    //        }
    //    }
    //    NSSet *oldValidatorErrorSet = [NSSet setWithArray:oldValidatorErrors];
    //    NSSet *newValidatorErrorSet = [NSSet setWithArray:self.validatorErrors];
    //    if (![oldValidatorErrorSet isEqualToSet:newValidatorErrorSet]) {
    //        didStateChange = YES;
    //    }
    //    if (didStateChange && [self.delegate respondsToSelector:@selector
    //    (validationStateChanged:state:errorMessages:)]) {
    //        [self.delegate validationStateChanged:self state:[self valid] errorMessages:[self errorMessages]];
    //    }
    //    NSMutableArray *oldValidatorErrors = self.validatorErrors.copy;
    [self.validatorErrors removeAllObjects];
    BOOL didStateChange = NO;
    for (NSObject<TWRValidatable> *validatable in self.validatables) {
        BOOL wasValid = [validatable isValid];
        BOOL isValid = [self performValidation:validatable];
        if (wasValid != isValid) {
            didStateChange = YES;
            [validatable validationStateDidChange:[validatable isValid]];
        }
    }
    if ([self.delegate respondsToSelector:@selector (validationStateChanged:state:errorMessages:)]) {
        [self.delegate validationStateChanged:self state:[self valid] errorMessages:[self errorMessages]];
    }
}

- (BOOL)performValidation:(NSObject<TWRValidatable> *)validatable {
    for (TWRValidator *validator in validatable.validators) {
        if (![validator performValidation]) {
            [self.validatorErrors addObject:validator.errorMessage];
            return NO;
        }
    }

    return YES;
}

@end
