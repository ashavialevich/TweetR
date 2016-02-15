//
//  TWRTweet.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRTweet.h"

static NSString *const PARSE_CLASS_NAME = @"Tweet";

@implementation TWRTweet

@dynamic user;
@dynamic tweetContent;
@dynamic isNew;

+ (NSString *)parseClassName {
    return PARSE_CLASS_NAME;
}

@end
