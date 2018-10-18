//
//  CycleHud.h
//  EztUser
//
//  Created by eztios on 15/4/16.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CycleHud : UIView {
    
    
}

@property (nonatomic, strong)UIImageView *cycleIcon;

@property (nonatomic, strong)UIView *bgView;
//加载图片（旋转）
@property (nonatomic, strong) UIImageView *cycleImv;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator ;

//是否正在运行
@property (nonatomic) BOOL isSpinning;

+ (CycleHud*)sharedView;

- (void)fullScreenShow;

- (void)partShow;

- (void)stop;

- (UIImageView*)createGIF;

@end

@interface MaskView : UIView
@end

