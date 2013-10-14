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
#import "EKAppDelegate.h"
#import "EKListViewController.h"
#import "EKAttributedStringUtil.h"
#import "EKEditViewController.h"

@interface EKDetailViewController () <EKDetailViewEditDelegate>

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
    self.detailView.delegate = self;
}

#pragma mark - EKListViewTableDelegate stuff from provider

- (void)cellDidPressWithData:(NSArray *)data withIndexPath:(NSIndexPath *)indexPath useCoreData:(BOOL)flag
{
    if (self.masterPopoverController) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }

    if (!flag) {
        [self updateUIWithData:@[ ((EKAdditiveDescription *)data[indexPath.row]).code, ((EKAdditiveDescription *)data[indexPath.row]).chemicalName,
                                  ((EKAdditiveDescription *)data[indexPath.row]).danger,]];
        [self hideEditButton];
    }
    else {
        [self updateUIWithData:@[((Additive *)data[indexPath.row]).ecode, ((Additive *)data[indexPath.row]).name, ((Additive *)data[indexPath.row]).information]];
        [self showEditButton];
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

#pragma mark - Public stuff

- (void)updateUIWithData:(NSArray *)data
{
	[UIView animateWithDuration:0.2f
	                 animations: ^{
                         self.detailView.infoView.alpha = 0.5f;
                         self.detailView.eCodeView.alpha = 0.5f;
                         self.detailView.nameView.alpha = 0.5f;
                     } completion: ^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                          animations: ^{
                                              self.detailView.eCodeView.text = data[0];
                                              self.detailView.nameView.text = data[1];
                                              self.detailView.infoView.text = data[2];
                                              self.detailView.eCodeView.alpha = 1.0f;
                                              self.detailView.nameView.alpha = 1.0f;
                                              self.detailView.infoView.alpha = 1.0f;
                                          } completion: ^(BOOL finished) {
                                              [self.detailView.infoView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                                          }];
                     }];
}

- (void)updateItselfOnDeletionWithIndexPath:(NSIndexPath *)index
{
	NSArray *array = nil;
	if ([[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count] == 0) {
		EKAdditiveDescription *additive = [EKPlistDataProvider additiveWithIndex:0];
		array = @[additive.code, additive.chemicalName, additive.danger];
	}
	else {
		if (index.row == 0) {
			Additive *additive = [[EKCoreDataProvider sharedInstance] additiveWithIndex:index.row];
			array = @[additive.ecode, additive.name, additive.information];
		}
		else {
			Additive *additive = [[EKCoreDataProvider sharedInstance] additiveWithIndex:index.row - 1];
			array = @[additive.ecode, additive.name, additive.information];
		}
	}
	[self updateUIWithData:array];
}

#pragma mark - UI

- (UIButton *)splitViewButton
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
	[button setTitle:@"List" forState:UIControlStateNormal];
	[button setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
	[button setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"List"] forState:UIControlStateHighlighted];
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	button.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
	button.frame = CGRectMake(12.0f, 7.0f, 60.0f, 30.0f);
    
	return button;
}

- (void)preloadDataOnApplicationFinishLaunchingWithSettingsData:(NSArray *)dataFromSettings
{
    EKAppDelegate *dummy = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger numberOfSections = [((EKListViewController *)dummy.splitViewController.viewControllers[0]).listView.tableView numberOfSections];
    NSInteger entitiesCount = [[[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName] count];
    NSArray *allEntities = [[EKCoreDataProvider sharedInstance] fetchedEntitiesForEntityName:kEKEntityName];
    NSArray *allEDescriptions = [EKPlistDataProvider additiveDescriptions];
    
	if (dataFromSettings) {
		if (numberOfSections == 2) {
			if ([dataFromSettings[0] integerValue] == 0) {
				if ([dataFromSettings[1] integerValue] <= entitiesCount - 1) {
                    self.detailView.eCodeView.text = ((Additive *)allEntities[[dataFromSettings[1] integerValue]]).ecode;
                    self.detailView.nameView.text = ((Additive *)allEntities[[dataFromSettings[1] integerValue]]).name;
					self.detailView.infoView.text = ((Additive *)allEntities[[dataFromSettings[1] integerValue]]).information;
				}
				else {
                    self.detailView.eCodeView.text = ((Additive *)allEntities[0]).ecode;
                    self.detailView.nameView.text = ((Additive *)allEntities[0]).name;
					self.detailView.infoView.text = ((Additive *)allEntities[0]).information;
				}
                self.detailView.editButton.hidden = NO;
			}
			else {
				self.detailView.infoView.text = ((EKAdditiveDescription *)allEDescriptions[[dataFromSettings[1] integerValue]]).danger;
                self.detailView.eCodeView.text = ((EKAdditiveDescription *)allEDescriptions[[dataFromSettings[1] integerValue]]).code;
                self.detailView.nameView.text = ((EKAdditiveDescription *)allEDescriptions[[dataFromSettings[1] integerValue]]).chemicalName;
                self.detailView.editButton.hidden = YES;
			}
		}
		else {
			self.detailView.infoView.text = ((EKAdditiveDescription *)allEDescriptions[[dataFromSettings[1] integerValue]]).danger;
            self.detailView.eCodeView.text = ((EKAdditiveDescription *)allEDescriptions[[dataFromSettings[1] integerValue]]).code;
            self.detailView.nameView.text = ((EKAdditiveDescription *)allEDescriptions[[dataFromSettings[1] integerValue]]).chemicalName;
            self.detailView.editButton.hidden = YES;
		}
	}
	else {
		self.detailView.infoView.text = ((EKAdditiveDescription *)allEDescriptions[0]).danger;
        self.detailView.eCodeView.text = ((EKAdditiveDescription *)allEDescriptions[0]).code;
        self.detailView.nameView.text = ((EKAdditiveDescription *)allEDescriptions[0]).chemicalName;
        self.detailView.editButton.hidden = YES;
	}
}

- (void)showEditButton
{
	if (self.detailView.editButton.hidden) {
		[UIView animateWithDuration:0.2f animations: ^{
		    self.detailView.editButton.alpha = 1.0f;
		} completion: ^(BOOL finished) {
		    [self.detailView.editButton setHidden:NO];
		}];
	}
}

- (void)hideEditButton
{
	[UIView animateWithDuration:0.2f animations: ^{
	    self.detailView.editButton.alpha = 0.0f;
	} completion: ^(BOOL finished) {
	    [self.detailView.editButton setHidden:YES];
	}];
}

#pragma mark - EKDetailViewEditDelegate stuff 

- (void)editButtonPressed
{
    EKEditViewController *editVC = [[EKEditViewController alloc] init];
	[editVC setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:editVC animated:YES completion:nil];
    
    editVC.addView.title.text = @"Edit E";
    editVC.index = [[[[EKSettingsProvider alloc] init] sectionWithRowData][1] integerValue];;
    editVC.addView.eCodeField.text = self.detailView.eCodeView.text;
    editVC.addView.nameField.text = self.detailView.nameView.text;
    editVC.addView.informationField.text = self.detailView.infoView.text;
}

@end
