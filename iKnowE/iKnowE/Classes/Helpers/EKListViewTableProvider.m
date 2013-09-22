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

static NSString * const kITReuseIdentifier = @"defaultCell";

@interface EKListViewTableProvider ()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) EKDetailViewController *det;

@end


@implementation EKListViewTableProvider;

#pragma mark - Designated initializer

- (id)initWithDelegate:(id <EKListViewTableDelegate> )delegate
{
	self = [super init];
	if (self) {
		self.delegate = delegate;
		self.data = [[NSArray alloc] init];
	}
    
	return self;
}

#pragma mark - Tableview API

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kITReuseIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kITReuseIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if ([self.data count] > indexPath.row) {
		cell.textLabel.text = ((EKAdditiveDescription *)self.data[indexPath.row]).code;
	}
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 49.80f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	EKAppDelegate *appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.delegate = appDelegate.splitViewController.viewControllers[1];
	
	[self.delegate cellDidPressWithData:self.data withIndexPath:indexPath];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public API

- (void)feedDataSourceWithData:(NSArray *)data
{
	self.data = data;
}

@end
