//
//  EKViewController.m
//  iSayNo
//
//  Created by Evgeny Karkan on 10.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKDetailViewController.h"
#import "EKPlistDataProvider.h"
#import "EKAdditiveDescription.h"

@interface EKDetailViewController ()

@end


@implementation EKDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
	
	NSLog(@"CODE %@", ((EKAdditiveDescription *)[EKPlistDataProvider additiveDescriptions][0]).chemicalName);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
