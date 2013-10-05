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
    [newString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.125490 green:0.356863 blue:0.407843 alpha:1] range:NSMakeRange(0, [string length])];
    
    return newString;
}

@end
