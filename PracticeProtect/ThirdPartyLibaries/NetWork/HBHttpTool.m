//
//  HBHttpTool.h
//  EztUser
//
//  Created by eztios on 15/3/18.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//



#import "HBHttpTool.h"
#import "AFNetworking.h"
@implementation HBHttpTool
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!TR_IsNetWork) {
        TR_Message(@"暂无网络连接，请设置!");
        return;
    }
    
    NSLog(@"----Get请求URL:%@",url);
    NSArray *keys = [params allKeys];
    NSArray *values = [params allValues];
    NSMutableString * string = [NSMutableString new] ;
    for (int i=0; i<keys.count; i++) {
        [string appendFormat:@"\n%@=%@",keys[i],values[i]];
    }
    NSLog(@"----Get请求参数:%@",string);
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.requestSerializer = requestSerializer;
    mgr.requestSerializer.timeoutInterval = 20;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    //3.发送Get请求
    if (![Singleton shareInstance].isRefresh) {
        [[CycleHud sharedView] partShow];
    }
  
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        [[CycleHud sharedView] stop];
        [Singleton shareInstance].isRefresh=NO;
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj  options:NSJSONReadingAllowFragments error:nil] ;
            if (NSLogType) {
                NSString *str = [[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
                NSLog(@"----GET返回数据:%@",str);
            }else{
                
                NSLog(@"----GET返回数据:%@",dic);
            }
            success(dic);

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[CycleHud sharedView] stop];
        NSLog(@"----GET请求数据错误");
     //   TR_Message(@"服务器繁忙，请稍后再试!");
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!TR_IsNetWork) {
        TR_Message(@"暂无网络连接，请设置!");
        return;
    }
    
    NSLog(@"----Post请求URL:%@",url);
    NSArray *keys = [params allKeys];
    NSArray *values = [params allValues];
    NSMutableString * string = [NSMutableString new] ;
    for (int i=0; i<params.count; i++) {
        [string appendFormat:@"\n%@=%@",keys[i],values[i]];
    }
    NSLog(@"----Post请求参数:%@",string);
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.requestSerializer = requestSerializer;
    mgr.requestSerializer.timeoutInterval = 20;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //2.发送Post请求
    if (![Singleton shareInstance].isRefresh) {
        [[CycleHud sharedView] partShow];
    }
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        [[CycleHud sharedView] stop];
        [Singleton shareInstance].isRefresh=NO;

        if (success) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj  options:NSJSONReadingAllowFragments error:nil] ;
            
            if (NSLogType) {
                NSString *str = [[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
                NSLog(@"----POST返回数据:%@",str);
            }else{
                
                NSLog(@"----POST返回数据:%@",dic);
            }
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[CycleHud sharedView] stop];
         NSLog(@"----POST请求错误");
        TR_Message(@"服务器繁忙，请稍后再试!");
        if (failure) {
            failure(error);
        }
    }];
    

}


+(void)post:(NSString *)url body:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!TR_IsNetWork) {
        TR_Message(@"暂无网络连接，请设置!");
        return;
    }
    
    NSLog(@"----Post请求URL:%@",url);
    NSArray *keys = [params allKeys];
    NSArray *values = [params allValues];
    NSMutableString * string = [NSMutableString new] ;
    for (int i=0; i<params.count; i++) {
        [string appendFormat:@"\n%@=%@",keys[i],values[i]];
    }
    NSLog(@"----Post请求参数:%@",string);
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.requestSerializer = requestSerializer;
    mgr.requestSerializer.timeoutInterval = 20;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //2.发送Post请求

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
      
        
        if (success) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj  options:NSJSONReadingAllowFragments error:nil] ;
            
            if (NSLogType) {
                NSString *str = [[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
                NSLog(@"----POST返回数据:%@",str);
            }else{
                
                NSLog(@"----POST返回数据:%@",dic);
            }
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"----POST请求错误");
        //  TR_Message(@"服务器繁忙，请稍后再试!");
        if (failure) {
            failure(error);
        }
    }];
    
    
}



+(void)post:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData>))formImgData  success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!TR_IsNetWork) {
        TR_Message(@"暂无网络连接，请设置!");
        return;
    }
    
    NSLog(@"----Post请求URL:%@",url);
    NSArray *keys = [params allKeys];
    NSArray *values = [params allValues];
    NSMutableString * string = [NSMutableString new] ;
    for (int i=0; i<params.count; i++) {
        [string appendFormat:@"\n%@=%@",keys[i],values[i]];
    }
    NSLog(@"----Post请求参数:%@",string);
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.requestSerializer = requestSerializer;
    mgr.requestSerializer.timeoutInterval = 20;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //2.发送Post请求
    [[CycleHud sharedView] partShow];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:formImgData success:^(AFHTTPRequestOperation *operation,id responseObject) {
        [[CycleHud sharedView] stop];
        if (success) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingAllowFragments error:nil] ;
            
            if (NSLogType) {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"----POST返回数据:%@",str);
            }else{
                
                NSLog(@"----POST返回数据:%@",dic);
            }
            success(dic);
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        [[CycleHud sharedView] stop];
        NSLog(@"----POST请求错误");
        TR_Message(@"服务器繁忙，请稍后再试!");
        if (failure) {
            failure(error);
        }
        
        
    }];
    
}



+(void)post:(NSString *)url params:(NSDictionary *)params showHUD:(BOOL)isShow success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!TR_IsNetWork) {
        TR_Message(@"暂无网络连接，请设置!");
        return;
    }
    
    NSLog(@"----Post请求URL:%@",url);
    NSArray *keys = [params allKeys];
    NSArray *values = [params allValues];
    NSMutableString * string = [NSMutableString new] ;
    for (int i=0; i<params.count; i++) {
        [string appendFormat:@"\n%@=%@",keys[i],values[i]];
    }
    NSLog(@"----Post请求参数:%@",string);
    //1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.requestSerializer = requestSerializer;
    mgr.requestSerializer.timeoutInterval = 20;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //2.发送Post请求
    
    if (isShow) {
        
        if (![Singleton shareInstance].isRefresh) {
            [[CycleHud sharedView] partShow];
        }
    }
    
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        if (isShow) {
            [[CycleHud sharedView] stop];
            [Singleton shareInstance].isRefresh=NO;
        }
       
        
        if (success) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj  options:NSJSONReadingAllowFragments error:nil] ;
            
            if (NSLogType) {
                NSString *str = [[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding];
                NSLog(@"----POST返回数据:%@",str);
            }else{
                
                NSLog(@"----POST返回数据:%@",dic);
            }
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isShow) {
            [[CycleHud sharedView] stop];
        }
        
        NSLog(@"----POST请求错误");
        TR_Message(@"服务器繁忙，请稍后再试!");
        if (failure) {
            failure(error);
        }
    }];
    
    
}




+ (void)CancelAllRequest{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr TRMCancelAllOperations];
    TR_Singleton.HuDCount = 1;
    [[CycleHud sharedView] stop];
}
@end
