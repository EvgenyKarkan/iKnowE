//
//  EKListView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKListView.h"

@implementation EKListView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.navigationBar = [[UINavigationBar alloc] init];
		[self addSubview:self.navigationBar];
		
		self.searchBar = [[UISearchBar alloc] init];
		[self addSubview:self.searchBar];
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		[self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	self.navigationBar.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
	
	self.searchBar.frame = CGRectMake(0.0f, self.navigationBar.frame.size.height, self.frame.size.width, 44.0f);
	
	self.tableView.frame = CGRectMake(0.0f, self.navigationBar.frame.size.height + self.searchBar.frame.size.height,
									  self.frame.size.width, self.frame.size.height - (self.navigationBar.frame.size.height + self.searchBar.frame.size.height));
}

@end
