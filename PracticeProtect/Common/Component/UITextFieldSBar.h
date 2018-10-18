//
//  UITextFieldSBar.h
//  SupionOrdingSystem
//
//  Created by Mai Sidney on 14-5-15.
//  Copyright (c) 2014年 Jeff Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldSBar : UITextField

@property (nonatomic, strong) UILabel * labelTitle;

- (id)initWithFrame:(CGRect)frame Type:(int)type;
@end
