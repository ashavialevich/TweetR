//
//  TWRRequiredValidator.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRRequiredValidator.h"

@interface TWRRequiredValidator ()

@property (assign, nonatomic, readwrite) BOOL isValid;

@end

@implementation TWRRequiredValidator

- (BOOL)valid {
    return self.isValid;
}

- (BOOL)performValidation {
    if (!self.enabled) {
        self.isValid = YES;
        return self.isValid;
    }
    NSObject *value = self.validatable.value;
    if ([value isKindOfClass:[NSString class]]) {
        self.isValid = ((NSString *)value).length > 0;
    } else {
        self.isValid = value != nil;
    }
    return self.isValid;
}

- (nonnull instancetype)initWithErrorMessage:(nonnull NSString *)errorMessage {
    self = [super initWithErrorMessage:errorMessage];
    if (self) {
        _isValid = YES;
        _enabled = YES;
    }
    return self;
}

@end
