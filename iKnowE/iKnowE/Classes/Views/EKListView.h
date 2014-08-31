//
//  EKListView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@protocol EKListViewAddEDelegate <NSObject>

- (void)addButtonPressed;

@end


@interface EKListView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, assign) BOOL isTableEditing;
@property (nonatomic, assign) id<EKListViewAddEDelegate> delegate;
@property (nonatomic, strong) UILabel *logo;

@end
