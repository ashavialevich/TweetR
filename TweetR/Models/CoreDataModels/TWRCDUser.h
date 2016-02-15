//
//  TWRCDUser.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCoreEntityNameProtocol.h"
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TWRCDUser : NSManagedObject <TWRCoreEntityNameProtocol>

@end

NS_ASSUME_NONNULL_END

#import "TWRCDUser+CoreDataProperties.h"
