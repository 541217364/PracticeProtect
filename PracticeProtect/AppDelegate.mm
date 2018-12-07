//
//  AppDelegate.m
//
//  Created by 周启磊 on 2018/10/18.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLAdvertisementController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#define MAPKEY  @"iLk0D54jO0Ihy3wuC6dcYRFPO44ewvHw"
BMKMapManager* _mapManager;

@interface AppDelegate ()<UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    [self loadMapManager];
    
    [WXApi registerApp:@"wx2ae6c139a506a501"];
    
    ZLAdvertisementController *adVC = [[ZLAdvertisementController alloc]init];
    adVC.adtype = 0; //1 单张图片 2 多张图片 3 视频
    self.window.rootViewController = adVC;
    
    [self.window makeKeyAndVisible];
    NSLog(@"1111111111");
    return YES;
}








#pragma mark 百度地图

//百度地图
- (void) loadMapManager {
    BOOL ret = [_mapManager start:MAPKEY generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else {
        //启动成功
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate=self;
        _locationService.distanceFilter=10;
        _geocodesearch = [[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate = self;
        [_locationService startUserLocationService];
    }
    
}

#pragma mark - mapbaidu

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    _userLocation = userLocation;
    _mylocation   = userLocation.location.coordinate;
    [self onClickReverseGeocode];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    
    NSLog(@"++++++++++++++++%@",error);
    
    
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
        
        [_locationService startUserLocationService];
        
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

//反地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == 0) {
        
        if (_locationArray == nil) {
            _locationArray = [NSMutableArray array];
        }
        
        _locationArray=[NSMutableArray arrayWithArray:result.poiList];
        
    }
}

-(void)onClickReverseGeocode{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (_userLocation != nil) {
        pt = _userLocation.location.coordinate;
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
            [_locationService stopUserLocationService];
            
            
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
    }
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

//新的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
        [WXApi handleOpenURL:url delegate:self];
    
        return  YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    NSLog(@"-------------+++++++++%@",pboard.string);
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
