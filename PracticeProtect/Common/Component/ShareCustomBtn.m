//
//  ShareCustomBtn.m
//  短文学
//
//  Created by xgy_123 on 16/2/26.
//  Copyright © 2016年 xgy_123. All rights reserved.
//

#import "ShareCustomBtn.h"

@implementation ShareCustomBtn



- (id)initWithFrame:(CGRect)frame  {
    
    self =[super initWithFrame:frame];
    
    if (self) {
        
        _headPic=[[UIImageView alloc]initWithFrame:CGRectMake(10,10,frame.size.width-20,frame.size.width-20)];
        
               
        [self addSubview:_headPic];
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height+5,frame.size.width,frame.size.height-frame.size.width-5)];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=[UIFont systemFontOfSize:11];
        [self addSubview:_nameLabel];

        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
