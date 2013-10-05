//
//  EKAddEView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextField.h"
#import "EKPlaceholderTextView.h"

@interface EKAddEView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) EKTextField *eCodeField;
@property (nonatomic, strong) EKTextField *nameField;
@property (nonatomic, strong) EKPlaceholderTextView *informationField;

@end
