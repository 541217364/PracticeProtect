/// 所有继承类集合


#import <UIKit/UIKit.h>
#pragma mark - TRButton
@interface TRButton : UIButton

@property (nonatomic,copy) NSString *param1;
#pragma mark  公有属性、函数
///自定义tag
@property (nonatomic) int tr_tag;

///自定义section
@property (nonatomic) int tr_section;

///计数
@property (nonatomic) int tr_count;

///是否能响应点击
@property (nonatomic) BOOL tr_touch;

@property (nonatomic,strong) NSTimer *timer;

///备用属性
@property (nonatomic,copy) NSString * tr_spare;

///备用属性
@property (nonatomic,copy) NSString * tr_sparea;

///备用属性
@property (nonatomic,copy) NSString * tr_spareb;

/// 是否加灰色边框
@property (nonatomic) BOOL tr_Border;

/// 倒计时
- (void)req;

/// 停止倒计时
- (void)reSet;

- (void)trAddBorder:(UIColor *)color;

#pragma mark  业务属性、函数

@property (nonatomic) int tr_epSex;
@property (nonatomic) int tr_epWedlock;
@end


#pragma mark - TRLabel
@interface TRLabel : UILabel

///自动换行 设置height
@property (nonatomic) BOOL tr_isNumberOfLines;

///自定义tag
@property (nonatomic)        int tr_tag;

///备用属性
@property (nonatomic,copy)   NSString * tr_spare;

///备用属性
@property (nonatomic,copy)   NSString * tr_sparea;

@property (nonatomic,strong) NSNumber * tr_number;

@property (nonatomic,strong) NSString * tr_text;

///显示不同颜色、大小的字体 如:@[@[[UIFont systemFontOfSize:13],[UIColor blackColor],@"测试"]]
- (void)trmSetTexts:(NSArray *)param;

///数字加减
- (void)trmIntTextChange:(int)Digital;


@end

#pragma mark - TRTextField
@interface TRTextField : UITextField
///自定义tag
@property (nonatomic) int tr_tag;

///备用属性
@property (nonatomic,copy) NSString* tr_spare;
@end

#pragma mark -  TRSwitch
@interface TRSwitch : UISwitch
///自定义tag
@property (nonatomic) int tr_tag;
@end

@interface TRTableViewCell:UITableViewCell

@end




