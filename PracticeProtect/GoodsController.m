//
//  GoodsController.m
//  PracticeProtect
//
//  Created by 弦断有谁听 on 2019/1/4.
//  Copyright © 2019 DianBeiWaiMai. All rights reserved.
//

#import "GoodsController.h"
#import "TouchScrollViewExtent.h"
#import "FreshTableView.h"
#import "MLLinkLabel.h"
#import "MLEmojiLabel.h"
@interface GoodsController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate,MLLinkLabelDelegate,MLEmojiLabelDelegate>

@property(nonatomic,strong)FreshTableView *mytableview;

@property(nonatomic,strong)TouchScrollViewExtent *myscrollview;

@property(nonatomic,strong)UIView *topview;

@property(nonatomic,strong)UIView *bottomview;

@end

@implementation GoodsController

-(UITableView *)mytableview{
    if (_mytableview == nil) {
        _mytableview = [[FreshTableView alloc]init];
        _mytableview.delegate = self;
        _mytableview.dataSource = self;
        _mytableview.openHeader = YES;
        WeakSelf;
        _mytableview.refreshheader = ^(NSInteger index) {
            [UIView animateWithDuration:0.3 animations:^{
                weakself.myscrollview.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                weakself.myscrollview.scrollEnabled = YES;
            }];
            [weakself.mytableview.mj_header endRefreshing];
        };
        _mytableview.frame = CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT -10);
        _mytableview.estimatedRowHeight = 40;
        _mytableview.backgroundColor = [UIColor whiteColor];
    }
    return _mytableview;
}

-(UIScrollView *)myscrollview{
    if (_myscrollview == nil) {
        _myscrollview = [[TouchScrollViewExtent alloc]init];
        _myscrollview.delegate = self;
        _myscrollview.contentSize = CGSizeMake(0, 5000);
        _myscrollview.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT -20);
    }
    return _myscrollview;
}

-(UIView *)topview{
    if (_topview == nil) {
        _topview = [[UIView alloc]init];
        _topview.backgroundColor = [UIColor redColor];
        _topview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }
    return _topview;
}

-(UIView *)bottomview{
    if (_bottomview == nil) {
        _bottomview = [[UIView alloc]init];
        _bottomview.backgroundColor = [UIColor whiteColor];
        _bottomview.frame = CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _bottomview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}

-(void)setUI{
    
    [self.view addSubview:self.myscrollview];
//    [self.myscrollview addSubview:self.topview];
//    [self.myscrollview addSubview:self.bottomview];
//    [self.bottomview addSubview:self.mytableview];
    
    
    
  
//
//    [self.topview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(200);
//    }];
//
//    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(200);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(SCREEN_HEIGHT);
//    }];
    
//    UILabel *lastLabel = nil;
//    for (NSUInteger i = 0; i < 10; ++i) {
//        UILabel *label = [[UILabel alloc] init];
//        label.numberOfLines = 0;
//        label.layer.borderColor = [UIColor greenColor].CGColor;
//        label.layer.borderWidth = 2.0;
//        label.text = [self randomText];
//        label.userInteractionEnabled = YES;
//
//        // We must preferredMaxLayoutWidth property for adapting to iOS6.0
//        label.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
//        label.textAlignment = NSTextAlignmentLeft;
//        label.textColor = [self randomColor];
//        [self.myscrollview addSubview:label];
//
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(15);
//            make.right.mas_equalTo(self.view).offset(-15);
//            
//            if (lastLabel) {
//                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
//            } else {
//                make.top.mas_equalTo(self.myscrollview).offset(20);
//            }
//
//           // make.height.mas_equalTo(40);
//        }];
//
//        lastLabel = label;
//
//
//    }
//
//    [self.myscrollview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//
//        // 让scrollview的contentSize随着内容的增多而变化
//        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
//    }];
    
//    NSArray *imageNames = @[@"h1.jpg",
//                            @"h2.jpg",
//                            @"h3.jpg",
//                            @"h4.jpg",
//                            @"h7" // 本地图片请填写全名
//                            ];
//
//    NSArray *titles = @[@"新建交流QQ群：185534916 ",
//                        @"disableScrollGesture可以设置禁止拖动",
//                        @"感谢您的支持，如果下载的",
//                        @"如果代码在使用过程中出现问题",
//                        @"您可以发邮件到gsdios@126.com"
//                        ];
//
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64,self.view.bounds.size.width, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
//    cycleScrollView.delegate = self;
//    cycleScrollView.titlesGroup = titles;
//    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
//    [self.view addSubview:cycleScrollView];
//    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//
//    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 40) delegate:self placeholderImage:nil];
//    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
//    cycleScrollView4.onlyDisplayText = YES;
//
//    NSMutableArray *titlesArray = [NSMutableArray new];
//    [titlesArray addObject:@"纯文字上下滚动轮播"];
//    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
//    [titlesArray addObjectsFromArray:titles];
//    cycleScrollView4.titlesGroup = [titlesArray copy];
//    [cycleScrollView4 disableScrollGesture];
//
//    [self.view addSubview:cycleScrollView4];
//
//
//     MLLinkLabel *label = [MLLinkLabel new];
//
//    label.attributedText = [self generateAttributedStringWithCommentItemModel2];
//
//    label.frame = CGRectMake(20, 400, SCREEN_WIDTH - 40, 20);
//
//    label.delegate = self;
//
//    [self.view addSubview:label];
    
    
    NSDictionary *tempDic = [self emojiDictionary];
    
    NSArray *Root = [tempDic allKeys];
    
    for (int i = 0; i < Root.count; i++) {
        
        MLEmojiLabel *label = [MLEmojiLabel new];
        label.text = Root[i];
        label.frame = CGRectMake(20, i * 40 + 20, SCREEN_WIDTH - 40, 20);
        [self.myscrollview addSubview:label];
        
    }
    
    
    
//    MLEmojiLabel *label2 = [MLEmojiLabel new];
//
//    label2.text = @"/::~";
//
//    label2.frame = CGRectMake(20, 500, SCREEN_WIDTH - 40, 20);
//
//    label2.delegate = self;
//
//    [self.view addSubview:label2];
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel2
{
    NSString *text = @"zl";
    if (1) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", @"xx"]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", @"@弦断有谁听"]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : @"541217364"} range:[text rangeOfString:@"zl"]];
    if (1) {
        [attString setAttributes:@{NSLinkAttributeName :@"484904910"} range:[text rangeOfString:@"xx"]];
    }
    
     [attString setAttributes:@{NSLinkAttributeName :@"484904910"} range:[text rangeOfString:@"弦断有谁听"]];
    
    return attString;
}



#pragma mark - 表情包字典
- (NSDictionary *)emojiDictionary {
    static NSDictionary *emojiDictionary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MLEmoji_ExpressionImage.plist"];
        emojiDictionary = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
    });
    return emojiDictionary;
}


#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
    
    if ([link.linkValue containsString:@"https"]) {
        
        CustomWebController *tempVC = [[CustomWebController alloc]init];
        tempVC.urlString = link.linkValue;
        
        [self presentViewController:tempVC animated:YES completion:nil];
    }
}


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (NSString *)randomText {
    CGFloat length = arc4random() % 150 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@"测试数据很长，"];
    }
    
    return str;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个",indexPath.row];
    
    return cell;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == _myscrollview) {
//        
//        NSLog(@"-------%f",_myscrollview.contentOffset.y);
//        
//        if (scrollView.contentOffset.y < 200) {
//            
//            [_mytableview setContentOffset:CGPointZero];
//        }
//        if (scrollView.contentOffset.y >= 200) {
//            
//            _myscrollview.scrollEnabled = NO;
//        }
//    }
    
}

@end
