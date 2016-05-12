//
//  TabBar.h
//  Weibo2
//
//  Created by Gate on 15/11/3.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar;

@protocol TabBarDelegate <NSObject>

@optional

-(void)tabBar:(TabBar *)tabBar didselectedButtonFrom:(int)from To:(int)to;
- (void)tabBarDidClickedPlusButton:(TabBar *)tabBar;
    
@end

@interface TabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic,strong) id<TabBarDelegate>delegate;

@end
