//
//  FreshTableView.h
//  卡窝
//
//  Created by 弦断有谁听 on 2018/10/31.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void(^RefreshHeaderBlock)(NSInteger index);

typedef void(^RefreshFooterBlock)(NSInteger index);


@interface FreshTableView : UITableView<UIGestureRecognizerDelegate>

@property(nonatomic)BOOL openHeader;

@property(nonatomic)BOOL openfooter;

@property(nonatomic,copy)RefreshHeaderBlock refreshheader;

@property(nonatomic,copy)RefreshFooterBlock refreshfooter;

@property(nonatomic)NSInteger index;

@property(nonatomic)BOOL openMoreTouch;

@end
