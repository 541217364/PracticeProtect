//
//  StarView.h
//  Star
//
//  Created by jkc on 16/4/12.
//  Copyright © 2016年 CJT. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 普通的星星视图
 */
@interface CJTStarView : UIView

/** 满星时候的图片 */
@property (nonatomic,strong) UIImage *fullImage;
/** 半星时候的图片 */
@property (nonatomic,strong) UIImage *halfImage;
/** 空星时候的图片 */
@property (nonatomic,strong) UIImage *emptyImage;

/** 获得当前的分数 */
@property (nonatomic,assign) double nowScore;

/** 设置是否打开半星（默认关闭） */
@property (nonatomic,assign) bool openHalf;

@property (nonatomic, assign) BOOL istouch;

#pragma mark- method

/**
 通过星星数量初始化
 
 @param frame 尺寸
 @param StarCount 星星数量
 @return 初始化结果
 */
-(instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)StarCount;

- (void)setnowStart:(double ) num;

@end
