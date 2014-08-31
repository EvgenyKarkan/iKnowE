//
//  SUCoreDataProvider.h
//  LTFE
//
//  Created by Evgeniy Karkan on 9/19/13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "Additive.h"

@interface EKCoreDataProvider : NSObject

+ (EKCoreDataProvider *)sharedInstance;
- (void)saveEntityWithName:(NSString *)name withData:(NSArray *)data;
- (void)updateEnityWithName:(NSString *)name withIndex:(NSUInteger)index withData:(NSArray *)data;
- (void)saveContext;
- (void)deleteEntityWithEntityIndex:(NSIndexPath *)index;
- (NSArray *)fetchedEntitiesForEntityName:(NSString *)name;
- (Additive *)additiveWithIndex:(NSUInteger)index;

@end
