//  所有宏定义
#define NUMBERS @"0123456789\n"
#define NumbersAndLetter @"0123456789abcdefghijklmnopqrstuvwxyz\n"
#define NumbersAndFH @"0123456789abcde$￥"
#define NMUBERS @"0123456789./*-+~!@#$%^&()_-=,/;'[]{}:<>?？`．－。“”~！：，；￥、（）【】·ε ★☆★$ & ¤ § | °゜ ¨ ± · × ÷ ˇ ˉ ˊ ˋ ˙ "

#pragma mark - TRClassMethod
/// 是否为空
#define TR_isNotEmpty(param)             ![TRClassMethod isEmpty:param]
#define TR_GetSign(param,param1)          [TRClassMethod PaySign:param Type:param1]
#define TR_GetNonceStr                    [TRClassMethod nonceStr]
#define TR_MACRO_TOAMOUNT(param)          [TRClassMethod convertFloatToAmount:param] // 转换金额格式

/// 网络状态
#define TR_IsNetWork                      [TRClassMethod getNetStatus]

#define iPhone4                           [TRClassMethod isIPhone4]
#define iPhone5                           [TRClassMethod isIPhone5]
#define iPhone6                           [TRClassMethod isIPhone6]
#define iPhone6Plus                       [TRClassMethod isIPhone6Plus]

#pragma mark - 设备&&系统
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define TR_DS_AddSubView(param) [[UIApplication sharedApplication].keyWindow addSubview:param];
#define TR_Frame         CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
// app 版本号
#define TR_AppVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define TR_Device_model [UIDevice currentDevice].model

#pragma mark - 颜色
#define TR_COLOR_RGBACOLOR_A(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#pragma mark - 图片
#define TR_IMAGE_NAME(A) [UIImage imageNamed:A]
#define TR_Image_Stret(image) [(image) stretchableImageWithLeftCapWidth:(image).size.width/2 topCapHeight:(image).size.height/2]
#define TR_IMAGE_PATH(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#pragma mark - 文字 TR
#define TR_TEXT_SIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
        attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

#define TR_Font_Cu(param) [UIFont fontWithName:@"Helvetica-Bold" size:param]

#define TR_Font_Gray(param) [UIFont fontWithName:@"PingFang-SC-Regular" size:param]


#define TR_Font_Mdeium(param) [UIFont fontWithName:@"PingFang-SC-Medium" size:param]


#import <Foundation/Foundation.h>

@interface TRMacro : NSObject

@end
