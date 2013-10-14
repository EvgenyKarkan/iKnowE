//
//  EKEditViewController.m
//  iKnowE
//
//  Created by Evgeny Karkan on 10.10.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKEditViewController.h"
#import "EKListViewController.h"
#import "EKAppDelegate.h"
#import "EKCoreDataProvider.h"
#import "EKDetailViewController.h"


@implementation EKEditViewController

- (void)savePressed
{
	if ([self validateAllInput]) {
		NSArray *array = @[self.addView.eCodeField.text, self.addView.nameField.text, self.addView.informationField.text];
        
		[[EKCoreDataProvider sharedInstance] updateEnityWithName:kEKEntityName withIndex:self.index withData:array];
        
		EKAppDelegate *appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
        
		__weak EKListViewController *weakListViewController = (EKListViewController *)appDelegate.splitViewController.viewControllers[0];
		__weak EKDetailViewController *weakDetailViewController = (EKDetailViewController *)appDelegate.splitViewController.viewControllers[1];
        
		[self dismissViewControllerAnimated:YES completion: ^{
		    [UIView animateWithDuration:0.2f
		                     animations: ^{
                                 weakListViewController.listView.tableView.alpha = 0.2f;
                             } completion: ^(BOOL finished) {
                                 [UIView animateWithDuration:0.2f
                                                  animations: ^{
                                                      [weakDetailViewController updateUIWithData:array];
                                                      [weakListViewController reloadTable];
                                                      weakListViewController.listView.tableView.alpha = 1.0f;
                                                  } completion:nil];
                             }];
		}];
	}
	else {
		[SVProgressHUD showErrorWithStatus:NSLocalizedString(@"All fields must be filled", nil)];
	}
}

@end
