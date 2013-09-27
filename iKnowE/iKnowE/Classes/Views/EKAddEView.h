//
//  EKAddEView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 25.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKTextField.h"

@interface EKAddEView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) EKTextField *eCode;
@property (nonatomic, strong) EKTextField *name;
@property (nonatomic, strong) EKTextField *information;

@end
