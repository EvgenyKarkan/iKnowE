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

@property (nonatomic, strong) UIButton *left;
@property (nonatomic, strong) UIButton *right;
@property (nonatomic, assign) BOOL isTableEditing;

@end


@implementation EKListView;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        
		self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
		[self addSubview:self.topView];
        
		self.left = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.left setTitle:@"Edit" forState:UIControlStateNormal];
        self.left.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [self.left setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Edit"] forState:UIControlStateHighlighted];
        [self.left addTarget:self action:@selector(editPressed) forControlEvents:UIControlEventTouchUpInside];
		[self.topView addSubview:self.left];
        
		self.right = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [self.right addTarget:self action:@selector(addPressed) forControlEvents:UIControlEventTouchUpInside];
		[self.topView addSubview:self.right];
        
		self.searchBar = [[UISearchBar alloc] init];
		[self addSubview:self.searchBar];
        
		self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		self.tableView.backgroundView = nil;
        self.tableView.bounces = NO;
		self.tableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
		[self addSubview:self.tableView];
        
		[self customizeSearchBar];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    
	self.left.frame = CGRectMake(10.0f, 7.0f, 60.0f, 30.0f);
	self.right.frame = CGRectMake(285.0f, 7.0f, 30.0f, 30.0f);
    
	self.searchBar.frame = CGRectMake(0.0f, self.topView.frame.size.height, self.frame.size.width, 44.0f);
    
	self.tableView.frame = CGRectMake(0.0f, self.topView.frame.size.height + self.searchBar.frame.size.height,
	                                  self.frame.size.width, self.frame.size.height - (self.topView.frame.size.height + self.searchBar.frame.size.height));
}

#pragma mark - Customize UI
#warning lot of magic
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

#pragma mark - Actions

- (void)editPressed
{
	if (!self.isTableEditing) {
		[self.tableView setEditing:YES animated:YES];
		[UIView animateWithDuration:0.15f
		                 animations: ^{
                             self.left.alpha = 0.0f;
                         } completion: ^(BOOL finished) {
                             [UIView animateWithDuration:0.15f
                                              animations: ^{
                                                  [self.left setTitle:@"Done" forState:UIControlStateNormal];
                                                  [self.left setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Done"] forState:UIControlStateHighlighted];
                                                  self.left.alpha = 1.0f;
                                              } completion:nil];
                         }];
	}
	else {
		[self.tableView setEditing:NO animated:YES];
		[UIView animateWithDuration:0.15f
		                 animations: ^{
                             self.left.alpha = 0.0f;
                         } completion: ^(BOOL finished) {
                             [UIView animateWithDuration:0.15f
                                              animations: ^{
                                                  [self.left setTitle:@"Edit" forState:UIControlStateNormal];
                                                  [self.left setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Edit"] forState:UIControlStateHighlighted];
                                                  self.left.alpha = 1.0f;
                                              } completion:nil];
                         }];
	}
    
	self.isTableEditing = !self.isTableEditing;
}

- (void)addPressed
{
	if (self.delegate) {
		[self.delegate addButtonPressed];
	}
	else {
		NSAssert(self.delegate != nil, @"Delegate should not be nill");
	}
}

@end
