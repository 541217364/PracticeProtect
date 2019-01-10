//
//  CustomWebController.h
//  卡窝
//
//  Created by 弦断有谁听 on 2018/10/25.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWebController : ShareVC

/**
 请求的url
 */
@property (nonatomic,copy) NSString *urlString;

/**
 要注入的js方法
 */
@property (nonatomic,copy) NSString *jsString;

/**
 进度条颜色
 */
@property (nonatomic,strong) UIColor *loadingProgressColor;

/**
 是否下拉重新加载
 */
@property (nonatomic, assign) BOOL canDownRefresh;

@end
