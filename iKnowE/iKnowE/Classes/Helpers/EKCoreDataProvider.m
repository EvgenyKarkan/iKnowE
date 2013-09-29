//
//  SUCoreDataProvider.m
//  LTFE
//
//  Created by Evgeniy Karkan on 9/19/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKCoreDataProvider.h"
#import "Additive.h"

@interface EKCoreDataProvider ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation EKCoreDataProvider;

#pragma mark Singleton stuff

static id _sharedInstance;

+ (EKCoreDataProvider *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[EKCoreDataProvider alloc] init];
    });
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = nil;
        _sharedInstance = [super allocWithZone:zone];
    });
    return _sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (id)new
{
    NSException *exception = [[NSException alloc] initWithName:@"Deprecated method"
                                                        reason:@"Class instance is singleton. It's not possible to call +new method directly. Use +sharedInstance instead"
                                                      userInfo:nil];
    [exception raise];
    
    return nil;
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
    
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserAdditive" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
    
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iKnowE.sqlite"];
    
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[[EKCoreDataProvider sharedInstance] managedObjectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
	return _persistentStoreCoordinator;
}

#pragma mark - Public API

- (void)saveEntityWithName:(NSString *)name withData:(NSArray *)data
{
	Additive *additive = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:[[EKCoreDataProvider sharedInstance] managedObjectContext]];
	if (additive != nil) {
		NSError *savingError = nil;
		additive.ecode = data[0];
		additive.name = data[1];
		additive.information = data[2];
        
		[[[EKCoreDataProvider sharedInstance] managedObjectContext] save:&savingError];
        
		NSAssert(savingError == nil, @"Error occurs during saving to context %@", [savingError localizedDescription]);
	}
    
	else {
            //no entity was returned add error HUD
//		UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", nil)
//		                                                    message:NSLocalizedString(@"ERROR_SAVE_MESSAGE", nil)
//		                                                   delegate:nil
//		                                          cancelButtonTitle:nil
//		                                          otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
//		[errorView show];
	}
}

- (void)saveContext
{
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = [[EKCoreDataProvider sharedInstance] managedObjectContext];
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

- (NSArray *)fetchedEntitiesForEntityName:(NSString *)name
{
	NSError *error = nil;
	NSArray *entities = [[[EKCoreDataProvider sharedInstance] managedObjectContext] executeFetchRequest:[[EKCoreDataProvider sharedInstance] requestWithEntityName:name]
	                                                                                              error:&error];
    
	NSAssert(entities != nil, @"Fetched array should not be nil");

	return entities;
}

- (NSFetchRequest *)requestWithEntityName:(NSString *)entityName
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName
	                                                     inManagedObjectContext:self.managedObjectContext];
    
	if (entityDescription != nil) {
		[fetchRequest setEntity:entityDescription];
	}
	else {
		NSAssert(entityDescription != nil, @"EntityDescription should not be nil");
	}
    

	return fetchRequest;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
