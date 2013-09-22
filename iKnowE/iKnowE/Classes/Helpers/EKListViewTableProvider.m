//
//  EKListViewTableProvider.m
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKListViewTableProvider.h"
#import "EKAdditiveDescription.h"
#import "EKDetailViewController.h"
#import "EKAppDelegate.h"
#import "EKListViewController.h"

static NSString * const kITReuseIdentifier = @"defaultCell";

@interface EKListViewTableProvider ()

@property (nonatomic, strong) EKAppDelegate *appDelegate;

@end


@implementation EKListViewTableProvider;

#pragma mark - Designated initializer

- (id)initWithDelegate:(id <EKListViewTableDelegate> )delegate
{
	self = [super init];
	if (self) {
		self.delegate = delegate;
		self.usualData = [[NSArray alloc] init];
		self.searchData = [[NSMutableArray alloc] init];
		self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	}
	
	return self;
}

#pragma mark - Tableview API

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSUInteger number = 0;
	
	if (self.search == YES) {
		number = [self.searchData count];
	}
	else {
		number = [self.usualData count];
	}
	
	return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kITReuseIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kITReuseIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (self.search == YES) {
		cell.textLabel.text = ((EKAdditiveDescription *)self.searchData[indexPath.row]).code;
	}
	else {
		cell.textLabel.text = ((EKAdditiveDescription *)self.usualData[indexPath.row]).code;
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 49.80f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.delegate = self.appDelegate.splitViewController.viewControllers[1];
	
	if (self.search) {
		[self.delegate cellDidPressWithData:self.searchData withIndexPath:indexPath];
	}
	else {
		[self.delegate cellDidPressWithData:self.usualData withIndexPath:indexPath];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public API

- (void)feedDataSourceWithData:(NSArray *)data
{
	self.usualData = data;
}

@end
