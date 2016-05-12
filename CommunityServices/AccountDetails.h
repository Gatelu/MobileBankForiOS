//
//  AccountDetails.h
//  手机银行
//
//  Created by Gate on 4/13/16.
//  Copyright © 2016 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@class User;
@interface AccountDetails : NSObject
@property (nonatomic ,strong) NSString *transferType;
@property (nonatomic ,strong) NSString *transferAmount;
@property (nonatomic ,strong) NSString *mobile;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailsWithDict:(NSDictionary *)dict;
@end
