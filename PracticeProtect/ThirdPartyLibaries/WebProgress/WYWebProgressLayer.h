//
//  WLWebProgressLayer.h
//  WangliBank
//
//  Copyright © 2016年 iSoftstone infomation Technology (Group) Co.,Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface WYWebProgressLayer : CAShapeLayer

+ (instancetype)layerWithFrame:(CGRect)frame;

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
