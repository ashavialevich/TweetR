//
//  TWRValidator.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRValidator.h"

@interface TWRValidator ()

@property (nonnull, strong, atomic) NSString *internalErrorMessage;

@end

@implementation TWRValidator

- (BOOL)valid {
    return NO;
}

- (nullable NSString *)errorMessage {
    return self.internalErrorMessage;
}

- (BOOL)performValidation {
    return NO;
}

- (nonnull instancetype)initWithErrorMessage:(nonnull NSString *)errorMessage {
    self = [super init];
    if (self) {
        _internalErrorMessage = errorMessage;
    }
    return self;
}

@end
