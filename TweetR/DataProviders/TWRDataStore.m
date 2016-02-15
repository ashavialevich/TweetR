

#import "TWRDataStore.h"

@interface TWRDataStore ()

@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation TWRDataStore

+ (instancetype)sharedInstance {
    static TWRDataStore *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
      sharedInstance = [[TWRDataStore alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Core Data stack

- (instancetype)init {
    self = [super init];
    if (self) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *storeCoordinator =
            [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        NSURL *storeURL =
            [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]
                lastObject] URLByAppendingPathComponent:@"TweetR.sqlite"];
        NSError *error = nil;
        if (![storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                            configuration:nil
                                                      URL:storeURL
                                                  options:nil
                                                    error:&error]) {
            abort ();
        }
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:storeCoordinator];
    }
    return self;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog (@"Unresolved error %@, %@", error, [error userInfo]);
            abort ();
        }
    }
}

@end
