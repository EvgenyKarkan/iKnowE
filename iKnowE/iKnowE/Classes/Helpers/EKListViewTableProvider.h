//
//  EKListViewTableProvider.h
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EKListViewTableDelegate <NSObject>

- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath;

@end


@interface EKListViewTableProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id <EKListViewTableDelegate> delegate;

- (id)initWithDelegate:(id <EKListViewTableDelegate> )delegate;
- (void)feedDataSourceWithData:(NSArray *)data;

@end





