//  类方法集合

#import <Foundation/Foundation.h>

@interface TRClassMethod : NSObject
+ (void)addSubView:(id)view;

+ (void)JumpView:(id)className;

+ (BOOL)getNetStatus;

+ (NSString *)getFilePath;

#pragma mark - is iPhone4 4s
+ (BOOL)isIPhone4;

#pragma mark - is iPhone5 5s
+ (BOOL)isIPhone5;

#pragma mark - is iPhone6
+ (BOOL)isIPhone6;

#pragma mark - is iPhone6Plus
+ (BOOL)isIPhone6Plus;

#pragma mark - 获取根试图
+ (UIView *)getRootView;

#pragma mark - 获取根控制器
+ (UIViewController *)getRootVC;

#pragma mark - 转换为金额格式
+ (NSString *)convertFloatToAmount:(double)d;

#pragma mark - 转换时间
+ (NSString *)stringFromInterval:(NSString *)str;

+ (NSString *)stringFromDate:(NSDate *)date;

+ (UIImage *)copyScreenWithTheView:(UIView *)view;

#pragma mark - 添加遮罩view
+ (UIView *)addMaskView:(UIView *)view;

#pragma mark - 移除遮罩view
+ (void)removeMaskView:(UIView *)view;

#pragma mark - 移除试图
+ (void)removeView:(id)viewClass;

#pragma mark - 移除除了自己和tabbar试图外的所有view
+ (void)removeAllView:(NSArray *)array;

#pragma mark - line
+ (void)AddLineWithFrame:(CGRect)rect SuperView:(UIView *)view;

+(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename;

#pragma mark -  是否为null
+(BOOL)isEmpty:(id)object;

+ (NSString *)md5:(NSString *)str;

#pragma mark -  获取ip
+ (NSString *)getIPAddress;

+ (id)getArrayOrDic:(NSString *)string;

#pragma mark - textField 验证是否输入 为数字 或者字母
+ (BOOL)textFieldCheck:(NSString *)string Type: (int)type ShowName:(NSString *)name;

#pragma mark - 消息提示
+ (void)showMsg:(NSString *)msg;

#pragma mark -
#pragma mark - ————————业务函数————————

/// 0:cnName or enName 1:value  2:label or selected or value or valueOther  3:value
+(id)getShipsubInfo:(NSArray *)params;

+(NSArray *)getShipsubInfos:(NSArray *)params;

///根据身份证计算年龄
+(NSString *)getAage:(NSString *)card;

///星期几
+(NSString *)getWeek:(int )index;

+ (void)showAlertTitle:(NSString*)title andMessage:(NSString *)message;

+(NSString *)stringNumfloat:(NSString *)number;

+(NSMutableAttributedString *) replaceColorText:(NSString *)text andText:(NSString *)text2 WitheColor:(UIColor *)color;


#pragma mark - 版本判断大小
+ (BOOL)versionCompareFirst:(NSString *)nowVerson andVersionSecond: (NSString *)oldVerson;

#pragma mark - 将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;


#pragma mark - 转换正式服和测试服

+(NSString *)getwebServer;

+(void)changewebServer:(BOOL)isProduct;

#pragma mark - 判断应用是否开启推送

+(BOOL)isUserNotificationEnable;

#pragma mark - 设置开启推送
+ (void)goToAppSystemNotificationSetting ;


@end
