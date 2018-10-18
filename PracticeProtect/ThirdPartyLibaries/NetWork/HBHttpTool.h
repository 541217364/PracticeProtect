//
//  HBHttpTool.h
//  EztUser
//
//  Created by eztios on 15/3/18.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

//
//  YYHttpTool.h
//网络请求工具类，负责整个项目中所有的Http网络请求

#define NSLogType 1  // 1:正常显示 0 字典格式

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HBHttpTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


+(void)post:(NSString *)url body:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;


+(void)post:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData>))formImgData  success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+(void)post:(NSString *)url params:(NSDictionary *)params showHUD:(BOOL)isShow success:(void (^)(id))success failure:(void (^)(NSError *))failure;


+ (void)CancelAllRequest;
@end
