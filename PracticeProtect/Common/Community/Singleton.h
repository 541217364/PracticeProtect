//
//  Singleton.h
//  SYApp
//
//  Created by DuQ on 14/12/12.
//  Copyright (c) 2014年 DuQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import <CoreLocation/CoreLocation.h>

@interface Singleton : NSObject<UIAlertViewDelegate>

@property (nonatomic, assign) BOOL islight;

@property (nonatomic, copy)NSString<Optional> * flag;

@property (nonatomic, strong)UserInfo * userInfo;

@property (nonatomic, strong)NSArray * ships;

@property (nonatomic, strong)NSMutableArray * allViews;

@property (nonatomic, strong)NSArray *colorArray;

@property (nonatomic, strong)NSMutableArray *shoppingData;

@property (nonatomic, assign)CLLocationCoordinate2D centercoordinate;

@property (nonatomic, assign)BOOL  isRefresh;


@property (nonatomic, assign)BOOL  isSaveData;


@property (nonatomic)int HuDCount;

+ (instancetype)shareInstance;

@end

