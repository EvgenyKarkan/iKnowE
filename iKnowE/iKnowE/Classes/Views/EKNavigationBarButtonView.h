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

@end


