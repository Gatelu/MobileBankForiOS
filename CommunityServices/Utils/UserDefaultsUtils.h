//
//  ViewController.h
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
extern NSString * const kResponseData;
extern NSString * const kResponseMessage;
extern NSString * const kResponseStatuseCode;
extern NSString * const kDataBaseVersion;
extern NSString * const kId;
extern NSString * const kUser;
extern NSString * const kUserName;
extern NSString * const kGuideVersion;
extern NSString * const kMobile;
extern NSString * const kStatus;
extern NSString * const kUserMobile;
extern NSString * const kUserPhoto;
extern NSString * const kUserAmount;
extern NSString * const kUserBirthday;
extern NSString * const kUserBirStr;
extern NSString * const kMoneyLeft;

@interface UserDefaultsUtils : NSObject
+ (User*)getCurrentUser;
+ (NSArray*)getArrayDatasWithKey:(NSString*)key;
+ (NSString*)getStringValueWithKey:(NSString*)key;
+ (NSInteger)getIntegerValueWithKey:(NSString*)key;
+ (BOOL)getBoolValueWithKey:(NSString*)key;
+ (NSDictionary*)getDictionaryWithKey:(NSString*)key;
+ (void)saveStringValue:(NSString*)value forKey:(NSString*)key;
+ (void)saveIntegerValue:(NSInteger)value forKey:(NSString*)key;
+ (void)saveBooleanValue:(BOOL)value forKey:(NSString*)key;
+ (void)saveArrayValue:(NSArray*)value forKey:(NSString*)key;
+ (void)saveDictionary:(NSDictionary*)value forKey:(NSString*)key;
+ (void)saveCustomObject:(id)value forKey:(NSString*)key;
+ (void)clear;
@end
