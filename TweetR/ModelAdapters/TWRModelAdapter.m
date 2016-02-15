//
//  TWRModelAdapter.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCDUser.h"
#import "TWRModelAdapter.h"
#import "TWRUser.h"

@implementation TWRModelAdapter

+ (TWRTweetViewModel *)tweetViewModelFromCoreDataTweet:(TWRCDTweet *)coreDataTweet {
    TWRTweetViewModel *tweet = [[TWRTweetViewModel alloc] initWithParseID:coreDataTweet.parseID
                                                                   userID:coreDataTweet.user.parseID
                                                                 username:coreDataTweet.user.username
                                                             tweetContent:coreDataTweet.tweetContent
                                                                tweetDate:coreDataTweet.createdAt];
    return tweet;
}

+ (TWRTweetViewModel *)tweetViewModelFromParseTweet:(TWRTweet *)parseTweet {
    TWRTweetViewModel *tweet = [[TWRTweetViewModel alloc] initWithParseID:parseTweet.objectId
                                                                   userID:parseTweet.user.objectId
                                                                 username:parseTweet.user.username
                                                             tweetContent:parseTweet.tweetContent
                                                                tweetDate:parseTweet.createdAt];
    return tweet;
}

@end
