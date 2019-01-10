//
//  AppDelegate.h
//  PracticeProtect
//
//  Created by 弦断有谁听 on 2018/10/18.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic,strong)BMKGeoCodeSearch* geocodesearch;

@property (nonatomic, assign) BMKUserLocation *userLocation;

@property(nonatomic,strong) NSMutableArray *locationArray;

@property(nonatomic,assign) CLLocationCoordinate2D mylocation;

- (void) loadMapManager;


@end

