//
//  TWRBaseFormFieldView.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/14/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRBaseFormFieldView.h"
#import "TWRValidator.h"
#import "TWRErrorProvider.h"

@interface TWRBaseFormFieldView ()

@property (nonnull, strong, atomic, readwrite) NSMutableArray<TWRValidator *> *internalValidators;
@property (nullable, weak, atomic, readwrite) TWRErrorProvider *internalErrorProvider;
@property (nonatomic, readwrite) BOOL valid;

@end

@implementation TWRBaseFormFieldView

#pragma mark - Override TWRBaseFormFieldView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _internalValidators = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _internalValidators = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Override TWRBaseFormFieldView

- (nullable NSObject *)value {
    return nil;
}

- (void)addValidator:(nonnull TWRValidator *)validator {
    validator.validatable = self;
    [self.internalValidators addObject:validator];
}

- (void)removeValidator:(nonnull TWRValidator *)validator {
    validator.validatable = nil;
    [self.internalValidators removeObject:validator];
}

- (nonnull NSArray<TWRValidator *> *)validators {
    return [self.internalValidators copy];
}

- (nullable TWRErrorProvider *)errorProvider {
    return self.internalErrorProvider;
}

- (void)setErrorProvider:(nullable TWRErrorProvider *)errorProvider {
    if (self.internalErrorProvider) {
        [self.internalErrorProvider unregisterValidatable:self];
    }
    if (errorProvider) {
        [errorProvider registerValidatable:self];
    }
    
    self.internalErrorProvider = errorProvider;
}

- (BOOL)isValid {
    for (TWRValidator *validator in self.internalValidators) {
        if (!validator.valid) {
            return false;
        }
    }
    return true;
}

- (void)requestValidation {
    [self.errorProvider performValidation];
}

- (void)validationStateDidChange:(BOOL)isValid {
    // blank on purpose
}

@end
