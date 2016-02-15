//
//  TWRWebServiceClient.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/7/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRParseClient.h"
#import "TWRWebServiceClient.h"

@interface TWRWebServiceClient ()

@property (strong, nonatomic) TWRParseClient *client;

@end

@implementation TWRWebServiceClient

+ (void)installWebHooks {
    [TWRParseClient installWebHooks];
}

+ (void)getRemoteTweets:(TWRUserTweetsHandler)handler {
    [TWRParseClient getRemoteTweets:handler];
}

+ (void)markTweetsAsRead:(NSArray<TWRTweetViewModel *> *)tweets {
    [TWRParseClient markTweetsAsRead:tweets];
}

+ (void)signupWithUsername:(NSString *)username
                  password:(NSString *)password
                     email:(nonnull NSString *)email
                   handler:(TWRSucceededHandler)handler {
    [TWRParseClient signupWithUsername:username password:password email:email handler:handler];
}

+ (void)signInWithUsername:(NSString *)username password:(NSString *)password handler:(TWRSucceededHandler)handler {
    [TWRParseClient signInWithUsername:username password:password handler:handler];
}

+ (void)postTweet:(TWRTweet *)tweet handler:(TWRSucceededHandler)handler {
    [TWRParseClient postTweet:tweet handler:handler];
}

@end
