//
//  AccountDetails.m
//  手机银行
//
//  Created by Gate on 4/13/16.
//  Copyright © 2016 Gate. All rights reserved.
//

#import "AccountDetails.h"

@implementation AccountDetails
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
        self.transferType = dict[@"type"];
        if ([dict[@"type"] isEqualToString:@"1"]) {
            self.transferType = @"转出";
        }else{
            self.transferType = @"转入";
        }
        self.transferAmount = dict[@"amount"];
        self.mobile = dict[@"mobile"];
    }
    return self;
}
+ (instancetype)detailsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
