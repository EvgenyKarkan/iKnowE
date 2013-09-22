//
//  EKViewController.m
//  iKnowE
//
//  Created by Evgeny Karkan on 10.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKDetailViewController.h"
#import "EKDetailView.h"
#import "EKAdditiveDescription.h"

@interface EKDetailViewController () 

@property (nonatomic, strong) EKListViewTableProvider *dataProvider;
@property (nonatomic, strong) EKDetailView *detailView;

@end


@implementation EKDetailViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKDetailView *view = [[EKDetailView alloc] init];
	self.view = view;
	self.detailView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor grayColor];
	
	self.dataProvider = [[EKListViewTableProvider alloc] init];
	[self.dataProvider setDelegate:self];
}

#pragma mark - EKListViewTableDelegate stuff from provider

- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath
{
	self.detailView.foo.text = ((EKAdditiveDescription *)data[indexPath.row]).danger;
}

@end
