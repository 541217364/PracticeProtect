

#import "TRClassMethod.h"
#import "Reachability.h"
#import "CommonCrypto/CommonDigest.h"
#import "AppDelegate.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation TRClassMethod

+ (void)addSubView:(id)view{
    [[self getRootView] addSubview:view];
//    [TR_Singleton.allViews addObject:view];
    
//    NSLog(@"TR_Singleton.allViews add：%@",TR_Singleton.allViews);
}

+ (void)JumpView:(id)className{
    NSMutableArray *array = TR_Singleton.allViews;
    int j = (int) array.count;
    BOOL isRemove = NO;
    for (int i =0; i<j-1;i++) {
         id view =array[i];
        if (isRemove)[view removeFromSuperview];
        
        if ([view isKindOfClass:[className class]]) {
            isRemove = YES;
        }
    }

//    NSLog(@"TR_Singleton.allViews delete：%@",TR_Singleton.allViews);
}

+ (BOOL)getNetStatus
{
    return  (kNotReachable == [[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) ?  NO: YES;
    return YES;
}

+ (NSString *)getFilePath{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSLog(@"documentDirectory: %@",documentDirectory);
    return documentDirectory;
}

#pragma mark - is iPhone4 4s
+ (BOOL)isIPhone4{
    if (SCREEN_HEIGHT==480)
        return YES;
    else
        return NO;
}

#pragma mark - is iPhone5 5s
+ (BOOL)isIPhone5{
    if (SCREEN_HEIGHT==568)
        return YES;
    else
        return NO;
}

#pragma mark - is iPhone6
+ (BOOL)isIPhone6{
    if (SCREEN_HEIGHT==667)
        return YES;
    else
        return NO;
}

#pragma mark - is iPhone6Plus
+ (BOOL)isIPhone6Plus{
    if (SCREEN_HEIGHT==736)
        return YES;
    else
        return NO;
}

#pragma mark - 获取根试图
+ (UIView *)getRootView{
    UIViewController  *VC =  [self getRootVC];
    return VC.view;
}

#pragma mark - 获取根控制器
+ (UIViewController *)getRootVC{
    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    return window.rootViewController;
}

#pragma mark - 转换为金额格式
+ (NSString *)convertFloatToAmount:(double)d{
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterRoundDown;
    NSNumber *number = [NSNumber numberWithDouble:d];
    return  [formatter stringForObjectValue:number];
}

+ (NSString *)stringFromInterval:(NSString *)str
{
    if (!str || [str isEqualToString:@""])
        return @"";
    
    NSString *string =  [[[[str componentsSeparatedByString:@"("]objectAtIndex:1]componentsSeparatedByString:@")"]objectAtIndex:0];
    
    NSInteger time = [string doubleValue]/1000;
    NSDate * dateTime = [NSDate dateWithTimeIntervalSince1970:time];
    return [self stringFromDate:dateTime];
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600*8]];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];//@"yyyy-MM-dd HH:mm:ss"
    return  [formatter stringFromDate:date];
}

#pragma mark -  获取image
+ (UIImage *)copyScreenWithTheView:(UIView *)view{
    CGSize size = CGSizeMake(150, 30);
    UIGraphicsBeginImageContextWithOptions(size, view.opaque, 150/view.frame.size.width);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - 添加遮罩view
+ (UIView *)addMaskView:(UIView *)view{
    
    UIView * view1 = [[UIView alloc]initWithFrame:TR_Frame];
    view1.tag = 22222;
    if (view) {
        view1.backgroundColor = TR_COLOR_RGBACOLOR_A(102, 102, 102, 1.0);
        view1.alpha = 0.5;
    }else{
        view1.backgroundColor = [UIColor redColor];
        [ROOTVIEW addSubview:view1];
        return nil;
    }
    
    [view addSubview:view1];
    return view1;
}

#pragma mark - 移除遮罩view
+ (void)removeMaskView:(UIView *)view{
    
    for (id view1 in view.subviews) {
        if ([view1 isKindOfClass:[UIView class]]) {
            UIView *v = view1;
            if (v.tag == 22222)
                [v removeFromSuperview];
        }
    }
}

#pragma mark - 移除试图
+ (void)removeView:(id)viewClass{
    for (id view in ROOTVIEW.subviews) {
        if ([view isKindOfClass:viewClass]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - 移除除了当前试图和tabbar试图外的所有view
+ (void)removeAllView:(NSArray *)array{
    for (id view in ROOTVIEW.subviews) {
        if (![view isKindOfClass:[UIScrollView class]] && ![view isKindOfClass:[UIImageView class]]) {
            BOOL is = YES;
            for (id view1 in array) {
                if ([view isKindOfClass:view1])is = NO;
            }
            if (is)[view removeFromSuperview];
        }
    }
}

#pragma mark - 消息提示
+ (void)showMsg:(NSString *)msg{
    if (TR_isNotEmpty(msg))
       
        [[TKAlertCenter defaultCenter] postAlertWithMessage:msg];
    
}

+ (void)AddLineWithFrame:(CGRect)rect SuperView:(UIView *)view{
    UIView *lineView = [[UIView alloc]initWithFrame:rect];
    lineView.backgroundColor = TR_COLOR_RGBACOLOR_A(240, 240, 240, 1.0);
    [view addSubview: lineView];
}

#pragma mark -  view 转换pdf
+(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    
    [aView.layer renderInContext:pdfContext];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its· context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
}

+ (void)unregisterForRemoteNotifications
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

+(BOOL)isEmpty:(id)object{
    if ([object isKindOfClass:[NSNull class]] || !object)
        return YES;
    
    else if([object isKindOfClass:[NSArray class]]){
        NSArray *array = object;
        if (array.count)return NO;
        else return YES;
    }
    
    else if( [object isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = object;
        if (dic.count)return NO;
        else return YES;
    }
    
    else if([object isKindOfClass:[NSString class]]){
        NSString *string  = object;
        if (!string.length || [@"" isEqualToString:string])
            return YES;
        else return NO;
    }
    
    return NO;
}

+(NSString *)nonceStr{
    NSString * string = @"qwertyuioplkjhgfdsazxcvbnm1234567890";
    NSMutableString *mstring = [NSMutableString new];
    for (int i = 0; i<32; i++) {
        int y = arc4random() % 36;
        NSRange rang;
        rang.length = 1;
        rang.location =y;
        [mstring appendFormat:@"%@",[string substringWithRange:rang]];
    }
    //    int NUMBER_OF_CHARS = 32;
    //
    //    char data[NUMBER_OF_CHARS];
    //    for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('a' + (arc4random_uniform(26))));
    
    //    return [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return mstring;
}

+ (id)getArrayOrDic:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

+ (BOOL)textFieldCheck:(NSString *)string Type: (int)type ShowName:(NSString *)name{
    NSCharacterSet *cs ;
    NSString * message ;
    if (type==0){
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        message = [NSString stringWithFormat:@"%@%@",name,@"请输入数字" ];
    }else if(type==1){
        cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersAndLetter] invertedSet];
        message = [NSString stringWithFormat:@"%@%@",name,@"请输入数字或字母" ];
    }else if(type==2){
        cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersAndFH] invertedSet];
        message = [NSString stringWithFormat:@"%@%@",name,@"请输入数字" ];
    }else if (type==3){
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:NMUBERS] invertedSet];
        message = [NSString stringWithFormat:@"%@%@",name,@"不能输入符号！" ];
    }
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:message
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    return YES;
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        return 1;
    }
    else if (result == NSOrderedAscending){
        return -1;
    }
    return 0;
    
}

+(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}


#pragma mark -
#pragma mark - ————————业务函数————————

+(id)getShipsubInfo:(NSArray *)params{
    NSArray *array = [self getShipsubInfos:params];
    if (TR_isNotEmpty(array)) {
        NSPredicate *filterPredicate = nil;
        if ([params[3] isKindOfClass:[NSNumber class]] || [params[3] isKindOfClass:[NSString class]])
            filterPredicate = [NSPredicate predicateWithFormat:@"SELF.%@ = %d",params[2],[params[3] intValue]];
        else
            filterPredicate = [NSPredicate predicateWithFormat:@"SELF.%@ = %@",params[2],params[3]];
        NSArray *array2  =  [array filteredArrayUsingPredicate:filterPredicate];
        
        if (TR_isNotEmpty(array2))
            return [array2 firstObject];
    }
    return nil;
}

+(NSArray *)getShipsubInfos:(NSArray *)params{
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF.%@ = %@",params[0],params[1]];
    NSArray *array  =  [[Singleton shareInstance].ships filteredArrayUsingPredicate:filterPredicate];
    if (TR_isNotEmpty(array)) {
//        ShipInfo *info = [array firstObject];
//        return info.labelValues;
    }
    return @[];
}

///根据身份证计算年龄
+(NSString *)getAage:(NSString *)card{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy"];
    int year = [[formatter stringFromDate:[NSDate date]]intValue];
    return [NSString stringWithFormat:@"%d",year -[[card substringWithRange:NSMakeRange(6,4)] intValue]];
}

///星期几
+(NSString *)getWeek:(int)index{
    switch (index) {
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        case 7:
            return @"星期七";
            break;
            
        default:
            break;
    }
    return nil;
}



+(void)showAlertTitle:(NSString*)title andMessage:(NSString *)message {
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    [alertController addAction:cancelAction];
    
    [ROOTVC  presentViewController:alertController animated:YES completion:nil];
}



+(NSMutableAttributedString *) replaceColorText:(NSString *)text andText:(NSString *)text2 WitheColor:(UIColor *)color{

    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:color,
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:13]
                              };
    
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text2
                                           attributes:attribs];
    
     NSRange bgTextRange =[text2 rangeOfString:text];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(254,60,0,1),NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:bgTextRange];

    return attributedText;
}

+(NSString *)stringNumfloat:(NSString *)number {
    
    NSInteger num=[number integerValue];
    
    double d_num=[number doubleValue]-num;
    
    NSString *mystr=@"";
    
    if (d_num==0) {
        
        mystr=[NSString stringWithFormat:@"%ld",(long)num];
        
    }else{
        
        mystr=[NSString stringWithFormat:@"%.2f",[number doubleValue]];
        
        NSString *mynumstr=[mystr substringWithRange:NSMakeRange(mystr.length-1,1)];
        
        if ([mynumstr doubleValue]==0) {
            
            mystr=[NSString stringWithFormat:@"%.1f",[number doubleValue]];

        }
        
    }
    
    return mystr;
}


// 方法调用
+ (BOOL)versionCompareFirst:(NSString *)nowVerson andVersionSecond: (NSString *)oldVerson
{
    NSArray *versions1 = [nowVerson componentsSeparatedByString:@"."];
    NSArray *versions2 = [oldVerson componentsSeparatedByString:@"."];
    NSMutableArray *ver1Array = [NSMutableArray arrayWithArray:versions1];
    NSMutableArray *ver2Array = [NSMutableArray arrayWithArray:versions2];
    // 确定最大数组
    NSInteger a = (ver1Array.count> ver2Array.count)?ver1Array.count : ver2Array.count;
    // 补成相同位数数组
    if (ver1Array.count < a) {
        for(NSInteger j = ver1Array.count; j < a; j++)
        {
            [ver1Array addObject:@"0"];
        }
    }
    else
    {
        for(NSInteger j = ver2Array.count; j < a; j++)
        {
            [ver2Array addObject:@"0"];
        }
    }
    // 比较版本号
    int result = [self compareArray1:ver1Array andArray2:ver2Array];
    if(result == 1)
    {
        return NO;
    }
    else if (result == -1)
    {
        return YES;
    }
    else if (result ==0 )
    {
        return NO;
    }
    
    return NO;
}

// 比较版本号
+ (int)compareArray1:(NSMutableArray *)array1 andArray2:(NSMutableArray *)array2
{
    for (int i = 0; i< array2.count; i++) {
        NSInteger a = [[array1 objectAtIndex:i] integerValue];
        NSInteger b = [[array2 objectAtIndex:i] integerValue];
        if (a > b) {
            return 1;
        }
        else if (a < b)
        {
            return -1;
        }
    }
    return 0;
}



#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    return timeSp;
    
}


+(NSString *)getwebServer{
    
    NSString *webUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"webServer"];
    
    if ([TRClassMethod isEmpty:webUrl]) {
        
        webUrl = @"https://www.dianbeiwaimai.cn/appapi.php";
    }
    
    
    return webUrl;
    
}

+(void)changewebServer:(BOOL)isProduct{
    
    if (isProduct) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"https://www.dianbeiwaimai.cn/appapi.php" forKey:@"webServer"];
    }else{
        
       [[NSUserDefaults standardUserDefaults] setObject:@"http://118.31.11.208/appapi.php" forKey:@"webServer"];
        
    }
    
}


#pragma mark - 判断应用是否开启推送
+ (BOOL)isUserNotificationEnable { // 判断用户是否允许接收通知
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemNotificationSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [application openURL:url];
        }
    }
}



@end
