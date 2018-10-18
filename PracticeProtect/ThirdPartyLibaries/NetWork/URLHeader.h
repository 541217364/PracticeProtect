//n
//  URLHeader.h
//  EztUser
//
//  Created by eztios on 15/4/17.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//


#define ReschargeStatus 0  //0 :测试, 1:发布

#if ReschargeStatus

#define  XX_UserName  @"dhys";
#define  XX_PassWord  @"12345678";
//#define  XX_UserName  @"";
//#define  XX_PassWord  @"";

//#define SERVER_MC @"http://api.duanwenxue.com/index.php"

#else

#define  XX_UserName  @"dhys";
#define  XX_PassWord  @"123456";

//#define  XX_UserName  @"";
//#define  XX_PassWord  @"";
//#define SERVER_MC  @"http://118.31.11.208/appapi.php"
//#define SERVER_MC  @"https://www.dianbeiwaimai.cn/appapi.php"
#define SERVER_MC  [TRClassMethod getwebServer]
#endif

#define SERVER_URL(url,c,a)     [NSString stringWithFormat:@"%@?c=%@&a=%@",url,c,a]

#pragma 首页模块

#define SHOP_INDEX  SERVER_URL(SERVER_MC,@"Shop_new",@"index") //首页各项数据

#define SHOP_STORELIST  SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_list") //首页餐厅列表

#define SHOP_BROADCAST SERVER_URL(SERVER_MC,@"Shop_new",@"order_info_Broadcast") //首页订单轮播

#define SHOP_AJAXSHOP SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_shop") //店铺信息／菜品列表

#define SHOP_AJAXSREPLY SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_reply") //商店评价

#define SHOP_AJAXSHOPGOODS SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_goods") //商品信息

#define SHOP_ORDERLIST SERVER_URL(SERVER_MC,@"Shop_new",@"order_list") //订单列表

#define SHOP_ORDERDETAILS SERVER_URL(SERVER_MC,@"Shop_new",@"order_status_new") //订单详情

#define SHOP_ORDERADRESS SERVER_URL(SERVER_MC,@"My_new",@"adress") //地址列表

#define SHOP_ADDDRESS SERVER_URL(SERVER_MC,@"My_new",@"edit_adress") //添加收货地址

#define SHOP_DELADRESS SERVER_URL(SERVER_MC,@"My_new",@"del_adress") //删除地址

#define SHOP_SEACHGOODSSTORE SERVER_URL(SERVER_MC,@"Shop_new",@"search") //店铺商品搜索

#define SHOP_HOTVALUES SERVER_URL(SERVER_MC,@"Shop_new",@"hot_keywords") //热门搜索

#define SHOP_QSLINES SERVER_URL(SERVER_MC,@"Shop_new",@"line") 

#define SHOP_AGAINORDER SERVER_URL(SERVER_MC,@"Shop_new",@"confirm_order") //再来一单


#define SHOP_CANCELORDER SERVER_URL(SERVER_MC,@"My_new",@"shop_order_refund") //取消订单

#define SHOP_SUREORDER SERVER_URL(SERVER_MC,@"Shop_new",@"user_order_Complete")

//确认收货

#define SHOP_VERSION SERVER_URL(SERVER_MC,@"My_new",@"app_version") //版本



#define MEMBER_ID @"7716"


#ifndef EztUser_URLHeader_h

#define EztUser_URLHeader_h

#define Merger(a,b) [NSString stringWithFormat:@"%@_%@",a,b]

/**
 * 服务器地址
 */
#define SERVER_HOST  @"http://api.duanwenxue.com/index.php"



/**
 * IM服务器客户端到服务器端口
 */
#define SERVER_PORT  5222

/**
 * 网络连接超时时间
 */
#define HTTP_TIMEOUT_CONNECTION  10 * 1000
/**
 * 等待数据超时时间
 */
#define HTTP_SOTIMOUT  10 * 1000

/**
 * 设置是否打印日志
 */
#define IS_PRINT_LOG  YES

/**
 * 收到新消息手机振动持续时间(ms)
 */
#define VIBRATOR_DURATION  300

/**
 * 获取验证码时间
 */
#define GET_VERCODE_TIME  60

/**
 * 表情的数量
 */
#define FACE_IMG_COUNT  140

/**
 * 其他功能选项数
 */
#define OTHER_COUNT  7

/**
 * 每页显示的条数
 */
#define E_PAGE_SIZE  20

/**
 * 广告图更换时间间隔
 */
#define SCROLL_TIME  10000

// 友盟
#define DESCRIPTOR  "com.umeng.share"





#endif
