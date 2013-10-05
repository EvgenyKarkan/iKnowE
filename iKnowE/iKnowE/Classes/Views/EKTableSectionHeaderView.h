//
//  EKTableSectionHeaderView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 29.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKTableSectionHeaderView : UIView

- (id)initWithTitle:(NSString *)title;
- (void)addTarget:(id)target addAction:(SEL)action;

@end
