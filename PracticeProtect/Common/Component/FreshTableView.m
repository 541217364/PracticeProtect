//
//  FreshTableView.m
//  卡窝
//
//  Created by 弦断有谁听 on 2018/10/31.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import "FreshTableView.h"

@implementation FreshTableView


-(instancetype)init{
    self = [super init];
    
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.index = 1;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedRowHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
        } else {
            
        }
    }
    
    return self;
}

-(void)setOpenHeader:(BOOL)openHeader{
    if (openHeader) {
        WeakSelf;
         self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakself.refreshheader(1);
            weakself.index = 1;
        }];
    }
}

-(void)setOpenfooter:(BOOL)openfooter{
    if (openfooter) {
        WeakSelf;
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.index ++;
            weakself.refreshfooter(weakself.index);
        }];
        
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return _openMoreTouch;
}

@end
