//
//  ViewController.h
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CSHttpClient.h"

@interface NetWorkUtils : NSObject
+ (BOOL)isConnected;
+ (BOOL)isConnectedShowTipInView:(UIView*)view;
+ (AFNetworkReachabilityStatus)getConnectedStatus;
@end
