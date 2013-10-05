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
#import "Additive.h"
#import "EKSettingsProvider.h"
#import "EKPlistDataProvider.h"
#import "EKCoreDataProvider.h"

@interface EKDetailViewController () 

@property (nonatomic, strong) EKListViewTableProvider *dataProvider;
@property (nonatomic, strong) EKDetailView *detailView;
@property (nonatomic, strong) UIPopoverController *masterPopoverController;
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

	self.dataProvider = [[EKListViewTableProvider alloc] init];
	[self.dataProvider setDelegate:self];
    
    self.splitButton = [self splitViewButton];

	[self preloadDataOnApplicationFinishLaunchingWithSettingsData:[[[EKSettingsProvider alloc] init] sectionWithRowData]];
}

#pragma mark - EKListViewTableDelegate stuff from provider

- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath useCoreData:(BOOL)flag
{
    if (self.masterPopoverController) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }

    if (!flag) {
        [self updateUIWithData:@[((EKAdditiveDescription *)data[indexPath.row]).danger]];
    }
    else {
        [self updateUIWithData:@[((Additive *)data[indexPath.row]).information]];
    }
}

#pragma mark - Split view controller delegate stuff

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController
                                                              withBarButtonItem:(UIBarButtonItem *)barButtonItem
                                                           forPopoverController:(UIPopoverController *)popover
{
	[self.splitButton addTarget:barButtonItem.target
	                     action:barButtonItem.action
	           forControlEvents:UIControlEventTouchUpInside];
    
	[UIView animateWithDuration:0.2f
	                 animations: ^{
                         self.splitButton.alpha = 1.0f;
                     } completion: ^(BOOL finished) {
                         [self.detailView addSubview:self.splitButton];
                         self.masterPopoverController = popover;
                     }];
    
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{    
	[UIView animateWithDuration:0.2f
	                 animations: ^{
                         self.splitButton.alpha = 0.0f;
                     } completion: ^(BOOL finished) {
                         [self.splitButton removeFromSuperview];
                         self.masterPopoverController = nil;
                     }];
}

#pragma mark - UI

- (UIButton *)splitViewButton
{
#warning magic
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setImage:[UIImage imageNamed:@"cnacel-bt"] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:@"cnacel-bt"] forState:UIControlStateHighlighted];
	button.frame = CGRectMake(5.0f, 27.0f, 60.0f, 30.0f);
    
	return button;
}

- (void)updateUIWithData:(NSArray *)data
{
	[UIView animateWithDuration:0.2f
	                 animations: ^{
                         self.detailView.foo.alpha = 0.5f;
                     } completion: ^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                          animations: ^{
                                              self.detailView.foo.text = data[0];
                                              self.detailView.foo.alpha = 1.0f;
                                          } completion:nil];
                     }];
}

- (void)preloadDataOnApplicationFinishLaunchingWithSettingsData:(NSArray *)dataFromSettings
{
	if (dataFromSettings) {
		if ([[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] > 0) {
			if ([[dataFromSettings objectAtIndex:0] integerValue] == 0) {
				if (([dataFromSettings[1] integerValue] + 1) > [[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count]) {
					self.detailView.foo.text = ((Additive *)[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName][[dataFromSettings[1] integerValue] - 1]).information;
				}
				else {
					self.detailView.foo.text = ((Additive *)[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName][[dataFromSettings[1] integerValue]]).information;
				}
			}
			else {
				self.detailView.foo.text = ((EKAdditiveDescription *)[EKPlistDataProvider additiveDescriptions][[[dataFromSettings objectAtIndex:1] integerValue]]).danger;
			}
		}
		else {
			self.detailView.foo.text = ((EKAdditiveDescription *)[EKPlistDataProvider additiveDescriptions][[[dataFromSettings objectAtIndex:1] integerValue]]).danger;
		}
	}
	else {
		self.detailView.foo.text = ((EKAdditiveDescription *)[EKPlistDataProvider additiveDescriptions][0]).danger;
	}
}

@end
