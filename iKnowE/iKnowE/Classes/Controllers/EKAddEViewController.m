//
//  EKAddEViewController.m
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAddEViewController.h"
#import "EKAddEView.h"


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
	[self.addView.leftButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    [self registerForKeyboardNotifications];
}

#pragma mark - Actions

- (void)cancelPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
	[self.addView.information setFrame:CGRectMake(20.0f, self.addView.name.frame.origin.y + self.addView.name.frame.size.height + 20.0f,
	                                              self.addView.scrollView.frame.size.width - 40.0f, self.addView.frame.size.height - (convertedKeyBoardFrame.origin.y - (self.addView.information.frame.origin.y + self.addView.information.frame.size.height)) - margin)];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
	self.addView.information.frame = CGRectMake(20.0f, self.addView.name.frame.origin.y + self.addView.name.frame.size.height + 20.0f,
	                                            self.addView.scrollView.frame.size.width - 40.0f,
	                                            self.addView.scrollView.frame.size.height - 20.0f - self.addView.eCode.frame.size.height - self.addView.name.frame.size.height - 60.0f);
}

@end
