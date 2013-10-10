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
#warning lot of magic
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topView = [[UIView alloc] init];
		self.topView.backgroundColor = [UIColor colorWithRed:0.062745 green:0.215686 blue:0.274510 alpha:1];
		[self addSubview:self.topView];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.backgroundColor = [UIColor colorWithRed:0.121569 green:0.329412 blue:0.384314 alpha:1];
        [self addSubview:self.scrollView];
        
        self.eCodeField = [[EKTextField alloc] init];
        self.eCodeField.borderStyle = UITextBorderStyleNone;
        self.eCodeField.layer.borderWidth = 1.5f;
        self.eCodeField.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.eCodeField.layer.cornerRadius = 5.0f;
        self.eCodeField.backgroundColor = [UIColor clearColor];
        self.eCodeField.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.eCodeField.placeholder = @"Enter E number";
        self.eCodeField.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        [self.eCodeField setValue:[UIColor colorWithRed:0.529412 green:0.564706 blue:0.635294 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        self.eCodeField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.eCodeField.keyboardType = UIKeyboardTypeDefault;
        self.eCodeField.returnKeyType = UIReturnKeyDone;
        self.eCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.eCodeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.scrollView addSubview:self.eCodeField];
        
        self.nameField = [[EKTextField alloc] init];
        self.nameField.borderStyle = UITextBorderStyleNone;
        self.nameField.layer.borderWidth = 1.5f;
        self.nameField.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.nameField.layer.cornerRadius = 5.0f;
        self.nameField.backgroundColor = [UIColor clearColor];
        self.nameField.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.nameField.placeholder = @"Enter additive's name";
        self.nameField.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        [self.nameField setValue:[UIColor colorWithRed:0.529412 green:0.564706 blue:0.635294 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        self.nameField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.nameField.keyboardType = UIKeyboardTypeDefault;
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.scrollView addSubview:self.nameField];
        
        self.informationField = [[EKPlaceholderTextView alloc] init];
        self.informationField.layer.borderWidth = 1.5f;
        self.informationField.layer.borderColor = [[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] CGColor];
        self.informationField.layer.cornerRadius = 5.0f;
        self.informationField.backgroundColor = [UIColor clearColor];
        self.informationField.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.informationField.placeholder = @"Enter information";
        self.informationField.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        self.informationField.keyboardType = UIKeyboardTypeDefault;
        self.informationField.returnKeyType = UIReturnKeyDone;
        [self.scrollView addSubview:self.informationField];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.cancelButton.titleLabel.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        [self.cancelButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Cancel"] forState:UIControlStateHighlighted];
		[self.topView addSubview:self.cancelButton];
        
        self.saveButton = [[UIButton alloc] init];
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1] forState:UIControlStateNormal];
        self.saveButton.titleLabel.font = [UIFont fontWithName:@"CicleSemi" size:20.0f];
        self.saveButton.titleLabel.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        [self.saveButton setAttributedTitle:[EKAttributedStringUtil attributeStringWithString:@"Save"] forState:UIControlStateHighlighted];
        [self addSubview:self.saveButton];
        
        self.title = [[UILabel alloc] init];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor colorWithRed:0.419608 green:0.937255 blue:0.960784 alpha:1];
        self.title.font = [UIFont fontWithName:@"CicleSemi" size:25.0f];
        self.title.text = @"Add new E";
        [self.topView addSubview:self.title];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
        
	self.topView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 44.0f);
    self.scrollView.frame = CGRectMake(0.0f, self.topView.frame.size.height, self.frame.size.width, self.frame.size.height - self.topView.frame.size.height);
    self.eCodeField.frame = CGRectMake(20.0f, 20.0f, self.scrollView.frame.size.width - 40.0f, 40.0f);
    self.nameField.frame = CGRectMake(20.0f, self.eCodeField.frame.origin.y + self.eCodeField.frame.size.height + 20.0f, self.scrollView.frame.size.width - 40.0f, 40.0f);
    
    self.informationField.frame = CGRectMake(20.0f, self.nameField.frame.origin.y + self.nameField.frame.size.height + 20.0f,
										self.scrollView.frame.size.width - 40.0f, self.scrollView.frame.size.height - 20.0f - self.eCodeField.frame.size.height - self.nameField.frame.size.height - 60.0f);

	self.cancelButton.frame = CGRectMake(8.0f, 7.0f, 60.0f, 30.0f);
	self.saveButton.frame = CGRectMake(480.0f, 7.0f, 60.0f, 30.0f);
    self.title.frame = CGRectMake(self.topView.frame.size.width/2 - 100.0f, 0.0f, 200, 44);
}

@end
