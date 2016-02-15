//
//  TWRTweetViewModel.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRTweetViewModel.h"

@implementation TWRTweetViewModel

- (instancetype)initWithParseID:(NSString *)parseID
                         userID:(NSString *)userID
                       username:(NSString *)username
                   tweetContent:(NSString *)tweetContent
                      tweetDate:(NSDate *)tweetDate {
    if (self = [super init]) {
        _parseID = parseID;
        _userID = userID;
        _username = username;
        _tweetContent = tweetContent;
        _tweetDate = tweetDate;
    }
    return self;
}

@end
