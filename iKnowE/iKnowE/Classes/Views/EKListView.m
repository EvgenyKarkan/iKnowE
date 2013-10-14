//
//  EKListView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKListView.h"
#import "EKAttributedStringUtil.h"

@interface EKListView ()

@property (nonatomic, strong) UIButton *addButton;

@end


@implementation EKListView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.121569 green:0.329412 blue:0.384314 alpha:1];
        
		self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [UIColor colorWithRed:0.062745 green:0.215686 blue:0.274510 alpha:1];
		[self addSubview:self.topView];
        
		self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.editButton setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
        self.editButton.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.editButton.titleLabel.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
		self.editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[self.editButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Edit"] forState:UIControlStateHighlighted];
		[self.topView addSubview:self.editButton];
        
		self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
		self.cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[self.cancelButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Cancel"] forState:UIControlStateHighlighted];
		self.cancelButton.hidden = YES;
		[self.topView addSubview:self.cancelButton];
        
		self.addButton = [[UIButton alloc] init];
        [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
        self.addButton.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.editButton.titleLabel.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        self.addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.addButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Add"] forState:UIControlStateHighlighted];
		[self.addButton addTarget:self action:@selector(addPressed) forControlEvents:UIControlEventTouchUpInside];
		[self.topView addSubview:self.addButton];
        
		self.searchBar = [[UISearchBar alloc] init];
        self.searchBar.placeholder = @"Search...";
       
        self.searchBar.tintColor = [UIColor colorWithRed:0.121569 green:0.329412 blue:0.384314 alpha:1];
		[self addSubview:self.searchBar];
        [self customizeSearchBar];
        
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		self.tableView.backgroundView = nil;
		self.tableView.bounces = NO;
		self.tableView.backgroundColor = [UIColor colorWithRed:0.121569 green:0.329412 blue:0.384314 alpha:1];
        self.tableView.separatorColor = [UIColor colorWithRed:0.062745 green:0.215686 blue:0.274510 alpha:1];
		[self addSubview:self.tableView];
        
        self.logo = [[UILabel alloc] init];
        self.logo.backgroundColor = [UIColor clearColor];
        self.logo.textAlignment = NSTextAlignmentCenter;
        self.logo.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        self.logo.font = [UIFont fontWithName:@"CicleSemi" size:25.0f];
        self.logo.text = @"iKnowE";
        [self.topView addSubview:self.logo];
    }
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    
	self.editButton.frame = CGRectMake(12.0f, 7.0f, 60.0f, 30.0f);
	self.cancelButton.frame = CGRectMake(12.0f, 7.0f, 60.0f, 30.0f);
	self.addButton.frame = CGRectMake(275.0f, 7.0f, 60.0f, 30.0f);
    
	self.searchBar.frame = CGRectMake(0.0f, self.topView.frame.size.height, self.frame.size.width, 44.0f);
    
	self.tableView.frame = CGRectMake(0.0f, self.topView.frame.size.height + self.searchBar.frame.size.height,
	                                  self.frame.size.width, self.frame.size.height - (self.topView.frame.size.height + self.searchBar.frame.size.height));
    
     self.logo.frame = CGRectMake(self.topView.frame.size.width/2 - 100.0f, 0.0f, 200, 44);
}

#pragma mark - Customize UI

- (void)customizeSearchBar
{
	for (UIView *subview in [self.searchBar subviews]) {
		if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
			[subview removeFromSuperview];
		}
		if ([subview isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *)subview;
			[button setBackgroundImage:[UIImage imageNamed:@"cnacel-bt.png"] forState:UIControlStateNormal];
		}
	}
    
	UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    
	if (searchField != nil) {
		UIImage *image = [UIImage imageNamed:@"search.png"];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		searchField.leftView = imageView;
		UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image];
        
        [searchField setBackground:[UIImage imageNamed:@"search_background.png"]];
		searchField.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
		searchField.returnKeyType = UIReturnKeyDone;
		searchField.rightView = imageView1;
		searchField.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        [searchField setValue:[UIColor colorWithRed:0.529412 green:0.564706 blue:0.635294 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
	}
}

#pragma mark - Actions

- (void)addPressed
{
	if (self.delegate) {
		[self.delegate addButtonPressed];
	}
	else {
		NSAssert(self.delegate != nil, @"Delegate should not be nil");
	}
}

@end
