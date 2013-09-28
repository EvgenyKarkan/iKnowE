//
//  EKListViewController.m
//  iKnowE
//
//  Created by Evgeny Karkan on 20.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKListViewController.h"
#import "EKListView.h"
#import "EKListViewTableProvider.h"
#import "EKPlistDataProvider.h"
#import "EKAdditiveDescription.h"
#import "EKAddEViewController.h"

@interface EKListViewController () <UISearchBarDelegate, EKListViewTableDelegate, EKListViewAddEDelegate>


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
	self.listView.searchBar.delegate = self;
    self.listView.delegate = self;

    self.dataProvider.usualData = [EKPlistDataProvider additiveDescriptions];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onKeyboardHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];
}

#pragma mark - UISearchBarDelegate stuff

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if ([self.dataProvider.searchData count] > 0) {
		[self.dataProvider.searchData removeAllObjects];
	}
	if ([searchText length] > 0) {
		self.dataProvider.search = YES;
		for (NSUInteger i = 0; i < [self.dataProvider.usualData count]; i++) {
			NSRange titleResultsRange = [((EKAdditiveDescription *)self.dataProvider.usualData[i]).code rangeOfString:searchText options:NSCaseInsensitiveSearch];
			if (titleResultsRange.length > 0) {
				[self.dataProvider.searchData addObject:[self.dataProvider.usualData objectAtIndex:i]];
			}
		}
	}
	else {
		self.dataProvider.search = NO;
	}
	
	[self.listView.tableView reloadData];
	self.listView.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	self.listView.searchBar.text = @"";
	[self.listView.searchBar resignFirstResponder];
	self.listView.searchBar.showsCancelButton = NO;
	
	[self.dataProvider.searchData removeAllObjects];
	self.dataProvider.search = NO;
	[self.listView.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[[searchBar valueForKey:@"_searchField"] resignFirstResponder];
}

#pragma mark - Listening to UIKeybord notification 

- (void)onKeyboardHide:(NSNotification *)notification
{
	self.listView.searchBar.showsCancelButton = NO;
}

#pragma mark - EKListViewAddEDelegate stuff

- (void)addButtonPressed
{
    EKAddEViewController *addEVC = [[EKAddEViewController alloc] init];
    [addEVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:addEVC animated:YES completion:nil];
}

@end
