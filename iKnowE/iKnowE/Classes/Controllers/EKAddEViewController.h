//
//  EKAddEViewController.h
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAddEView.h"

@interface EKAddEViewController : UIViewController

@property (nonatomic, strong) EKAddEView *addView;

- (void)savePressed;
- (BOOL)validateAllInput;

@end
