//
//  ViewController.h
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "UserDefaultsUtils.h"
NSString * const kResponseData = @"data";
NSString * const kResponseMessage = @"message";
NSString * const kResponseStatuseCode = @"statusCode";
NSString * const kDataBaseVersion = @"database_version";
NSString * const kId = @"id";
NSString * const kUser = @"user";
NSString * const kGuideVersion = @"guide_version";
NSString * const kMobile = @"mobile";
NSString * const kStatus = @"ok";
NSString * const kUserName = @"name";
NSString * const kUserMobile = @"mobile";
NSString * const kUserAmount = @"amount";
NSString * const kUserBirthday = @"birthday";
NSString * const kUserPhoto = @"photo";
NSString * const kUserBirStr = @"birthdayStr";
NSString * const kMoneyLeft = @"photo";

@implementation UserDefaultsUtils
+ (User*)getCurrentUser{
    return [self getCustomObjectWithKey:kUser];
}
+ (id)getCustomObjectWithKey:(NSString*)key{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (NSArray*)getArrayDatasWithKey:(NSString*)key{
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    return array;
}

+ (NSString*)getStringValueWithKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (NSInteger)getIntegerValueWithKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (BOOL)getBoolValueWithKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (NSDictionary*)getDictionaryWithKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
}

+ (void)saveStringValue:(NSString*)value forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveIntegerValue:(NSInteger)value forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveBooleanValue:(BOOL)value forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveArrayValue:(NSArray*)value forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveDictionary:(NSDictionary*)value forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveCustomObject:(id)value forKey:(NSString*)key{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clear{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *keyValuesForDefaults = [defaults persistentDomainForName:appDomain];
    for (NSString *key in [keyValuesForDefaults keyEnumerator]) {
        if ([key containsString:@"guide"] || [key isEqualToString:kDataBaseVersion] || [key containsString:@"vocabularyVersionOfLevel"]) {
            continue;
        }
        [defaults removeObjectForKey:key];
        NSLog(@"user defaults key %@",key);
    }
    [defaults synchronize];
}

@end
