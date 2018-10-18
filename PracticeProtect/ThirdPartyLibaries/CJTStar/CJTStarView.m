//
//  StarView.m
//  Star
//
//  Created by jkc on 16/4/12.
//  Copyright © 2016年 CJT. All rights reserved.
//

#import "CJTStarView.h"

#define inteval 2

@interface CJTStarView () {
@private NSInteger starCount;//星星个数
@private CGFloat width;//每个星星的平均宽度
}
@property (nonatomic, strong) NSMutableArray *imageArray;
@end
@implementation CJTStarView

- (instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)StarCount {
    if (self = [super initWithFrame:frame]) {
        /*初始化*/
        [self setUserInteractionEnabled:YES];
        self.backgroundColor = [UIColor whiteColor];
        
        starCount = StarCount;
        
        CGSize size = self.frame.size;
        width = (size.width-inteval*(StarCount+1))/StarCount; // 每张图像的宽度
        
        for (int count = 0; count < StarCount; count++) {
            //设置初始的图像
            UIImageView *StarImage = [[UIImageView alloc] initWithImage:self.emptyImage];
            StarImage.frame = CGRectMake(count*width+inteval*(count+1), 0, width, size.height);
            [StarImage setContentMode:UIViewContentModeScaleToFill];
            StarImage.userInteractionEnabled = NO;
            [self addSubview:StarImage];
            
            [self.imageArray addObject:StarImage];
        }
    }
    return self;
}


#pragma mark- event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_istouch) {
        [event touchesForView:self];
        NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
        UITouch *touch = [allTouches anyObject];   //视图中的所有对象
        CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
        
        [UIView animateWithDuration:0.1 animations:^{
            [self starImagesCalcByX:point.x];
        }];
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_istouch) {
        NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
        UITouch *touch = [allTouches anyObject];   //视图中的所有对象
        CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
        
        [self starImagesCalcByX:point.x];
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_istouch) {
        if (_openHalf) {// 如果计算半星
            double Score = (NSInteger)_nowScore;
            if (_nowScore - Score > 0.5) {
                Score += 0.5;
            }
            _nowScore = Score;
        }
        
    }
}



- (void)setnowStart:(double ) num {
    
    if (num == 0) {
        
        return;
    }
    
    CGFloat n=num*width;
    
    [self starImagesCalcByX:n];
}

#pragma mark- private method
/// 计算当点击在 X 上时，每个位置上的星星图片
- (void)starImagesCalcByX:(CGFloat)x {
    _nowScore = x/width;
    _nowScore = _nowScore<starCount?_nowScore:starCount;
    _nowScore = _nowScore>0?_nowScore:0;
    
    int site =0;
    //整数部分都是满星
    for (;site<_nowScore; site++) {
        UIImageView *image = self.imageArray[site];
        image.image = self.fullImage;
    }
    //需判断是否开启半星
    if (site-_nowScore <= 0.5) {
        UIImageView *image = self.imageArray[site-1];
        image.image = self.halfImage;
    }
    
    if (site == _nowScore) {
        
        UIImageView *image = self.imageArray[site-1];
        image.image = self.fullImage;
    }
    
    for (;site<starCount; site++) {
        UIImageView *image = self.imageArray[site];
        image.image = self.emptyImage;
    }
    
}

#pragma mark- getter/setter
- (UIImage *)emptyImage {
    if (!_emptyImage) {
        _emptyImage = [UIImage imageNamed:@"star-empty"];
    }
    return _emptyImage;
}

- (UIImage *)halfImage {
    if (!_halfImage) {
        _halfImage = [UIImage imageNamed:@"star-half"];
    }
    return _halfImage;
}

- (UIImage *)fullImage {
    if (!_fullImage) {
        _fullImage = [UIImage imageNamed:@"star--full"];
    }
    return _fullImage;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
