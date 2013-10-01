//
//  EKListViewController.h
//  iKnowE
//
//  Created by Evgeny Karkan on 20.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKListView.h"

@interface EKListViewController : UIViewController

@property (nonatomic, strong) EKListView *listView;

- (void)reloadTable;

@end
