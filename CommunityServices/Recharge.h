//
//  Recharge.h
//  手机银行
//
//  Created by Gate on 4/14/16.
//  Copyright © 2016 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Recharge : NSObject
@property (nonatomic ,strong) NSString *rechargeNum;
@property (nonatomic ,strong) NSString *rechargeMoney;
@property (nonatomic ,strong) User *user;
@end
