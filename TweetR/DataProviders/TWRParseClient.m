//
//  TWRParseClient.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRModelAdapter.h"
#import "TWRParseClient.h"
#import <Parse/Parse.h>

static NSString *const APPLICATION_ID = @"FrnwcSIPOpnNCYAgGHiGyKq3hwcrgfrRS3HyJgvZ";
static NSString *const CLIENT_KEY = @"s0XuMAnzNhbj47lN5OFDNoTEAFUQh8ZF850UJlCk";
static NSString *const TWEET_KEY_USER = @"user";
static NSString *const TWEET_KEY_IS_NEW = @"isNew";

@implementation TWRParseClient

+ (void)installWebHooks {
    [Parse setApplicationId:APPLICATION_ID clientKey:CLIENT_KEY];
    [TWRParseClient registerParseClasses];
}

+ (void)signupWithUsername:(NSString *)username
                  password:(NSString *)password
                     email:(nonnull NSString *)email
                   handler:(TWRSucceededHandler)handler {
    PFUser *newUser = [[PFUser alloc] init];
    newUser.username = username;
    newUser.password = password;
    newUser.email = email;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      dispatch_async (dispatch_get_main_queue (), ^{
        handler (succeeded, error);
      });
    }];
}

+ (void)signInWithUsername:(NSString *)username password:(NSString *)password handler:(TWRSucceededHandler)handler {
    [PFUser logInWithUsernameInBackground:username
                                 password:password
                                    block:^(PFUser *_Nullable user, NSError *_Nullable error) {
                                      dispatch_async (dispatch_get_main_queue (), ^{
                                        handler (user, error);
                                      });
                                    }];
}

+ (void)markTweetsAsRead:(NSArray<TWRTweetViewModel *> *)tweets {
    for (TWRTweetViewModel *tweet in tweets) {
        PFQuery *query = [TWRTweet query];
        [query getObjectInBackgroundWithId:tweet.parseID
                                     block:^(PFObject *_Nullable object, NSError *_Nullable error) {
                                       TWRTweet *tweet = (TWRTweet *)object;
                                       tweet.isNew = NO;
                                       [tweet saveInBackground];
                                     }];
    }
}

+ (void)getRemoteTweets:(TWRUserTweetsHandler)handler {
    PFQuery *userTweetsQuery = [TWRTweet query];
    [userTweetsQuery includeKey:TWEET_KEY_USER];
    [userTweetsQuery whereKey:TWEET_KEY_IS_NEW equalTo:[NSNumber numberWithBool:YES]];
    [userTweetsQuery addDescendingOrder:TWR_TWEET_KEY_DATE];
    [userTweetsQuery findObjectsInBackgroundWithBlock:^(NSArray *_Nullable objects, NSError *_Nullable error) {
      if (!error) {
          NSMutableArray<TWRTweetViewModel *> *tweets = [[NSMutableArray alloc] initWithCapacity:objects.count];
          for (PFObject *object in objects) {
              TWRTweet *tweet = (TWRTweet *)object;
              TWRTweetViewModel *tweetViewModel = [TWRModelAdapter tweetViewModelFromParseTweet:tweet];
              [tweets addObject:tweetViewModel];
          }
          dispatch_async (dispatch_get_main_queue (), ^{
            handler ([tweets copy], nil);
          });
          return;
      }
      dispatch_async (dispatch_get_main_queue (), ^{
        handler (nil, error);
      });
    }];
}

+ (void)postTweet:(TWRTweet *)tweet handler:(TWRSucceededHandler)handler {
    [tweet saveInBackgroundWithBlock:^(BOOL succeeded, NSError *_Nullable error) {
      dispatch_async (dispatch_get_main_queue (), ^{
        handler (succeeded, error);
      });
    }];
}

+ (void)registerParseClasses {
    [TWRUser registerSubclass];
    [TWRTweet registerSubclass];
}

@end
