//
//  SUBackButtonView.m
//  OCI
//
//  Created by Evgeniy Karkan on 8/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import "EKNavigationBarButtonView.h"

static CGRect const kSULabelRect = { 13.0f, 5.0f, 40.0f, 20.0f };

@interface EKNavigationBarButtonView()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@end


@implementation EKNavigationBarButtonView

#pragma mark - Public methods

- (id)initWithImageName:(NSString *)imageName imageRect:(CGRect)imageRect title:(NSString *)title 
{
	self = [super init];
	if (self) {
		self.imageRect = imageRect;
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
		[self addSubview:self.imageView];
        [self addTitleLabelWithTitle:title];
        [self addGestureRecognizer];
	}
	return self;
}

- (void)addTarget:(id)target addAction:(SEL)action
{
    self.target = target;
    self.action = action;
}

#pragma mark - Private methods

- (void)addTitleLabelWithTitle:(NSString *)title
{
    if (title) {
        self.label = [[UILabel alloc] init];
        self.label.text = title;
            //self.label.font = 
        self.label.backgroundColor = [UIColor clearColor];
        [self.imageView addSubview:self.label];
    }
}

- (void)addGestureRecognizer
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:recognizer];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.imageView.frame = self.imageRect;
	self.label.frame = kSULabelRect;
}

#pragma mark Action

- (void)tap
{
    if (self.target && self.action){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
    }
}

@end
