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
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f];
        [self addSubview:self.scrollView];
        
        self.eCode = [[EKTextField alloc] init];
        self.eCode.borderStyle = UITextBorderStyleNone;
        self.eCode.layer.borderWidth = 1.0f;
        self.eCode.layer.borderColor = [[UIColor grayColor] CGColor];
        self.eCode.layer.cornerRadius = 5.0f;
        self.eCode.backgroundColor = [UIColor clearColor];
        self.eCode.font = [UIFont systemFontOfSize:15.0f];
        self.eCode.placeholder = @"Enter E number";
        self.eCode.autocorrectionType = UITextAutocorrectionTypeNo;
        self.eCode.keyboardType = UIKeyboardTypeDefault;
        self.eCode.returnKeyType = UIReturnKeyDone;
        self.eCode.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.eCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.scrollView addSubview:self.eCode];
        
        self.name = [[EKTextField alloc] init];
        self.name.borderStyle = UITextBorderStyleNone;
        self.name.layer.borderWidth = 1.0f;
        self.name.layer.borderColor = [[UIColor grayColor] CGColor];
        self.name.layer.cornerRadius = 5.0f;
        self.name.backgroundColor = [UIColor clearColor];
        self.name.font = [UIFont systemFontOfSize:15.0f];
        self.name.placeholder = @"Enter additive name";
        self.name.autocorrectionType = UITextAutocorrectionTypeNo;
        self.name.keyboardType = UIKeyboardTypeDefault;
        self.name.returnKeyType = UIReturnKeyDone;
        self.name.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.scrollView addSubview:self.name];
        
        self.information = [[EKTextView alloc] init];
        self.information.layer.borderWidth = 1.0f;
        self.information.layer.borderColor = [[UIColor grayColor] CGColor];
        self.information.layer.cornerRadius = 5.0f;
        self.information.backgroundColor = [UIColor clearColor];
        self.information.font = [UIFont systemFontOfSize:15.0f];
        self.information.placeholder = @"Enter description";
        self.information.keyboardType = UIKeyboardTypeDefault;
        self.information.returnKeyType = UIReturnKeyDone;
        [self.scrollView addSubview:self.information];
        
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
    self.scrollView.frame = CGRectMake(0.0f, self.topView.frame.size.height, self.frame.size.width, self.frame.size.height - self.topView.frame.size.height);
    self.eCode.frame = CGRectMake(20.0f, 20.0f, self.scrollView.frame.size.width - 40.0f, 40.0f);
    self.name.frame = CGRectMake(20.0f, self.eCode.frame.origin.y + self.eCode.frame.size.height + 20.0f, self.scrollView.frame.size.width - 40.0f, 40.0f);
    
    self.information.frame = CGRectMake(20.0f, self.name.frame.origin.y + self.name.frame.size.height + 20.0f,
                                        self.scrollView.frame.size.width - 40.0f, self.scrollView.frame.size.height - 20.0f - self.eCode.frame.size.height - self.name.frame.size.height -60.0f);

    self.leftButton.frame = CGRectMake(5.0f, 7.0f, 60.0f, 30.0f);
    self.saveButton.frame = CGRectMake(480.0f, 7.0f, 60.0f, 30.0f);
}


@end
