//
//  StarView2.m
//  Star
//
//  Created by jkc on 16/4/12.
//  Copyright © 2016年 CJT. All rights reserved.
//

#import "CJTStarView2.h"

@interface CJTStarView2(){
@private NSInteger starCount;//星星个数
@private CGFloat width;//每个星星的平均宽度
}
@property (nonatomic, strong) UIView *frontView;//前置视图
@end

@implementation CJTStarView2

-(instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)StarCount
{
    if (self = [super initWithFrame:frame]) {
        
        /*初始化*/
        [self setUserInteractionEnabled:YES];
        starCount = StarCount;
        CGRect rect = self.frame;
        width = rect.size.width/StarCount;
        self.backgroundColor = [UIColor whiteColor];
        
        for (int count = 0; count < StarCount; count++) {
            //设置初始的图像
            UIImageView *StarImage = [[UIImageView alloc] initWithImage:self.emptyImage];
            StarImage.frame = CGRectMake(count*width, 0, width, rect.size.height);
            [StarImage setContentMode:UIViewContentModeScaleToFill];
            [self addSubview:StarImage];
            
        }
        
        for (int count = 0; count < StarCount; count++) {
            //设置初始的图像
            UIImageView *StarImage = [[UIImageView alloc] initWithImage:self.fullImage];
            StarImage.frame = CGRectMake(count*width, 0, width, rect.size.height);
            [StarImage setContentMode:UIViewContentModeScaleToFill];
            [self.frontView addSubview:StarImage];
        }
        NSLog(@"%f",self.frontView.frame.size.width);
        [self addSubview:self.frontView];
    }
    return self;
}

#pragma mark- event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [event touchesForView:self];
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    [UIView animateWithDuration:0.1 animations:^{
        [self starImagesCalcByX:point.x];
    }];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    
    [self starImagesCalcByX:point.x];
    
}

#pragma mark- private method
/// 计算当点击在 X 上时，每个位置上的星星图片
- (void)starImagesCalcByX:(int)x {
    _nowScore = x/width;
    _nowScore = _nowScore<starCount?_nowScore:starCount;
    _nowScore = _nowScore>0?_nowScore:0;
    
    //获得百分比
    double precent = _nowScore/starCount;
    CGRect rect = self.bounds;
    rect.size.width = precent*rect.size.width;
    //设置新宽度
        self.frontView.frame = rect;
}
#pragma mark- getter/setter
-(UIImage *)emptyImage
{
    if (!_emptyImage) {
        _emptyImage = [UIImage imageNamed:@"star-empty"];
    }
    return _emptyImage;
}


-(UIImage *)fullImage
{
    if (!_fullImage) {
        _fullImage = [UIImage imageNamed:@"star--full"];
    }
    return _fullImage;
}

- (UIView *)frontView {
    if (!_frontView) {
        //设置前置图片
        _frontView = [[UIView alloc] initWithFrame:self.bounds];
        //设置子视图范围不超过父视图
        _frontView.clipsToBounds = YES;
    }
    return _frontView;
}
@end
