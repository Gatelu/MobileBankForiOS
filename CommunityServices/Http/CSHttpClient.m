//
//  ViewController.h
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "CSHttpClient.h"
#import "UserDefaultsUtils.h"

#define BASE_URL @"http://172.20.10.3:8080/payservice/"
NSString * const kLogin = @"user/login";//登录
NSString * const kRegist = @"user/regist";//注册
NSString * const kGetamount = @"user/getamount";//账单详情
NSString * const kPay2mobileaccount = @"pay/pay2mobileaccount";//转账到手机银行账户
NSString * const kPay2card = @"pay/pay2card";//转账到银行卡
NSString * const kPay2host = @"pay/pay2host";//充值
NSString * const kRename = @"user/rename";//修改昵称
NSString * const kPay2mobile = @"pay/pay2mobile";//话费充值
NSString * const kUpdateAva = @"user/updatephoto";//修改头像
NSString * const kUpdateBir = @"user/updatebirthday";//修改生日
@implementation CSHttpClient

static AFHTTPSessionManager *manager;

+ (AFHTTPSessionManager*)getManager{
    if (manager == nil) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        ((AFJSONResponseSerializer*)(manager.responseSerializer)).removesKeysWithNullValues = YES;
        //    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html",nil];;
//        manager.requestSerializer. = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",nil];
    }
//    if([UserDefaultsUtils getStringValueWithKey:kId] != nil)
//    {
//        //设置Header
//        [manager.requestSerializer  setValue:[NSString stringWithFormat:@"%@ %@" , @"Bearer" , [UserDefaultsUtils getStringValueWithKey:kId]] forHTTPHeaderField:@"Authorization"];
//    }
    return manager;
}

+ (NSURLSessionTask*)requestWithMethod:(RequestMethodType)methodType
                                   url:(NSString*)url
                                params:(NSDictionary*)params
                               success:(void (^)(id response))success
                               failure:(void (^)(NSError* err))failure
{
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求
            return [[self getManager] GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            return [[self getManager]  POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) {
                    NSLog(@"-------------------------%@",error);
                    failure(error);
                }
            }];
        }
        default:
            break;
    }
}
+ (void)hideLoading:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+ (void)monitorNetWork{
    [[self getManager].reachabilityManager startMonitoring];
}

+ (void)tryLoginWith:(NSDictionary*)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kLogin] params:params success:success failure:failure];
}
+ (void)tryRegisterWith:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kRegist] params:params success:success failure:failure];
}
+ (void)tryPay2Mobile:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kPay2mobile] params:params success:success failure:failure];
}
+ (void)tryRename:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kRename] params:params success:success failure:failure];
}
+ (void)tryPay2host:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kPay2host] params:params success:success failure:failure];
}
+ (void)tryPay2card:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kPay2card] params:params success:success failure:failure];
}
+ (void)tryGetamount:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kGetamount] params:params success:success failure:failure];
}
+ (void)tryPay2Mobileaccount:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kPay2mobileaccount] params:params success:success failure:failure];
}
+ (void)tryUpdateAva:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kUpdateAva] params:params success:success failure:failure];
}
+ (void)tryUpdateBir:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure{
    [self requestWithMethod:RequestMethodTypePost url:[CSHttpClient getURL:kUpdateBir] params:params success:success failure:failure];
}
+ (NSString *)getURL:(NSString *)key
{
    return [NSString stringWithFormat:@"%@%@",BASE_URL,key];
}

@end
