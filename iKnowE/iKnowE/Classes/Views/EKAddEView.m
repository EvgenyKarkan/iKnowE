//
//  EKAddEView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAddEView.h"

@implementation EKAddEView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5f];
        
        self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
		[self addSubview:self.topView];
        
        
        self.left = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.left setImage:[UIImage imageNamed:@"cnacel-bt"] forState:UIControlStateNormal];
        [self.left setImage:[UIImage imageNamed:@"cnacel-bt"] forState:UIControlStateHighlighted];
		[self.topView addSubview:self.left];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    self.left.frame = CGRectMake(5.0f, 7.0f, 60.0f, 30.0f);
}

@end
