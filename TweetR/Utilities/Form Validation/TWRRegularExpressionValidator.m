//
//  TWRRegularExpressionValidator.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRRegularExpressionValidator.h"

@interface TWRRegularExpressionValidator ()

@property (assign, nonatomic, readwrite) BOOL isValid;
@property (nonnull, strong, nonatomic) NSRegularExpression *regularexpressionPattern;

@end

@implementation TWRRegularExpressionValidator

- (nonnull instancetype)initWithPattern:(NSString *)pattern errorMessage:(nonnull NSString *)errorMessage {
    self = [super initWithErrorMessage:errorMessage];
    if (self) {
        _isValid = YES;
        _regularexpressionPattern = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                error:nil];
    }
    return self;
}

- (nonnull instancetype)initWithRegularExpression:(NSRegularExpression *)regularExpression
                                     errorMessage:(nonnull NSString *)errorMessage {
    self = [super initWithErrorMessage:errorMessage];
    if (self) {
        _isValid = YES;
        _regularexpressionPattern = regularExpression;
    }
    return self;
}

- (BOOL)valid {
    return self.isValid;
}

- (BOOL)performValidation {
    self.isValid = NO;
    
    if ([self.validatable.value isKindOfClass:[NSString class]]) {
        NSString *validatableValue = (NSString *)self.validatable.value;
        NSRange textRange = NSMakeRange (0, validatableValue.length);
        NSArray *matches = [self.regularexpressionPattern matchesInString:validatableValue options:0 range:textRange];
        
        if (matches != nil && matches.count > 0) {
            self.isValid = YES;
        }
    }
    
    return self.isValid;
}


@end
