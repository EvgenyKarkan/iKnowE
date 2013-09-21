//
//  EKAdditiveDescription.m
//  iKnowE
//
//  Created by Evgeny Karkan on 21.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAdditiveDescription.h"

static NSString * const kEKDangerKey = @"danger";
static NSString * const kEKNameKey = @"chemicalName";
static NSString * const kEKCodeKey = @"code";


@implementation EKAdditiveDescription

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		self.danger = [dictionary valueForKey:kEKDangerKey];
		self.chemicalName = [dictionary valueForKey:kEKNameKey];
		self.code = [dictionary valueForKey:kEKCodeKey];
	}
	return self;
}

@end
