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
#import "EKCoreDataProvider.h"
#import "Additive.h"
#import "EKSettingsProvider.h"

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
    
	[self.listView.editButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.listView.cancelButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(onKeyboardHide:)
	                                             name:UIKeyboardWillHideNotification
	                                           object:nil];
	[self reloadTable];
}

#pragma mark - UISearchBarDelegate stuff

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.listView.searchBar.showsCancelButton = YES;
    
	if (([self.dataProvider.searchPlistData count] > 0) || ([self.dataProvider.searchCoreDataData count] > 0)) {
		[self.dataProvider.searchPlistData removeAllObjects];
		[self.dataProvider.searchCoreDataData removeAllObjects];
	}
	if ([searchText length] > 0) {
		self.dataProvider.search = YES;
		for (NSUInteger i = 0; i < [self.dataProvider.usualData count]; i++) {
			NSRange titleResultsRange = [((EKAdditiveDescription *)self.dataProvider.usualData[i]).code rangeOfString : searchText options : NSCaseInsensitiveSearch];
			if (titleResultsRange.length > 0) {
				[self.dataProvider.searchPlistData addObject:[self.dataProvider.usualData objectAtIndex:i]];
			}
		}
		if ([[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] > 0) {
			for (NSUInteger i = 0; i < [[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count]; i++) {
				NSRange range = [((Additive *)[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName][i]).ecode rangeOfString : searchText
                                                                                                                                               options : NSCaseInsensitiveSearch];
				if (range.length > 0) {
					[self.dataProvider.searchCoreDataData addObject:[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName][i]];
				}
			}
		}
	}
	else {
		self.dataProvider.search = NO;
	}
    
	[self.listView.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	self.listView.searchBar.text = @"";
	[self.listView.searchBar resignFirstResponder];
	self.listView.searchBar.showsCancelButton = NO;
    
	[self.dataProvider.searchPlistData removeAllObjects];
	[self.dataProvider.searchCoreDataData removeAllObjects];
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
	if (self.listView.isTableEditing) {
		[self.listView.tableView setEditing:NO animated:YES];
		[self.listView.cancelButton setHidden:YES];
		[self.listView.editButton setHidden:NO];
		self.listView.isTableEditing = NO;
	}
    
	[self adjustTableViewContent];
	EKAddEViewController *addEVC = [[EKAddEViewController alloc] init];
	[addEVC setModalPresentationStyle:UIModalPresentationFormSheet];
	[self presentViewController:addEVC animated:YES completion:nil];
}

#pragma mark - EKListViewTableDelegate stuff

- (void)sectionHeaderDidTap
{
	[self.listView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
	                               atScrollPosition:UITableViewScrollPositionTop
	                                       animated:YES];
}

- (void)didDeleteRow
{
	if ([[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] == 0) {
		[[[EKSettingsProvider alloc] init] clear];
	}
    
	[UIView animateWithDuration:0.15f
	                 animations: ^{
                         self.listView.tableView.alpha = 0.2f;
                     } completion: ^(BOOL finished) {
                         [UIView animateWithDuration:0.15f
                                          animations: ^{
                                              self.listView.tableView.alpha = 1.0f;
                                              [self.listView.cancelButton setHidden:YES];
                                              [self.listView.tableView setEditing:NO animated:YES];
                                              [self reloadTable];
                                          } completion:nil];
                     }];
	self.listView.isTableEditing = !self.listView.isTableEditing;
}

#pragma mark - Public

- (void)reloadTable
{
	self.listView.editButton.hidden = [[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] > 0 ? NO : YES;
	[self.listView.tableView reloadData];
}

#pragma mark - Action

- (void)buttonPressed
{
	[self adjustTableViewContent];
	[self handleEditState];
}

#pragma mark - Helpers

- (void)adjustTableViewContent
{
	if (self.listView.tableView.contentOffset.y > 0) {
		[self.listView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
		                               atScrollPosition:UITableViewScrollPositionBottom
		                                       animated:YES];
	}
}

- (void)handleEditState
{
	if (self.listView.isTableEditing) {
		[self.listView.tableView setEditing:NO animated:YES];
		[self.listView.cancelButton setHidden:YES];
		[self.listView.editButton setHidden:NO];
		self.listView.isTableEditing = NO;
	}
	else {
		[self.listView.tableView setEditing:YES animated:YES];
		[self.listView.editButton setHidden:YES];
		[self.listView.cancelButton setHidden:NO];
		self.listView.isTableEditing = YES;
	}
}

@end
