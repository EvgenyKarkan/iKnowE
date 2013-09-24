//
//  SUBackButtonView.h
//  OCI
//
//  Created by Evgeniy Karkan on 8/29/13.
//  Copyright (c) 2013 Sigma Ukraine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKNavigationBarButtonView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, strong) UILabel *label;

- (id)initWithImageName:(NSString *)imageName
              imageRect:(CGRect)imageRect
                  title:(NSString *)title;

- (void)addTarget:(id)target addAction:(SEL)action;


//SUBackButtonView *backButton = [[SUBackButtonView alloc] initWithImageName:kSUBackButtonImage
//                                                                 imageRect:kSUBackButtonFrame
//                                                                     title:NSLocalizedString(@"Back", @"Back")];
//backButton.frame = kSUBackButtonFrame;
//backButton.label.textColor = [SUTheme colors].backButtonTitleColor;
//[backButton addTarget:self addAction:@selector(popViewController)];
//
//UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//self.navigationItem.leftBarButtonItem = backItem;

    //http://stackoverflow.com/questions/6249416/adding-more-than-two-button-on-the-navigationbar  adding multiple buttons to nav bar

@end


