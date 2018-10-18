//
//  UIView+Frame.h
//  EZTUser
//
//  Created by eztios on 15/5/26.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(frame)
- (void)setX:(CGFloat)x;

- (CGFloat)x;

- (void)setY:(CGFloat)y;

- (CGFloat)y;

- (void)setOrigin:(CGPoint)origin;

- (CGPoint)origin;

- (void)setWidth:(CGFloat)width;

- (CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (CGFloat)height;

- (void)setSize:(CGSize)size;

- (CGSize)size;

@end
