//
//  EKViewController.m
//  iKnowE
//
//  Created by Evgeny Karkan on 10.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKDetailViewController.h"
#import "EKDetailView.h"
#import "EKAdditiveDescription.h"
#import "EKNavigationBarButtonView.h"

@interface EKDetailViewController () 

@property (nonatomic, strong) EKListViewTableProvider *dataProvider;
@property (nonatomic, strong) EKDetailView *detailView;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) UIButton *splitButton;

@end


@implementation EKDetailViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKDetailView *view = [[EKDetailView alloc] init];
	self.view = view;
	self.detailView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor grayColor];
    
	self.dataProvider = [[EKListViewTableProvider alloc] init];
	[self.dataProvider setDelegate:self];
    
	self.splitButton = [self splitViewButton];
}

#pragma mark - EKListViewTableDelegate stuff from provider

- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath
{
	self.detailView.foo.text = ((EKAdditiveDescription *)data[indexPath.row]).danger;
}

#pragma mark - Split view controller delegate stuff

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
	[self.splitButton addTarget:barButtonItem.target
	                     action:barButtonItem.action
	           forControlEvents:UIControlEventTouchUpInside];
    
	[UIView animateWithDuration:0.2f
	                 animations: ^{
                         self.splitButton.alpha = 1.0f;
                     } completion: ^(BOOL finished) {
                         [self.detailView addSubview:self.splitButton];
                     }];
    
	self.masterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	[UIView animateWithDuration:0.2f
	                 animations: ^{
                         self.splitButton.alpha = 0.0f;
                     } completion: ^(BOOL finished) {
                         [self.splitButton removeFromSuperview];
                     }];
    
	self.masterPopoverController = nil;
}

#pragma mark - Provide button for splitViewController

- (UIButton *)splitViewButton
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setImage:[UIImage imageNamed:@"cnacel-bt"] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:@"cnacel-bt"] forState:UIControlStateHighlighted];
	button.frame = CGRectMake(5.0f, 7.0f, 60.0f, 30.0f);
    
	return button;
}

@end
