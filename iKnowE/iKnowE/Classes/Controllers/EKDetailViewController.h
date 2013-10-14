//
//  EKViewController.h
//  iKnowE
//
//  Created by Evgeny Karkan on 10.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKListViewTableProvider.h"

@interface EKDetailViewController : UIViewController <EKListViewTableDelegate, UISplitViewControllerDelegate>

- (void)updateUIWithData:(NSArray *)data;
- (void)updateItselfOnDeletionWithIndexPath:(NSIndexPath *)index;

@end
