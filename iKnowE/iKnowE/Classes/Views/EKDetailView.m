//
//  EKDetailView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKDetailView.h"

@implementation EKDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor grayColor];
		        
        self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
		[self addSubview:self.topView];
        
		self.foo = [[UITextView alloc] init];
		self.foo.userInteractionEnabled = NO;
		self.foo.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
		self.foo.backgroundColor = [UIColor orangeColor];
		[self addSubview:self.foo];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
    self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
	self.foo.frame = CGRectMake(10.0f, 54.0f, self.frame.size.width - 20.0f, self.frame.size.height - 64.0f);
}

@end
