//
//  TWRDataStore.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/8/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

/**
 @abstract Singleton class used to communicate core data stack with the application. As it is not possible to modify
 core data stack configuration after original initialization, I did not think it was necessary to serialize any of the
 calls to this singleton.
 */
@interface TWRDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 @abstract Method to return a singleton instance of TWRDataStore class.
 */
+ (instancetype)sharedInstance;

/**
 @abstact Method used to save NSManagedObjectContext changes.
 */
- (void)saveContext;

@end
