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
        
		self.infoView = [[UITextView alloc] init];
		self.infoView.userInteractionEnabled = YES;
        self.infoView.editable = NO;
        self.infoView.layer.borderWidth = 1.5f;
        self.infoView.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.infoView.layer.cornerRadius = 5.0f;
        self.infoView.backgroundColor = [UIColor clearColor];
        self.infoView.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
		self.infoView.font = [UIFont fontWithName:@"CicleSemi" size:30.0f];
        [self addSubview:self.infoView];
        
        self.eCodeView = [[UITextView alloc] init];
		self.eCodeView.userInteractionEnabled = NO;
        self.eCodeView.layer.borderWidth = 1.5f;
        self.eCodeView.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.eCodeView.layer.cornerRadius = 5.0f;
        self.eCodeView.backgroundColor = [UIColor clearColor];
        self.eCodeView.textColor = [UIColor colorWithRed:0.454902 green:0.458824 blue:0.458824 alpha:1];
		self.eCodeView.font = [UIFont fontWithName:@"CicleSemi" size:30.0f];
		[self addSubview:self.eCodeView];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
	self.infoView.frame = CGRectMake(10.0f, self.topView.frame.size.height + 10.0f + 300, self.frame.size.width - 20.0f, self.frame.size.height - 64.0f - 300);
	self.eCodeView.frame = CGRectMake(self.frame.size.width - 210, self.topView.frame.size.height + 10.0f + 20, 200, 100);
}

@end
