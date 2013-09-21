//
//  EKAppDelegate.m
//  iSayNo
//
//  Created by Evgeny Karkan on 10.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAppDelegate.h"
#import "EKListViewController.h"
#import "EKDetailViewController.h"

@interface EKAppDelegate ()

@property (nonatomic, strong) UISplitViewController *splitViewController;

@end

@implementation EKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	EKListViewController *listViewController = [[EKListViewController alloc] init];
	EKDetailViewController *detailViewController = [[EKDetailViewController alloc] init];
	
	UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
	splitViewController.viewControllers = @[listViewController, detailViewController];
	
	self.window.rootViewController = splitViewController;
	[self.window makeKeyAndVisible];
	
    return YES;
}
							

@end
