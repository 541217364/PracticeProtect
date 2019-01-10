#import "ShareUI.h"
#import "AppDelegate.h"
#import "CycleHud.h"
#import "TKAlertCenter.h"
#import "HBHttpTool.h"
#import "Singleton.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "TRClassMethod.h"
#import "TRLib.h"
#import "TRClassMethod.h"
#import "Reachability.h"
#import "UIColor+UIColorConvert.h"
#import "JSONModel.h"
#import "CustomWebController.h"
#import <SDCycleScrollView.h>

// 动画时间
#define ANIMATIONDURATION 0.3

// 网络请求单例
#define NETWORK_OPERATOR [SWNetworkManager shareManager]

// app 根视图
#define ROOTVIEW [TRClassMethod getRootView]

//通知中心
#define WTNotificationCenter [NSNotificationCenter defaultCenter]

#define ROOTVC [TRClassMethod getRootVC]

#define RootAddSubView(param) [TRClassMethod addSubView:param]

#define APP_Delegate  ((AppDelegate*)[[UIApplication sharedApplication]delegate])

#define MAINSCREENBOUNDS [[UIScreen mainScreen] bounds]

#pragma 获取设备ID
#define DeviceID  [[[UIDevice currentDevice] identifierForVendor] UUIDString]

// 存储单例
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

#define TR_Singleton [Singleton shareInstance]

#define TR_Message(param)     [TRClassMethod  showMsg:param]

#define NARBAR_Y 20

#define TabbarHeight 50
#define CommonFont  [UIFont systemFontOfSize:14]



#pragma mark  颜色

#define TR_TEXTGrayCOLOR TR_COLOR_RGBACOLOR_A(113, 113, 113, 1.0)
#define TR_MainColor TR_COLOR_RGBACOLOR_A(222,92,59,1)
#define TR_GrayBackground TR_COLOR_RGBACOLOR_A(236, 236, 236, 1.0);
#define TR_LINEGRAYBackground  TR_COLOR_RGBACOLOR_A(186,186,186, 1.0);
#define GRAYCLOLOR  TR_COLOR_RGBACOLOR_A(239, 239, 239, 1)
#define ORANGECOLOR TR_COLOR_RGBACOLOR_A(255, 144, 56, 1)
#define GRAY_Text_COLOR  TR_COLOR_RGBACOLOR_A(85, 85, 85, 1)
#define LITTLEGRAY  TR_COLOR_RGBACOLOR_A(231, 232, 231, 1)


#pragma mark - 文字

/*
 *全局参数
 */

//百度地图AK
#define MAP_AK  @"r4HouLNaFBG7kOmFWsh8IOoDucQIhbX9"


// 微信相关参数
#define WXAPPSECRET @"19d873e93bfe1b721054ffe712ac5a38"

#define WXAPPID     @"wx41f8b495e4b5faf8"




static NSString * const PLACEHOLDIMAGE = @"placehold-image";





//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//尺寸适配
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏和状态栏高度
#define HeightForNagivationBarAndStatusBar (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)










//本地判断用户登录
#define GetUser_Login_State [[NSUserDefaults standardUserDefaults] boolForKey:@"USER_IS_LOGIN"]

#define SetUser_Login_State(state) [[NSUserDefaults standardUserDefaults] setBool:state forKey:@"USER_IS_LOGIN"]


#define WeakSelf __weak typeof (self)weakself = self

#define StrongSelf __strong typeof (self)strongself = self




