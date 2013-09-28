//
//  EKAddEViewController.m
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAddEViewController.h"
#import "EKAddEView.h"
#import "EKCoreDataProvider.h"
#import "EKAppDelegate.h"
#import "EKListViewController.h"

@interface EKAddEViewController ()

@property (nonatomic, strong) EKAddEView *addView;

@end


@implementation EKAddEViewController;

#pragma mark - Life cycle

- (void)loadView
{
	EKAddEView *view = [[EKAddEView alloc] init];
	self.view = view;
	self.addView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.addView.cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.addView.saveButton addTarget:self action:@selector(savePressed) forControlEvents:UIControlEventTouchUpInside];
    [self registerForKeyboardNotifications];
}

#pragma mark - Actions

- (void)cancelPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)savePressed
{
    if ([self validateAllInput]) {
        NSArray *array = @[self.addView.eCodeField.text, self.addView.nameField.text, self.addView.informationField.text];
        [[EKCoreDataProvider sharedInstance] saveEntityWithName:@"Additive" withData:array];
        
        EKAppDelegate *appDelegate = (EKAppDelegate *)[[UIApplication sharedApplication] delegate];
        [((EKListViewController *)appDelegate.splitViewController.viewControllers[0]).listView.tableView reloadData];
        [appDelegate.splitViewController.viewControllers[0] viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
	else {
            //compose HUD
		UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", nil)
		                                                    message:NSLocalizedString(@"ERROR_SAVE_MESSAGE", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [errorView show];
	}

}

#pragma mark - Key board notifications handling

- (void)registerForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWasShown:)
	                                             name:UIKeyboardDidShowNotification object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillBeHidden:)
	                                             name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)aNotification
{
	CGRect keyboardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	CGRect convertedKeyBoardFrame = [self.view convertRect:keyboardFrame fromView:self.view.window];
    
	CGFloat margin;
    
	if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
		margin = 20.0f;
	}
	else {
		margin = 235.0f;
	}
    
	[self.addView.informationField setFrame:CGRectMake(20.0f, self.addView.nameField.frame.origin.y + self.addView.nameField.frame.size.height + 20.0f,
	                                              self.addView.scrollView.frame.size.width - 40.0f, self.addView.frame.size.height - (convertedKeyBoardFrame.origin.y - (self.addView.informationField.frame.origin.y + self.addView.informationField.frame.size.height)) - margin)];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
	self.addView.informationField.frame = CGRectMake(20.0f, self.addView.nameField.frame.origin.y + self.addView.nameField.frame.size.height + 20.0f,
	                                            self.addView.scrollView.frame.size.width - 40.0f,
	                                            self.addView.scrollView.frame.size.height - 20.0f - self.addView.eCodeField.frame.size.height - self.addView.nameField.frame.size.height - 60.0f);
}

#pragma mark - Input validation

- (BOOL)validateAllInput
{
	BOOL valid = NO;
    
	if ((self.addView.eCodeField.text && ![[self.addView.eCodeField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
	    && (self.addView.nameField.text && ![[self.addView.nameField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
	    && (self.addView.informationField.text && ![[self.addView.informationField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])) {
		valid = YES;
	}
	else {
		valid = NO;
	}
    
	return valid;
}

@end
