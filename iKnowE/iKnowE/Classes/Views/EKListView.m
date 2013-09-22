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
		self.backgroundColor = [UIColor grayColor];
        self.navigationBar = [[UINavigationBar alloc] init];
		[self addSubview:self.navigationBar];
		
		self.searchBar = [[UISearchBar alloc] init];
		[self addSubview:self.searchBar];
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		self.tableView.backgroundView = nil;
		self.tableView.backgroundColor = [UIColor grayColor];
		[self addSubview:self.tableView];
		
		[self customizeSearchBar];
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

- (void)customizeSearchBar
{
//	for (UIView *subview in[self.searchBar subviews]) {
//		if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//			[subview removeFromSuperview];
//		}
//	}
    
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    searchField.returnKeyType = UIReturnKeyDone;
	
	if (searchField != nil) {
		[searchField setBackground:[UIImage imageNamed:@"search_background.png"]];
		
		UIImage *image = [UIImage imageNamed:@"search.png"];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		searchField.leftView = imageView;
		UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image];
		
		searchField.rightView = imageView1;
		searchField.textColor = [UIColor lightGrayColor];
	}
}


@end
