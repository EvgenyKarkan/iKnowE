//
//  EKAddEView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAddEView.h"
#import "EKAttributedStringUtil.h"

@implementation EKAddEView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5f];
		[self addSubview:self.topView];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.leftButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Cancel"] forState:UIControlStateHighlighted];
		[self.topView addSubview:self.leftButton];
        
        self.saveButton = [[UIButton alloc] init];
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.saveButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Save"] forState:UIControlStateHighlighted];
        [self addSubview:self.saveButton];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    self.leftButton.frame = CGRectMake(5.0f, 7.0f, 60.0f, 30.0f);
    self.saveButton.frame = CGRectMake(480.0f, 7.0f, 60.0f, 30.0f);
}


@end
