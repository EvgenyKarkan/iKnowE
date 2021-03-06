//
//  EKTableSectionHeaderView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 29.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKTableSectionHeaderView.h"

@interface EKTableSectionHeaderView()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) UILabel *title;

@end


@implementation EKTableSectionHeaderView;

- (id)initWithTitle:(NSString *)title
{
	self = [super init];
	if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.062745 green:0.215686 blue:0.274510 alpha:1];
		self.title = [[UILabel alloc] init];
		self.title.backgroundColor = [UIColor clearColor];
        self.title.font = [UIFont fontWithName:@"CicleSemi" size:14.0f];
        self.title.text = title;
        self.title.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
		[self addSubview:self.title];
		[self addGestureRecognizer];
	}
	return self;
}

- (void)addTarget:(id)target addAction:(SEL)action
{
	self.target = target;
	self.action = action;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.title.frame = CGRectMake(20.0f, 5.0f, self.frame.size.width, 12.0f);
}

#pragma mark - Provide gesture recognize

- (void)addGestureRecognizer
{
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
	[self addGestureRecognizer:recognizer];
}

#pragma mark Action

- (void)tap
{
	if (self.target && self.action) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
	}
}

@end
