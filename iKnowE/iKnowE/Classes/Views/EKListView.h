//
//  EKListView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKListViewAddEDelegate <NSObject>

- (void)addButtonPressed;
- (void)editButtonPressedWithCompletionBlock:(void (^)(void))block;

@end


@interface EKListView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) id<EKListViewAddEDelegate> delegate;

@end
