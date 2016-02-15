//
//  TWRCDTweet.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCoreEntityNameProtocol.h"
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@class TWRCDUser;

NS_ASSUME_NONNULL_BEGIN

@interface TWRCDTweet : NSManagedObject <TWRCoreEntityNameProtocol>

@end

NS_ASSUME_NONNULL_END

#import "TWRCDTweet+CoreDataProperties.h"
