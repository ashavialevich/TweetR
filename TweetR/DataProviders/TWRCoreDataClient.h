//
//  TWRDataStoreMediator.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCDTweet.h"
#import "TWRCDUser.h"
#import "TWRTweet.h"
#import "TWRTweetViewModel.h"
#import "TWRUser.h"
#import <Foundation/Foundation.h>

/**
 @abstract Class used to make all of the app's core data related interactions.
 */
@interface TWRCoreDataClient : NSObject

/**
 @abstract Method used to persist user object in core data. No new user will be created if the user already exists. But
 we still need to recreate user in case app has been deleted (local data store is gone) and user is signing in with
 his/her existing credentials.
 @param User object of type TWRUser needed to be persisted.
 */
+ (void)createUserIfNeeded:(TWRUser *)user;

/**
 @abstract Method used to persist TWRTweet type object in core data
 @param tweet Tweet object to be persisted.
 */
+ (void)createTweet:(TWRTweetViewModel *)tweet;

/**
 @abstract Method used to retreive tweets from local datastore.
 @return Returns an array of objects of TWRTweetViewModel type that are currently stored in local datastore.
 */
+ (NSArray<TWRTweetViewModel *> *)getLocalTweets;

@end
