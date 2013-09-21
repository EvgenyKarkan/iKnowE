//
//  EKPlistDataProvider.m
//  iKnowE
//
//  Created by Evgeny Karkan on 21.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKPlistDataProvider.h"
#import "EKAdditiveDescription.h"


@implementation EKPlistDataProvider;

+ (NSArray *)additiveDescriptions
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"additivies" ofType:@"plist"];
    NSArray *raughDescriptions = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[raughDescriptions count]];
	
    for (NSDictionary *dict in raughDescriptions) {
        EKAdditiveDescription *description = [[EKAdditiveDescription alloc] initWithDictionary:dict];
        [result addObject:description];
    }
    
    return result;
}

@end
