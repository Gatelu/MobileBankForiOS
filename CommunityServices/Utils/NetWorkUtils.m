//
//  ViewController.h
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "NetWorkUtils.h"

@implementation NetWorkUtils

+ (BOOL)isConnected{
    
    return [CSHttpClient getManager].reachabilityManager.reachable;
}

+ (BOOL)isConnectedShowTipInView:(UIView*)view{
    if (![self isConnected]) {
        [view.window makeToast:@"网络未连接，请检查"];
    }
    return [self isConnected];
}

+ (AFNetworkReachabilityStatus)getConnectedStatus{
    return [[CSHttpClient getManager].reachabilityManager networkReachabilityStatus];
}
@end
