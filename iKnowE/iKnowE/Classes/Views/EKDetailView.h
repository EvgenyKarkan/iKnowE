//
//  EKDetailView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKDetailViewEditDelegate <NSObject>

- (void)editButtonPressed;

@end


@interface EKDetailView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITextView *eCodeView;
@property (nonatomic, strong) UITextView *nameView;
@property (nonatomic, strong) UITextView *infoView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, assign) id<EKDetailViewEditDelegate> delegate;

@end
