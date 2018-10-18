//
//  UIColor+UIColorConvert.m
//  ELoanIos
//
//  Created by 研信科技 on 14-8-8.
//  Copyright (c) 2014年 研信科技. All rights reserved.
//

#import "UIColor+UIColorConvert.h"

@implementation UIColor (UIColorConvert)

//颜色转换
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}

@end
