//
//  EKAttributedStringUtil.m
//  iKnowE
//
//  Created by Evgeny Karkan on 27.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKAttributedStringUtil.h"


@implementation EKAttributedStringUtil

+ (NSAttributedString *)attributeStringWithString:(NSString *)string
{
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:string];
    [newString addAttribute:NSForegroundColorAttributeName
                      value:[UIColor colorWithRed:0.168627 green:0.647059 blue:0.803922 alpha:1]
                      range:NSMakeRange(0, [string length])];
    
    return newString;
}

@end
