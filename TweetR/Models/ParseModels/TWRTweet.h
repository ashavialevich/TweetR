//
//  TWRTweet.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Parse/Parse.h>

static NSString *const TWR_TWEET_KEY_DATE = @"createdAt";

@class TWRUser;

@interface TWRTweet : PFObject <PFSubclassing>

@property (strong, nonatomic) TWRUser *user;
@property (strong, nonatomic) NSString *tweetContent;
@property (assign, nonatomic) BOOL isNew;

@end
