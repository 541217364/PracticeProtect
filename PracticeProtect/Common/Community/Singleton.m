//
//  Singleton.m
//  SYApp
//
//  Created by DuQ on 14/12/12.
//  Copyright (c) 2014年 DuQ. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

// 获取单例
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        
    });
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



@end
