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
        self.backgroundColor = [UIColor colorWithRed:0.121569 green:0.329412 blue:0.384314 alpha:1];
        
        self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [UIColor colorWithRed:0.062745 green:0.215686 blue:0.274510 alpha:1];
		[self addSubview:self.topView];
        
		self.foo = [[UITextView alloc] init];
		self.foo.userInteractionEnabled = YES;

        self.foo.layer.borderWidth = 1.0f;
        self.foo.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.foo.layer.cornerRadius = 5.0f;
        self.foo.backgroundColor = [UIColor clearColor];
        self.foo.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
		self.foo.font = [UIFont fontWithName:@"CicleSemi" size:30.0f];
        [self addSubview:self.foo];
        
        self.foo2 = [[UITextView alloc] init];
		self.foo2.userInteractionEnabled = NO;
        self.foo2.layer.borderWidth = 1.0f;
        self.foo2.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.foo2.layer.cornerRadius = 5.0f;
        self.foo2.backgroundColor = [UIColor clearColor];
        self.foo2.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
		self.foo2.font = [UIFont fontWithName:@"Neometric-Medium" size:30.0f];
		[self addSubview:self.foo2];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
    self.topView.frame = CGRectMake(0.0f, 20.0f, self.frame.size.width, 44.0f);
	self.foo.frame = CGRectMake(10.0f, self.topView.frame.size.height + 10.0f+300+20, self.frame.size.width - 20.0f, self.frame.size.height - 64.0f-300-20);
    self.foo2.frame = CGRectMake(self.frame.size.width - 210, self.topView.frame.size.height + 10.0f+20, 200, 100);
}

@end
