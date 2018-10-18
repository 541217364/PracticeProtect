//
//  StarView2.h
//  Star
//
//  Created by jkc on 16/4/12.
//  Copyright © 2016年 CJT. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 平滑过渡的星星视图
 */
@interface CJTStarView2 : UIView

/** 满星时候的图片 */
@property (nonatomic,strong) UIImage *fullImage;
/** 空星时候的图片 */
@property (nonatomic,strong) UIImage *emptyImage;

/** 获得当前的分数 */
@property (nonatomic,assign) double nowScore;

#pragma mark- method

/**
 通过星星数量初始化

 @param frame 尺寸
 @param StarCount 星星数量
 @return 初始化结果
 */
-(instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)StarCount;

@end
