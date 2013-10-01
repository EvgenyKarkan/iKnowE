//
//  EKSettingsWrapper.m
//  iKnowE
//
//  Created by Evgeny Karkan on 01.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKSettingsProvider.h"

@implementation EKSettingsProvider

- (void)setSectionWithRowData:(NSArray *)sectionWithRowData
{
	[[NSUserDefaults standardUserDefaults] setObject:sectionWithRowData forKey:@"storedSectionWithRow"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)sectionWithRowData
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"storedSectionWithRow"];
}

- (void)clear
{
	NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
	[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
	NSAssert([[NSUserDefaults standardUserDefaults] objectForKey:@"storedSectionWithRow"] == nil, @"Clear should be successfull");
}

@end
