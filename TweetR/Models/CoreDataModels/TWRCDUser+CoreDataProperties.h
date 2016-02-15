//
//  TWRCDUser+CoreDataProperties.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//
//

#import "TWRCDUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface TWRCDUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *parseID;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *tweets;

@end

@interface TWRCDUser (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(NSManagedObject *)value;
- (void)removeTweetsObject:(NSManagedObject *)value;
- (void)addTweets:(NSSet<NSManagedObject *> *)values;
- (void)removeTweets:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
