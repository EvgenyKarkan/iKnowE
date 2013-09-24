//
//  EKListView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKListView.h"
#import "EKNavigationBarButtonView.h"

@interface EKListView ()

@property (nonatomic, strong) UIButton *left;
@property (nonatomic, strong) UIButton *right;

@end

@implementation EKListView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor grayColor];
        
		self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
		[self addSubview:self.topView];
        
		self.left = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [self.left addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
		[self.topView addSubview:self.left];
        
		self.right = [UIButton buttonWithType:UIButtonTypeContactAdd];
		[self.topView addSubview:self.right];
        
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
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    
	self.left.frame = CGRectMake(5.0f, 8.0f, 30, 30);
	self.right.frame = CGRectMake(285, 8, 30, 30);
    
	self.searchBar.frame = CGRectMake(0.0f, self.topView.frame.size.height, self.frame.size.width, 44.0f);
    
	self.tableView.frame = CGRectMake(0.0f, self.topView.frame.size.height + self.searchBar.frame.size.height,
	                                  self.frame.size.width, self.frame.size.height - (self.topView.frame.size.height + self.searchBar.frame.size.height));
}

#pragma mark - Customize UI

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


- (void)edit
{
    NSLog(@"%d %s",__LINE__, __PRETTY_FUNCTION__);
    [self.tableView setEditing:YES animated:YES];
    

}

@end
