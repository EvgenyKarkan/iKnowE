//
//  EKPlistDataProvider.h
//  iKnowE
//
//  Created by Evgeny Karkan on 21.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKAdditiveDescription.h"

@interface EKPlistDataProvider : NSObject

+ (NSArray *)additiveDescriptions;
+ (EKAdditiveDescription *)additiveWithIndex:(NSUInteger)index;

@end
