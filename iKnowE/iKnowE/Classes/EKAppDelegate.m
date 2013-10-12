//
//  EKAppDelegate.m
//  iKnowE
//
//  Created by Evgeny Karkan on 10.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAppDelegate.h"
#import "EKListViewController.h"
#import "EKDetailViewController.h"
#import "EKCoreDataProvider.h"

@implementation EKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	EKListViewController *listViewController = [[EKListViewController alloc] init];
	EKDetailViewController *detailViewController = [[EKDetailViewController alloc] init];
	
	self.splitViewController = [[UISplitViewController alloc] init];
	self.splitViewController.viewControllers = @[listViewController, detailViewController];
    self.splitViewController.delegate = detailViewController;
    
	self.window.rootViewController = self.splitViewController;
	[self.window makeKeyAndVisible];
	
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EKCoreDataProvider sharedInstance] saveContext];
}

@end
