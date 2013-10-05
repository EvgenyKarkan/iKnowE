//
//  EKTextField.m
//  iKnowE
//
//  Created by Evgeny Karkan on 27.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKTextField.h"

@implementation EKTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    CGFloat margin = 8.0f;
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin, bounds.size.height);
    
    return inset;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGFloat margin = 8.0f;
    CGRect inset = CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin, bounds.size.height);
    
    return inset;
}

@end
