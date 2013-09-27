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
}

#pragma mark - Actions

- (void)cancelPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
