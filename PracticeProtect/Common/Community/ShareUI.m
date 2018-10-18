//
//  ShareUI.m
//
//
//  Created by DuQ on 14-8-20.
//  Copyright (c) 2014年 CSOT. All rights reserved.
//

#import "ShareUI.h"

#define RECT_Y 60

#pragma mark - SuperView
@implementation SuperView : UIView
- (id)initWithFrame:(CGRect)frame{
    return [super initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame ShowType:(SHOW_TYPE)showType{
    return [super initWithFrame:frame];
}

-(id)initWithFrame:(CGRect)frame withData:(NSArray * )data{
    return [super initWithFrame:frame];
}

- (void)loadAndRefreshData{}
@end


#pragma mark - SuperVC
@implementation SuperVC : UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)loadAndRefreshData{}
@end


#pragma mark - ShareView
@interface ShareView ()

@property (nonatomic) SHOW_TYPE showType;

@property (nonatomic,strong)UILabel *titleLabel;
@end
@implementation ShareView

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame]))
    {
        
        
        self.backgroundColor = [UIColor whiteColor];//TR_COLOR_RGBACOLOR_A(222, 222, 222, 1.0);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        _topBackView=view;
        
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, NARBAR_Y, SCREEN_WIDTH, 40)];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.backgroundColor = [UIColor whiteColor];
        //  _topImageView.image =TR_Image_Stret([UIImage imageNamed:@"ezt_nav"]) ;
        
        [self addSubview:_topImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 10, 200, 20)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
       // _titleLabel.textColor = [UIColor cel];
        [self.topImageView addSubview:_titleLabel];
        
        self.superY = CGRectGetMaxY(_topImageView.frame);
        _page = [NSNumber numberWithInt:1];
        _rowsPerPage = [NSNumber numberWithInt:20];
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame ShowType:(SHOW_TYPE)showType{
    if ((self = [self initWithFrame:frame]))
	{
        _showType = showType;
        
        //self.maskView = [[UIView alloc]initWithFrame:frame];
        //self.maskView.backgroundColor = [UIColor clearColor];
        //[ROOTVIEW addSubview:self.maskView];
        [self show];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame withData:(NSArray * )data{
    if (data) {
        if (data.count>1) {
            id obj1 = data[0];
            id obj2 = data[1];
            if ([obj1 isKindOfClass:[NSNumber class]] && [obj2 isKindOfClass:[NSNumber class]]) {
                self = [self initWithFrame:frame ShowType:[data[0] intValue]];
                self.superType = [data[1] intValue];
                if (data.count>2) {
                    if (TR_isNotEmpty(data[2])) {
                        self.superData = data[2];
                    }
                }
            }else{
                self = [self initWithFrame:frame ShowType:LEFT];
                self.superData = data;
            }
        }else{
            self = [self initWithFrame:frame ShowType:LEFT];
            self.superData = data;
        }
        
    }else{
        self = [self initWithFrame:frame ShowType:LEFT];
    }
    
    
    return self;
}

- (void)setIsBackBtn:(BOOL)isBackBtn{
    if (isBackBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0,44, 40)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"root_backArrow"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_topImageView addSubview:btn];
    }
}

- (void)setTitleName:(NSString *)Title{
    _titleName = Title;
    _titleLabel.text = Title;
}

- (void)setIsSP:(BOOL)isSP{
    if (isSP) {
        if (iPhone5) {
            _m_height = 497;
        }else if(iPhone6){
            _m_height = 600;
        }else if(iPhone4){
            _m_height = 420;
        }else if(iPhone6Plus){
            _m_height = 670;
        }
        self.frame =CGRectMake(0, 0, SCREEN_WIDTH, _m_height);
        _m_height -=60;
    }
}


- (void)show{
    if (_showType == UP) {
        self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*1.5);
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT)/2);
        }completion:^(BOOL finished){
            [self.maskView removeFromSuperview];
            self.maskView = nil;
            
        }];
    }else if(_showType == LEFT){
        self.center = CGPointMake(SCREEN_WIDTH*1.5, SCREEN_HEIGHT/2);
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT)/2);
        }completion:^(BOOL finished){
            [self.maskView removeFromSuperview];
            self.maskView = nil;
            
        }];
    }else if(_showType == BOTTOM){
        self.center = CGPointMake(SCREEN_WIDTH/2, -SCREEN_HEIGHT/2);
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT)/2);
        }completion:^(BOOL finished){
            [self.maskView removeFromSuperview];
            self.maskView = nil;
            
        }];
    }else if(_showType == RIGHT){
        self.center = CGPointMake(-SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT)/2);
        }completion:^(BOOL finished){
            [self.maskView removeFromSuperview];
            self.maskView = nil;
            
        }];
    }
   
}

- (void)back{
    //[HBHttpTool CancelAllRequest];
    if (_showType == UP) {
        CGPoint point = self.center;
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(point.x, point.y+self.frame.size.height);
            [self removeFromSuperview];
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if(_showType == LEFT){
        CGPoint point = self.center;
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(point.x+self.frame.size.width, point.y);
            [self removeFromSuperview];
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if(_showType == BOTTOM){
        CGPoint point = self.center;
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(point.x, point.y-self.frame.size.height);
            [self removeFromSuperview];
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if(_showType == RIGHT){
        CGPoint point = self.center;
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            self.center = CGPointMake(point.x-self.frame.size.width, point.y);
            [self removeFromSuperview];
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
}

- (void)dealloc{
}

@end



#pragma mark - ShareVC
@interface ShareVC ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UILabel *titleLabel;
@end
@implementation ShareVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor]; //TR_COLOR_RGBACOLOR_A(222,92,59,1);
    [self.view addSubview:view];
    
     _topBackView=view;
    
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, 44)];
    _topImageView.userInteractionEnabled = YES;
  
    _topImageView.backgroundColor=[UIColor whiteColor];   //TR_COLOR_RGBACOLOR_A(222,92,59,1);
  //_topImageView.image = [UIImage imageNamed:@"ezt_nav"];
    [self.view addSubview:_topImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 5, 200, 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor =[UIColor clearColor]; //TR_COLOR_RGBACOLOR_A(254,60,0,1);
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _titleLabel.textColor=[UIColor blackColor];
    [self.topImageView addSubview:_titleLabel];
    
    _mtitlelabel=_titleLabel;
    
     self.superY = CGRectGetMaxY(_topImageView.frame);
   
    _page = [NSNumber numberWithInt:1];
    _rowsPerPage = [NSNumber numberWithInt:20];
    
   // id target = self.navigationController.interactivePopGestureRecognizer.delegate;
   // UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];

  //  panGesture.delegate = self; // 设置手势代理，拦截手势触发

   // [self.view addGestureRecognizer:panGesture];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    


}


-(void)handleNavigationTransition:(UIPanGestureRecognizer *)sender{
    
   // [self back];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

{

    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势

    if(self.navigationController.childViewControllers.count == 1)

    {

        return NO;

    }

    return YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)setTitleName:(NSString *)Title{
    _titleName = Title;
    _titleLabel.text = Title;
}

- (void)setIsBackBtn:(BOOL)isBackBtn{
    if (isBackBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0,3,44,30)];
        btn.backgroundColor = [UIColor clearColor];
      //  [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"root_backArrow"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_topImageView addSubview:btn];
        _backbtn=btn;
    }
}

- (void)setIsSP:(BOOL)isSP{
    if (isSP) {
        if (iPhone5) {
            _m_height = 500;
        }else if(iPhone6){
            _m_height = 575;
        }else if(iPhone4){
            _m_height = 420;
        }else if(iPhone6Plus){
            _m_height = 670;
        }
        self.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, _m_height);
        _m_height -=60;
    }
}

- (void)back{
    [HBHttpTool CancelAllRequest];
    
}


@end
