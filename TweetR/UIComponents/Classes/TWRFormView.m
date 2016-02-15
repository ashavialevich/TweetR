//
//  TWRFormView.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/14/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRFormView.h"
#import "TWRErrorProvider.h"

@interface TWRFormView ()

@property (nonnull, strong, atomic, readwrite) NSMutableArray<TWRValidator *> *internalValidators;
@property (nullable, strong, atomic, readwrite) TWRErrorProvider *internalErrorProvider;

@end


@implementation TWRFormView

#pragma mark - Override UIView

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    
    if ([subview conformsToProtocol:@protocol (TWRValidatable)]) {
        NSObject<TWRValidatable> *validatable = (id<TWRValidatable>)subview;
        [validatable setErrorProvider:[self errorProvider]];
    }
}

- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    
    if ([subview conformsToProtocol:@protocol (TWRValidatable)]) {
        NSObject<TWRValidatable> *validatable = (id<TWRValidatable>)subview;
        [validatable setErrorProvider:nil];
    }
}

#pragma mark - Override TWRBaseFormFieldView

- (nullable NSObject *)value {
    return nil;
}

- (void)addValidator:(nonnull TWRValidator *)validator {
    // blank on purpose - nothing to do
}

- (void)removeValidator:(nonnull TWRValidator *)validator {
    // blank on purpose - nothing to do
}

- (nonnull NSArray<TWRValidator *> *)validators {
    return [[NSArray alloc] init];
}

- (nullable TWRErrorProvider *)errorProvider {
    if (!self.internalErrorProvider) {
        self.internalErrorProvider = [[TWRErrorProvider alloc] init];
    }
    return self.internalErrorProvider;
}

- (void)setErrorProvider:(nullable TWRErrorProvider *)errorProvider {
    self.internalErrorProvider = errorProvider;
}

- (BOOL)isValid {
    return self.internalErrorProvider.valid;
}

- (void)requestValidation {
    [self.errorProvider performValidation];
}

- (void)validationStateDidChange:(BOOL)isValid {
    // blank on purpose - nothing to do
}

@end
