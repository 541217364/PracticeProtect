//
//  UILabel+Text.m
//  EZTUser
//
//  Created by eztios on 15/5/27.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

#import "UILabel+Text.h"

@implementation UILabel(Text)

- (void)setMText:(NSString *)text{
    if (TR_isNotEmpty(text)) {
        self.text = text;
    }
}
- (NSString *)mText{
    return self.text;
}
@end
