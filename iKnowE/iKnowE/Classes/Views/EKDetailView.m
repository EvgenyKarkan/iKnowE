//
//  EKDetailView.m
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKDetailView.h"
#import "EKAttributedStringUtil.h"

@interface EKDetailView ()

@property (nonatomic, strong) UILabel *eCodeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *infoLabel;

@end


@implementation EKDetailView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithRed:0.121569 green:0.329412 blue:0.384314 alpha:1];
        
		self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [UIColor colorWithRed:0.062745 green:0.215686 blue:0.274510 alpha:1];
		[self addSubview:self.topView];
        
		self.eCodeView = [[UITextView alloc] init];
		self.nameView = [[UITextView alloc] init];
		self.infoView = [[UITextView alloc] init];
        
		for (UITextView *textView in @[self.eCodeView, self.nameView, self.infoView]) {
			textView.userInteractionEnabled = NO;
            textView.editable = NO;
			textView.layer.borderWidth = 1.5f;
			textView.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
			textView.layer.cornerRadius = 5.0f;
			textView.backgroundColor = [UIColor clearColor];
			textView.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
			textView.font = [UIFont fontWithName:@"CicleSemi" size:30.0f];
			[self addSubview:textView];
		}
        self.infoView.userInteractionEnabled = YES;
        self.infoView.font = [UIFont fontWithName:@"CicleSemi" size:29.0f];
        self.eCodeView.font = [UIFont fontWithName:@"CicleSemi" size:60.0f];
        
		self.eCodeLabel = [[UILabel alloc] init];
		self.nameLabel = [[UILabel alloc] init];
		self.infoLabel = [[UILabel alloc] init];
        
		self.eCodeLabel.text = @"E CODE";
		self.nameLabel.text = @"NAME";
		self.infoLabel.text = @"INFORMATION";
        
		for (UILabel *label in @[self.eCodeLabel, self.nameLabel, self.infoLabel]) {
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont fontWithName:@"CicleSemi" size:18.0f];
			label.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
			[self addSubview:label];
		}
        
        self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.editButton setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
        self.editButton.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.editButton.titleLabel.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
		self.editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[self.editButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Edit"] forState:UIControlStateHighlighted];
        [self.editButton addTarget:self action:@selector(editPressed) forControlEvents:UIControlEventTouchUpInside];
		[self.topView addSubview:self.editButton];
        
        self.logo = [[UILabel alloc] init];
        self.logo.backgroundColor = [UIColor clearColor];
        self.logo.textAlignment = NSTextAlignmentCenter;
        self.logo.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        self.logo.font = [UIFont fontWithName:@"CicleSemi" size:35.0f];
        self.logo.text = @"iKnowE";
        [self.topView addSubview:self.logo];
        
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    
    self.eCodeView.frame = CGRectMake(self.frame.size.width - 250.0f, self.frame.origin.y + 94.0f, 200.0f, 80.0f);
    self.nameView.frame = CGRectMake(50.0f, self.frame.origin.y + 94.0f, self.frame.size.width - 325.0f, 80.0f);
    self.infoView.frame = CGRectMake(50.0f, self.nameView.frame.origin.y + self.nameView.frame.origin.y + 40.0f, self.frame.size.width - 100.0f, self.frame.size.height - 271.0f);
    
    self.eCodeLabel.frame = CGRectMake(self.eCodeView.frame.origin.x, self.eCodeView.frame.origin.y - 20.0f, 80.0f, 25.0f);
    self.nameLabel.frame = CGRectMake(self.nameView.frame.origin.x, self.nameView.frame.origin.y - 20.0f, 80.0f, 25.0f);
    self.infoLabel.frame = CGRectMake(self.infoView.frame.origin.x, self.infoView.frame.origin.y - 20.0f, 120.0f, 25.0f);
    
    self.editButton.frame = CGRectMake(self.frame.size.width - 42.0f, 6.0f, 60.0f, 30.0f);
    self.logo.frame = CGRectMake(self.topView.frame.size.width/2 - 100.0f, 0.0f, 200, 44);
}

#pragma mark - Actions

- (void)editPressed
{
	if (self.delegate) {
		[self.delegate editButtonPressed];
	}
	else {
		NSAssert(self.delegate != nil, @"Delegate should not be nil");
	}
}


@end
