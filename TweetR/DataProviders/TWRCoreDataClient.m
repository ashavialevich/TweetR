//
//  TWRDataStoreMediator.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCDTweet.h"
#import "TWRCoreDataClient.h"
#import "TWRDataStore.h"
#import "TWRModelAdapter.h"

@implementation TWRCoreDataClient

+ (TWRCDUser *)currentUser {
    TWRDataStore *dataStore = [TWRDataStore sharedInstance];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[TWRCDUser entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.parseID==%@", TWRUser.currentUser.objectId];
    [request setPredicate:predicate];
    TWRCDUser *currentUser = [[dataStore.managedObjectContext executeFetchRequest:request error:nil] firstObject];
    return currentUser;
}

+ (void)createUserIfNeeded:(TWRUser *)user {
    TWRDataStore *dataStore = [TWRDataStore sharedInstance];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[TWRCDUser entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.parseID==%@", TWRUser.currentUser.objectId];
    [request setPredicate:predicate];
    TWRCDUser *currentUser = [[dataStore.managedObjectContext executeFetchRequest:request error:nil] firstObject];
    if (currentUser) {
        return;
    }
    TWRCDUser *coreDataUser = [NSEntityDescription insertNewObjectForEntityForName:[TWRCDUser entityName]
                                                            inManagedObjectContext:dataStore.managedObjectContext];
    coreDataUser.parseID = user.objectId;
    coreDataUser.username = user.username;
    coreDataUser.email = user.email;
    [dataStore saveContext];
}

+ (void)createTweet:(TWRTweetViewModel *)tweet {
    TWRDataStore *dataStore = [TWRDataStore sharedInstance];
    TWRCDTweet *coreDataTweet = [NSEntityDescription insertNewObjectForEntityForName:[TWRCDTweet entityName]
                                                              inManagedObjectContext:dataStore.managedObjectContext];
    TWRCDUser *currentUser = [TWRCoreDataClient currentUser];
    coreDataTweet.parseID = tweet.parseID;
    coreDataTweet.createdAt = tweet.tweetDate;
    coreDataTweet.tweetContent = tweet.tweetContent;
    coreDataTweet.user = currentUser;
    [currentUser addTweets:[NSSet setWithObject:coreDataTweet]];
    [dataStore saveContext];
}

+ (NSArray<TWRTweetViewModel *> *)getLocalTweets {
    TWRDataStore *dataStore = [TWRDataStore sharedInstance];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[TWRCDTweet entityName]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:TWR_TWEET_KEY_DATE ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSArray<TWRCDTweet *> *tweets = [dataStore.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray<TWRTweetViewModel *> *tweetArray = [[NSMutableArray alloc] initWithCapacity:tweets.count];
    for (TWRCDTweet *tweet in tweets) {
        TWRTweetViewModel *tweetViewModel = [TWRModelAdapter tweetViewModelFromCoreDataTweet:tweet];
        [tweetArray addObject:tweetViewModel];
    }
    return [tweetArray copy];
}

@end
