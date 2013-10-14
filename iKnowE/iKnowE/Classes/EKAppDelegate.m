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
#import "EKPlistDataProvider.h"
#import "Flurry.h"

static NSString * const kEKFlurryKey = @"QG97GTD5QD7JK6KJCCS2";


@implementation EKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[NSThread sleepForTimeInterval:3.0f];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
	EKListViewController *listViewController = [[EKListViewController alloc] init];
	EKDetailViewController *detailViewController = [[EKDetailViewController alloc] init];
    
	self.splitViewController = [[UISplitViewController alloc] init];
	self.splitViewController.viewControllers = @[listViewController, detailViewController];
	self.splitViewController.delegate = detailViewController;
    
	self.window.rootViewController = self.splitViewController;
	[self.window makeKeyAndVisible];
    
	[self preloadSettingsInfo];
    
	[Flurry startSession:kEKFlurryKey];
    
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[[EKCoreDataProvider sharedInstance] saveContext];
}

- (void)preloadSettingsInfo
{
	[[NSUserDefaults standardUserDefaults] setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"version"];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", [[EKPlistDataProvider additiveDescriptions] count]] forKey:@"count"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
