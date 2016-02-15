//
//  TWRCoreEntityName.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/10/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @abstact Convenience protocol to ensure easy access of the core data entity name.
 @discussion This protocol is created with the intent to generize common functionality for the NSManagedObject
 subclasses used by the app to interact with core data framework. This functionality is a good candidate to be moved out
 to it's own class, which would be a NSManagedObject subclass.
 */
@protocol TWRCoreEntityNameProtocol <NSObject>

/**
 @abstract Method to return entity name by a conforming NSManagedObject subclass.
 @return entityName Entity name string representation.
 */
+ (NSString *)entityName;

@end
