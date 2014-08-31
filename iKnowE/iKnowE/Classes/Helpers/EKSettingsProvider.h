//
//  EKSettingsWrapper.h
//  iKnowE
//
//  Created by Evgeny Karkan on 01.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface EKSettingsProvider : NSObject

@property (nonatomic, strong) NSArray *sectionWithRowData;

- (void)clear;

@end
