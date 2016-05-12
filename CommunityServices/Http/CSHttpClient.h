//
//  ViewController.h
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};

@interface CSHttpClient : NSObject{
    BOOL isNetWorkReachabe;
}
+ (AFHTTPSessionManager*)getManager;
+ (void)monitorNetWork;
+ (void)hideLoading:(UIView*)view;
+ (void)tryRegisterWith:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryLoginWith:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryPay2Mobile:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryRename:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryPay2host:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryGetamount:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryPay2card:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryPay2Mobileaccount:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryUpdateAva:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
+ (void)tryUpdateBir:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError* err))failure;
@end
