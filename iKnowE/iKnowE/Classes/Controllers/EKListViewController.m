//
//  EKListViewController.m
//  iSayNo
//
//  Created by Evgeny Karkan on 20.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKListViewController.h"
#import "EKListView.h"
#import "EKListViewTableProvider.h"
#import "EKPlistDataProvider.h"

@interface EKListViewController () <EKListViewTableDelegate>

@property (nonatomic, strong) EKListView *listView;
@property (nonatomic, strong) EKListViewTableProvider *dataProvider;

@end


@implementation EKListViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKListView *view = [[EKListView alloc] init];
    self.view = view;
    self.listView = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.dataProvider = [[EKListViewTableProvider alloc] initWithDelegate:self];
    self.listView.tableView.delegate = self.dataProvider;
    self.listView.tableView.dataSource = self.dataProvider;
    
    [self.dataProvider feedDataSourceWithData:[EKPlistDataProvider additiveDescriptions]];
}

#pragma mark - EKListViewTableDelegate stuff

- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
