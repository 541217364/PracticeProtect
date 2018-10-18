/// 所有继承类集合

#import "TRExtendsClass.h"

@implementation TRButton
@synthesize tr_epSex = _tr_epSex;
@synthesize tr_epWedlock = _tr_epWedlock;
#pragma mark - 公有属性、函数
- (void)req{
    _tr_count = 60;
    self.tr_touch = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTitle) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)reSet{
    self.tr_touch = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_timer invalidate];
    _timer = nil;
}

- (void)changeTitle{
    if (_tr_count>0) {
        _tr_count -=1;
        [self setTitle:[NSString stringWithFormat:@"%dS",_tr_count] forState:UIControlStateNormal];
    }else{
        self.tr_touch = YES;
        [self setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)trAddBorder:(UIColor *)color{
    [self.layer setBorderColor: [color CGColor]];
    [self.layer setBorderWidth: 1.0];
}

- (void)setTr_Border:(BOOL)tr_Border{
    if (tr_Border) {
        self.layer.cornerRadius = 5;
        [self.layer setBorderColor: [TR_COLOR_RGBACOLOR_A(220, 220, 220, 1.0) CGColor]];
        [self.layer setBorderWidth: 1.0];
    }
}



#pragma mark - 私有属性、函数
-(void)setTr_epSex:(int)tr_epSex{
    if (tr_epSex)
        [self setTitle:@"女" forState:UIControlStateNormal];
    else
        [self setTitle:@"男" forState:UIControlStateNormal];
    
    _tr_epSex = tr_epSex;
}

- (int)tr_epSex{
    return _tr_epSex;
}

- (void)setTr_epWedlock:(int)tr_epWedlock{
    if (tr_epWedlock)
        [self setTitle:@"已婚" forState:UIControlStateNormal];
    else
        [self setTitle:@"未婚" forState:UIControlStateNormal];
    
    _tr_epWedlock = tr_epWedlock;
}

-(int)tr_epWedlock{
    return _tr_epWedlock;
}
@end

@interface TRLabel()
@end
@implementation TRLabel

- (void)setTr_isNumberOfLines:(BOOL)tr_isNumberOfLines{
    if (tr_isNumberOfLines) {
        self.numberOfLines = 0;
        CGSize size = TR_TEXT_SIZE(self.text, self.font, CGSizeMake(self.frame.size.width, 1000), nil);
        [self setHeight:size.height];
    }
}

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

- (void)trmSetTexts:(NSArray *)param{
    NSMutableString *string = [NSMutableString new];
    for (NSArray *array in param) {
        if (TR_isNotEmpty(array[2])) {
            [string appendFormat:@"%@",array[2]];
        }
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    int length = 0;
    for(int i=0;i<param.count;i++){
        NSArray *array = param[i];
        NSString *string = array[2];
        if (TR_isNotEmpty(string)) {
            int strLength = (int)string.length;
            if ([array[0] isKindOfClass:[UIFont class]]) {
                [attributedString addAttribute:NSFontAttributeName value:array[0] range:NSMakeRange(length,strLength)];
            }else if([array[0] isKindOfClass:[NSNumber class]]){
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[array[0] floatValue]] range:NSMakeRange(length,strLength)];
            }
            
            [attributedString addAttribute:NSForegroundColorAttributeName value:array[1] range:NSMakeRange(length,strLength)];
            length += strLength;
        }
    }
    self.attributedText = attributedString;
}

- (void)trmIntTextChange:(int)Digital{
    int old = [self.text intValue];
    self.text = [NSString stringWithFormat:@"%d",old+Digital];
}


@end

@implementation TRTextField

@end

@implementation TRSwitch
@end

@implementation TRTableViewCell

@end
