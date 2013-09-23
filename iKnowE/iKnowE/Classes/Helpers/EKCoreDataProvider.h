//
//  SUCoreDataProvider.h
//  LTFE
//
//  Created by Evgeniy Karkan on 9/19/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKCoreDataProvider : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (EKCoreDataProvider *)sharedInstance;
+ (void)saveContext;
- (NSFetchRequest *)requestWithEntityName:(NSString *)entityName;

@end
