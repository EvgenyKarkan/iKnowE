//
//  EKDetailView.h
//  iKnowE
//
//  Created by Evgeny Karkan on 22.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@protocol EKDetailViewEditDelegate <NSObject>

- (void)editButtonPressed;

@end


@interface EKDetailView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *eCodeView;
@property (nonatomic, strong) UILabel *nameView;
@property (nonatomic, strong) UITextView *infoView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, assign) id<EKDetailViewEditDelegate> delegate;
@property (nonatomic, strong) UILabel *logo;

@end
