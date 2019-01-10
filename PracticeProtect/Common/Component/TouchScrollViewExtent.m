//
//  TouchScrollViewExtent.m
//  嘀嘀点呗
//
//  Created by 弦断有谁听 on 2018/3/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "TouchScrollViewExtent.h"

@implementation TouchScrollViewExtent


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
