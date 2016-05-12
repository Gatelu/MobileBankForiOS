//
//  Transfer.h
//  手机银行
//
//  Created by Gate on 4/14/16.
//  Copyright © 2016 Gate. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(int, transferType)
{
    //以下是枚举成员
    out = 0,
    in = 1,
};
@interface Transfer : NSObject
@property (nonatomic ,strong) NSString *fromAccount;
@property (nonatomic ,strong) NSString *toAccount;
@property (nonatomic ,assign) float amount;



@end
