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
#import "EKCoreDataProvider.h"
#import "Additive.h"

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
		self.searchPlistData = [[NSMutableArray alloc] init];
        self.searchCoreDataData = [[NSMutableArray alloc] init];
		self.appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
	}
	
	return self;
}

#pragma mark - Tableview API

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger number = 0;
    
    if ([[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] > 0) {
        number = 2;
    }
    else {
        number = 1;
    }
    
    return number;
}
#warning magic
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	NSString *title = nil;
//    
//	if ([tableView numberOfSections] == 1) {
//		title = @"Default data";
//	}
//	else {
//		if (section == 0) {
//			title = @"User data";
//		}
//		else {
//			title = @"Default data";
//		}
//	}
//    
//	return title;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f];
    return view;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSUInteger number = 0;
    
	if ([self numberOfSectionsInTableView:tableView] == 1) {
		if (self.search == YES) {
			number = [self.searchPlistData count];
		}
		else {
			number = [self.usualData count];
		}
	}
	else {
		if (section == 1) {
			if (self.search == YES) {
				number = [self.searchPlistData count];
			}
			else {
				number = [self.usualData count];
			}
		}
		else {
			if (self.search == YES) {
				number = [self.searchCoreDataData count];
			}
			else {
				number = [[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count];
			}
		}
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
	if ([tableView numberOfSections] == 1) {
		if (self.search) {
			NSAssert([self.searchPlistData count] > 0, @"SearchPlistData array should have at least one object");
			cell.textLabel.text = ((EKAdditiveDescription *)self.searchPlistData[indexPath.row]).code;
		}
		else {
			cell.textLabel.text = ((EKAdditiveDescription *)self.usualData[indexPath.row]).code;
		}
	}
	else {
		if (self.search) {
			if (indexPath.section == 0) {
				NSAssert([self.searchCoreDataData count] > 0, @"SearchCoreDataData array should have at least one object");
				cell.textLabel.text = ((Additive *)self.searchCoreDataData[indexPath.row]).ecode;
			}
			else {
				NSAssert([self.searchPlistData count] > 0, @"SearchPlistData array should have at least one object");
				cell.textLabel.text = ((EKAdditiveDescription *)self.searchPlistData[indexPath.row]).code;
			}
		}
		else {
			if (indexPath.section == 0) {
				NSAssert([[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] > 0, @"Fetched array should have at least one entity");
				cell.textLabel.text = ((Additive *)[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName][indexPath.row]).ecode;
			}
			else {
				cell.textLabel.text = ((EKAdditiveDescription *)self.usualData[indexPath.row]).code;
			}
		}
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
		[self.delegate cellDidPressWithData:self.searchPlistData withIndexPath:indexPath];
	}
	else {
		[self.delegate cellDidPressWithData:self.usualData withIndexPath:indexPath];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		return NO;
	}
	return YES;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
