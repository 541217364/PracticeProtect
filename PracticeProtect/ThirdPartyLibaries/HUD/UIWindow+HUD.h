//
//  UIWindow+HUD.h
//  EztUser
//
//  Created by eztios on 15/4/17.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, showHUDType) {
    ShowPartLoading = 0,//加载中部分
    ShowFullLoading,   //加载全部
    ShowDismiss,//删除
};

@interface UIWindow (HUD)

-(void)showHUDType:(showHUDType)type Enabled:(BOOL)enabled;

@end
