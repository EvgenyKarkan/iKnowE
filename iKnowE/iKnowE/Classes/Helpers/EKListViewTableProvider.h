//
//  EKListViewTableProvider.h
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EKListViewTableDelegate <NSObject>

@optional
- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath;
- (void)sectionHeaderDidTap;
- (void)didDeleteRow;
- (NSUInteger)provideNumberOfSections;

@end


@interface EKListViewTableProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id <EKListViewTableDelegate> delegate;
@property (nonatomic, assign) BOOL search;
@property (nonatomic, strong) NSArray *usualData;
@property (nonatomic, strong) NSMutableArray *searchPlistData;
@property (nonatomic, strong) NSMutableArray *searchCoreDataData;

- (id)initWithDelegate:(id <EKListViewTableDelegate> )delegate;

@end

