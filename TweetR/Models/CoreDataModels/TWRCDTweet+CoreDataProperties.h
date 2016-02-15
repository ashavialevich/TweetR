//
//  TWRCDTweet+CoreDataProperties.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TWRCDTweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWRCDTweet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tweetContent;
@property (nullable, nonatomic, retain) NSDate *createdAt;
@property (nullable, nonatomic, retain) TWRCDUser *user;
@property (nullable, nonatomic, retain) NSString *parseID;

@end

NS_ASSUME_NONNULL_END
