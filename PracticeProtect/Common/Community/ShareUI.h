//
//  ShareUI.h
//
//
//  Created by DuQ on 14-8-20.
//  Copyright (c) 2014年 CSOT. All rights reserved.
//

/**
 * 通用block
 *
 * @param success    需要判断参数
 * @param dictionary 字典
 * @param array      数组
 */
typedef void(^TRBlock)(__unused BOOL success,__unused NSDictionary * dictionary,__unused NSArray * array);

typedef NS_ENUM(NSInteger,SHOW_TYPE){
    UP   = 0,
    LEFT,
    BOTTOM,
    RIGHT
};

#import <UIKit/UIKit.h>

@interface SuperView : UIView
@property (nonatomic) int  superY;
///类型(为了重用)
@property (nonatomic) int  superType;
///父类传入子类的数据
@property (nonatomic, strong) NSArray * superData;

@property (nonatomic, copy) void (^callback) (NSArray * array);

@property (nonatomic, copy) TRBlock trBlock;

@property (nonatomic, strong)NSArray               * dataArray;

@property (nonatomic, strong)NSMutableArray        * m_dataArray;

@property (nonatomic, strong)NSDictionary          * dataDic;

@property (nonatomic, strong) UIView               * mainView;

///遮罩view 为了防止用户以极快速度点击 弹出多个视图
@property (nonatomic, strong) UIView               * maskView;

-(id)initWithFrame:(CGRect)frame withData:(NSArray * )data;

- (id)initWithFrame:(CGRect)frame ShowType:(SHOW_TYPE)showType;

///加载和刷新数据
- (void)loadAndRefreshData;
@end

@interface SuperVC : UIViewController
@property (nonatomic) int  superY;

@property (nonatomic) int superType;

///父类传入子类的数据
@property (nonatomic, strong) NSArray * superData;

@property (nonatomic) SHOW_TYPE showType;

@property (nonatomic, copy) void (^callback) (NSArray * array);

@property (nonatomic, copy) TRBlock trBlock;

@property (nonatomic, strong)NSArray              * dataArray;

@property (nonatomic, strong)NSMutableArray       * m_dataArray;

@property (nonatomic, strong)NSDictionary         * dataDic;

@property (nonatomic, strong) UIView              * mainView;

///遮罩view 为了防止用户以极快速度点击 弹出多个视图
@property (nonatomic, strong) UIView               * maskView;

///加载和刷新数据
- (void)loadAndRefreshData;

- (void)show;
- (void)back;
@end


/************/


@interface ShareView : SuperView

@property (nonatomic, strong) UIView * topBackView;


@property (nonatomic, strong) UIImageView  * topImageView;

@property (nonatomic, strong) NSString     * titleName;

@property (nonatomic) BOOL  isBackBtn;

@property (nonatomic) BOOL  isSP;


@property (nonatomic) float  m_height;

// 起始页 默认1
@property (nonatomic,strong) NSNumber * page;

// 起始行 默认10
@property (nonatomic,strong) NSNumber * rowsPerPage;

- (void)show;
- (void)back;
@end


@interface ShareVC : SuperVC

@property (nonatomic, strong) UIView * topBackView;

@property (nonatomic, strong) UIImageView  * topImageView;

@property (nonatomic, strong) NSString     * titleName;

@property (nonatomic, strong) UILabel *mtitlelabel;

@property (nonatomic, strong) UIButton *backbtn;

@property (nonatomic) BOOL  isBackBtn;

@property (nonatomic) float  m_height;

@property (nonatomic) BOOL  isSP;


// 起始页 默认1
@property (nonatomic,strong) NSNumber * page;

// 起始行 默认10
@property (nonatomic,strong) NSNumber * rowsPerPage;
@end
