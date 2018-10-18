/// 所有扩展类集合

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UILabel(Private)

- (void)setTr_text:(NSString *)text;

- (NSString *)tr_text;
@end

@interface UITextField(Private)

@property (nonatomic,copy)NSString *trp_tag;

@property (nonatomic,strong)NSString *trp_text;
@end

@interface UIView(frame)
- (void)setX:(CGFloat)x;

- (CGFloat)x;

- (void)setY:(CGFloat)y;

- (CGFloat)y;

- (void)setOrigin:(CGPoint)origin;

- (CGPoint)origin;

- (void)setWidth:(CGFloat)width;

- (CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (CGFloat)height;

- (void)setSize:(CGSize)size;

- (CGSize)size;

-(CGFloat)maxHeight;

- (void)trmSetBorderWithColor:(UIColor *)color;

@end

typedef NS_ENUM(NSInteger,Regular){
    ChineseAndDigitalAndLetter = 0, // 中文、数字、字母
    Chinese,
    Digital,
    Letter,
    IDCard,
    Iphone
};
@interface NSString(Private)
/// 返回子字符串  location:开始位置   length:子字符串长度
- (NSString *)trmSubstringWithRange:(int)location Length:(int)length;

///判断是否有中文
-(BOOL)trmIsChinese;

///转中文
- (NSString *)trmGetUTF8HZ;

///转编码
- (NSString *)trmGetUTF8BM;

///按正则检测是否合格
- (BOOL)trmCheck:(Regular)regular;



@end

@interface NSDate(Private)
///日期转字符串
+ (NSString * )trmDateToString: (NSDate * )date;

///字符串转日期
+ (NSDate *)trmDataFromString:(NSString *)string;

/// 从今天开始往后一段日期数组格式(yyyy-mm-dd)
+ (NSArray *)trmGetDaysFormNow:(int)days;

@end

@interface UIImage (Rotate)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end
