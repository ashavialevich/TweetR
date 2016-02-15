//
//  TWRRequiredValidator.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/13/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRValidator.h"

/**
 @discussion Validates the field is not nil or an empty string.
 */
@interface TWRRequiredValidator : TWRValidator

/**
 @abstract Provides the ability to enable, disable this validator.
 @discussion This is enabled by default. When disabled, this validator will always report valid.
 */
@property (assign, nonatomic) BOOL enabled;

@end
