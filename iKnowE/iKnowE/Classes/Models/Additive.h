//
//  Additive.h
//  iKnowE
//
//  Created by Evgeny Karkan on 29.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Additive : NSManagedObject

@property (nonatomic, retain) NSString * ecode;
@property (nonatomic, retain) NSString * information;
@property (nonatomic, retain) NSString * name;

@end
