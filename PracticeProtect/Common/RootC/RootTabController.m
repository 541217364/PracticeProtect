//
//  RootTabController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/3/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "RootTabController.h"
#import "RDVTabBarItem.h"
#import "ViewController.h"
@interface RootTabController ()

@end

@implementation RootTabController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self setupViewControllers];
}



- (void)setupViewControllers {
    
    UIViewController *oneVC=[[ViewController alloc]init];
    
   // UIViewController *secondVC=[[RunErrandsViewController alloc]init];
    
//    UIViewController *thirdVC=[[OrderManagementViewController alloc]init];
//
//    UIViewController *fourVC=[[PersonalViewController alloc]init];
    
   // UIViewController *oneNavVC=[[UINavigationController alloc]initWithRootViewController:oneVC];
    
  //  UIViewController*secondNavVC=[[UINavigationController alloc]initWithRootViewController:secondVC];
    
//    UIViewController *thirdNavVC=[[UINavigationController alloc]initWithRootViewController:thirdVC];
//
//    UIViewController *fourNavVC=[[UINavigationController alloc]initWithRootViewController:fourVC];
    
//   
//    [self setViewControllers:@[oneNavVC,thirdNavVC,fourNavVC]];
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController{
    
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"1", @"2", @"3"];
    NSArray *titles =@[@"点呗",@"订单",@"我的"];
    NSInteger index = 0;
    NSDictionary *textAttributes = nil;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        
        NSString *title=titles[index];
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.backgroundColor=[UIColor whiteColor];
        item.title=title;
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont systemFontOfSize:13],
                NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(102,102,102,102),
                           };
        
        item.unselectedTitleAttributes=textAttributes;
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont systemFontOfSize:13],
                NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(241,118,31,175)
                           };
        
        item.selectedTitleAttributes=textAttributes;
        index++;
    }

}




@end
