/// 所有扩展类集合
static void * MyKey = (void *)@"MyKey";
#import "TRCategoryClass.h"


@implementation UILabel(Private)
- (void)setTr_text:(NSString *)text{
    if (TR_isNotEmpty(text)) {
        self.text = text;
    }
}

- (NSString *)tr_text{
    if (self.text)
        return self.text;
    return @"";
}

@end

@implementation UITextField(Private)

- (void)setTrp_tag:(NSString *)Trp_tag{
    objc_setAssociatedObject(self,MyKey, Trp_tag, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)trp_tag{
    return objc_getAssociatedObject(self, MyKey);
}

- (void)setTrp_text:(NSString *)tr_text{
    if (TR_isNotEmpty(tr_text))
        self.text = tr_text;
    else
        self.text = @"";
    
}

-(NSString *)trp_text{
    return self.text;
}
@end

@implementation UIView(frame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y

{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    
    return self.frame.size.width;
    
}

- (void)setHeight:(CGFloat)height
{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
    
}
- (CGSize)size
{
    
    return self.frame.size;
}

-(CGFloat)maxHeight{
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)trmSetBorderWithColor:(UIColor *)color{
    self.layer.cornerRadius = 5;
    [self.layer setBorderColor: [color CGColor]];
    [self.layer setBorderWidth: 1.0];
}
@end

@implementation NSString(Private)
- (NSString *)trmSubstringWithRange:(int)location Length:(int)length{
    NSRange range;
    range.location = location;
    range.length = length;
    return [self substringWithRange:range];
}

-(BOOL)trmIsChinese {
    for(int i=0; i< [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}

- (NSString *)trmGetUTF8HZ{
    return  [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trmGetUTF8BM{
   return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (BOOL)trmCheck:(Regular)regular{
    switch (regular) {
        case ChineseAndDigitalAndLetter:
        {
            NSString *regex = @"[a-zA-Z\u4e00-\u9fa5]";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if(![pred evaluateWithObject: self])
                return NO;
        }
            break;
        case Chinese:
        {
            NSString *regex = @"[u4e00-\u9fa5]";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if(![pred evaluateWithObject: self])
                return NO;
        }
            break;
        case Digital:
        {
            NSString *regex = @"[0-9]";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if(![pred evaluateWithObject: self])
                return NO;
        }
            break;
        case Letter:
        {
            NSString *regex = @"[a-zA-Z]";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if(![pred evaluateWithObject: self])
                return NO;
        }
            break;
        case IDCard:
        {
            NSString *regex =@"^(//d{14}|//d{17})(//d|[xX])$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if(![pred evaluateWithObject: self])
                return NO;
        }
            break;
        case Iphone:
        {
            NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,2,5-9]))\\d{8}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            if(![pred evaluateWithObject: self])
                return NO;
        }
            break;
            
        default:
            break;
    }
    return YES;
}
@end





#define TR_DATE_TIME_FORMAT1 (@"yyyy-MM-dd HH:mm:ss")
#define TR_DATE_TIME_FORMAT2 (@"yyyy-MM-dd")
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
@implementation NSDate(Private)
///日期转字符串
+ (NSString * )trmDateToString: (NSDate * )date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: TR_DATE_TIME_FORMAT2];
    return [formatter stringFromDate:date];
}

///字符串转日期
+ (NSDate *)trmDataFromString:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:TR_DATE_TIME_FORMAT1];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

/// 从今天开始往后一段日期数组格式(yyyy-mm-dd)
+ (NSArray *)trmGetDaysFormNow:(int)days{
    
    NSMutableArray *array = [NSMutableArray new];
    for (int j =0; j<days; j++) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:[NSDate date]];
        components.day+=j;
        NSDate * newDate=[CURRENT_CALENDAR dateFromComponents:components];
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: TR_DATE_TIME_FORMAT2];
        [array addObject: [formatter stringFromDate:newDate]];
    }
    return array;
}

@end

@implementation UIImage (Rotate)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
