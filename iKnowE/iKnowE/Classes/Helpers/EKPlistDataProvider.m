//
//  EKPlistDataProvider.m
//  iKnowE
//
//  Created by Evgeny Karkan on 21.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKPlistDataProvider.h"

static NSString * const kEKPlistName = @"additiviesFirstRelease";
static NSString * const kEKPlistExtension = @"plist";


@implementation EKPlistDataProvider;

+ (NSArray *)additiveDescriptions
{
	NSString *path = [[NSBundle mainBundle] pathForResource:kEKPlistName ofType:kEKPlistExtension];
	NSArray *roughDescriptions = [[NSArray alloc] initWithContentsOfFile:path];
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[roughDescriptions count]];
	
	for (NSDictionary *dict in roughDescriptions) {
		EKAdditiveDescription *description = [[EKAdditiveDescription alloc] initWithDictionary:dict];
		[result addObject:description];
	}
	
	return result;
}

+ (EKAdditiveDescription *)additiveWithIndex:(NSUInteger)index
{
    return [self additiveDescriptions][index];
}

@end
