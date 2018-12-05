//
//  ViewController.m
//  PracticeProtect
//
//  Created by 周启磊 on 2018/10/18.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<WXApiDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = @"分享的内容";
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
