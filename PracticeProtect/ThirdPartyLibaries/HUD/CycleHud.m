//
//  CycleHud.m
//  EztUser
//
//  Created by eztios on 15/4/16.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

#import "CycleHud.h"



static CycleHud *sharedView;

@implementation CycleHud

+ (CycleHud*)sharedView {
    static dispatch_once_t once;
    
    dispatch_once(&once, ^ {
        
        sharedView = [[CycleHud alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
        sharedView.backgroundColor =[UIColor clearColor]; //TR_COLOR_RGBACOLOR_A(40,43,53, 0.5);
        sharedView.bgView = [[UIView alloc] init];
       //sharedView.bgView.backgroundColor = GRAYCLOLOR;
        sharedView.bgView.alpha = 0.5;
        [sharedView.bgView.layer setMasksToBounds:YES];
        [sharedView.bgView.layer setCornerRadius:10]; //圆角度
        [sharedView addSubview:sharedView.bgView];
        sharedView.bgView.frame = CGRectMake(0, 0, 100, 100);
        CGPoint center = sharedView.center;
        center.y -= 60 + 40;
        sharedView.bgView.center = center;
      //  sharedView.activityIndicator= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0,80, 80)];
        sharedView.cycleImv = [sharedView LoadimgView];//[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
       // sharedView.activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        // sharedView.cycleImv.image = [UIImage imageNamed:@"jiazai"];
      //  sharedView.activityIndicator.center = sharedView.bgView.center;
        //在图片边缘添加一个像素的透明区域，去图片锯齿
          UIGraphicsBeginImageContext(sharedView.cycleImv.frame.size);
           [sharedView.cycleImv.image drawInRect:CGRectMake(1,1,sharedView.cycleImv.frame.size.width-2,sharedView.cycleImv.frame.size.height-2)];
          sharedView.cycleImv.image = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
        [sharedView addSubview:sharedView.activityIndicator];
        
        
        // sharedView.cycleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        sharedView.cycleIcon.image = [UIImage imageNamed:@"cycleIcon.png"];
//        sharedView.cycleIcon.center = sharedView.bgView.center;
        [sharedView addSubview:sharedView.cycleImv];
        
    });
    
    //    sharedView.frame = [[UIScreen mainScreen] bounds];
    
    return sharedView;
}

- (void)fullScreenShow{
    sharedView.frame = CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44);
    [[CycleHud sharedView] start];
}

- (void)partShow{
    [CycleHud sharedView] ;
    TR_Singleton.HuDCount +=1;
    
    if (TR_Singleton.HuDCount>0) {
        NSLog(@"请求数partShow------:%d",TR_Singleton.HuDCount);
        [self addTRView];
        CGRect rect = sharedView.frame;
        rect.size = CGSizeMake(100, 100);
        //    rect.origin.y = ScreenHeight / 2.0 - 40;
        sharedView.frame = rect;
        sharedView.center = APP_Delegate.window.center;
        sharedView.bgView.frame = sharedView.bounds;
        CGPoint center = sharedView.bgView.center;
        
        sharedView.cycleImv.center = CGPointMake(center.x, center.y);
        sharedView.activityIndicator.center = sharedView.bgView.center;
        
        sharedView.cycleIcon.center = sharedView.bgView.center;
        [[CycleHud sharedView] start];
        
        [sharedView bringSubviewToFront:APP_Delegate.window];
    }
}

#pragma mark - Spin
- (void)start {
    
    if(sharedView.isSpinning == NO){
        
        //        CABasicAnimation *animation = [ CABasicAnimation
        //                                       animationWithKeyPath: @"transform" ];
        //        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        //
        //        //围绕Z轴旋转，垂直与屏幕
        //        animation.toValue = [ NSValue valueWithCATransform3D:
        //
        //                             CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
        //        animation.duration = 0.3;
        //        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        //        animation.cumulative = YES;
        //        animation.repeatCount = 1000;
        [sharedView.cycleImv startAnimating];
        
        
        //  [sharedView.cycleImv.layer addAnimation:animation forKey:nil];
        
        [APP_Delegate.window addSubview:sharedView];
        [APP_Delegate.window bringSubviewToFront:sharedView];
    }
    sharedView.isSpinning = YES;
}

- (void)stop{
    TR_Singleton.HuDCount -=1;
    NSLog(@"请求数stop------:%d",TR_Singleton.HuDCount);
    if (TR_Singleton.HuDCount<=0) {

        [self removeTRView];
        [sharedView removeFromSuperview];
        
        [sharedView.cycleImv.layer removeAllAnimations];
        
        sharedView.isSpinning = NO;
        [sharedView.cycleImv stopAnimating];

    }
    
    
}


- (void)addTRView{
    BOOL is = NO;
    for (id view in ROOTVIEW.subviews) {
        if ([view isKindOfClass:[MaskView class]]) {
            is = YES;
        }
    }
    if (!is) {
        MaskView *view  = [[MaskView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.backgroundColor = [UIColor clearColor];
        [APP_Delegate.window addSubview:view];
    }
}

- (void)removeTRView{
    for (id view in APP_Delegate.window.subviews) {
        if ([view isKindOfClass:[MaskView class]]) {
            [view removeFromSuperview];
        }
    }
    
}

- (UIImageView*) LoadimgView {
    
    
    NSMutableArray * array=[NSMutableArray array];
    
    for (int i=1; i<24; i++) {
        
        UIImage *img=nil;
      
            img= [UIImage imageNamed:[NSString stringWithFormat:@"jz%d.png",i]];
        
        // img = [self  scaleToSize:img size:CGSizeMake(100,100)];
        [array addObject:img];
    }
    
    
    
    UIImageView* _mimgView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,90,90)];
    _mimgView.backgroundColor=[UIColor clearColor];
    
    
    _mimgView.animationImages=array;
    [_mimgView setAnimationRepeatCount:0];//
    
    [_mimgView setAnimationDuration:3];
    
    
    
    return _mimgView;
}


@end
@implementation MaskView
@end

