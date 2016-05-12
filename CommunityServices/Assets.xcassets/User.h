//
//  User.h
//  手机银行
//
//  Created by Gate on 16/1/17.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,strong) NSString *mobile;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSString *photo;
@property (nonatomic ,strong) NSString *amount;
@property (nonatomic ,strong) NSString *answer;
@property (nonatomic ,strong) NSString *birthday;
@property (nonatomic ,strong) NSString *password;
@property (nonatomic ,strong) NSString *createTime;
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *updateTime;
@property (nonatomic ,strong) NSString *record;


@end
