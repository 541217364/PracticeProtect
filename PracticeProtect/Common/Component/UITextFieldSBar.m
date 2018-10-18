//
//  UITextFieldSBar.m
//  SupionOrdingSystem
//
//  Created by Mai Sidney on 14-5-15.
//  Copyright (c) 2014年 Jeff Xu. All rights reserved.
//

#import "UITextFieldSBar.h"
@interface UITextFieldSBar()

@property (nonatomic) int type;
@end
@implementation UITextFieldSBar

- (id)initWithFrame:(CGRect)frame Type:(int)type {
    
    self = [super initWithFrame:frame];
    if (self) {
        _type =type;
        self.returnKeyType = UIReturnKeyDone;
        self.borderStyle=UITextBorderStyleNone;
        self.layer.masksToBounds = YES;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.leftViewMode=UITextFieldViewModeAlways;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.enablesReturnKeyAutomatically = NO;
        
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, 68, 30)];
        _labelTitle.backgroundColor = [UIColor clearColor];
        _labelTitle.textColor =TR_MainColor;
        _labelTitle.font =[UIFont boldSystemFontOfSize:16];
        [self addSubview:_labelTitle];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rect = CGRectZero;
    if (_type==0) {
        rect = CGRectMake(40, bounds.origin.y+3, 218, bounds.size.height);
    }else if(_type==1){
        rect= CGRectMake(40, bounds.origin.y+3, 218, bounds.size.height);
    }
    return rect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    if (_type==0) {
        return CGRectMake(40, 3, SCREEN_WIDTH-60, bounds.size.height);
    }else if(_type==1){
        return CGRectMake(40, 3, SCREEN_WIDTH-60, bounds.size.height);
    }
    return CGRectZero;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    if (_type==0)
        return CGRectMake(10, 8, 24, 24);
    else if(_type==1)
        return CGRectMake(8, 3, 24, 24);
    return CGRectZero;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(40, 0, SCREEN_WIDTH-60, 24);
}
@end
