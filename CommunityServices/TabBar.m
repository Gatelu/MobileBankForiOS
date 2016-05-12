//
//  TabBar.m
//  Weibo2
//
//  Created by Gate on 15/11/3.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "TabBar.h"
#import "TabBarButton.h"
@interface TabBar()
@property (nonatomic,strong)UIButton *plusButton;
@property (nonatomic,strong)TabBarButton * selectedButton;
@property (nonatomic,strong)NSMutableArray *tabBarButtons;
@end

@implementation TabBar
- (NSMutableArray *)tabBarButtons{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
        [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)plusButtonClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    //创建按钮
    TabBarButton *button = [[TabBarButton alloc] init];
    [self addSubview:button];
    //添加按钮到数组
    [self.tabBarButtons addObject:button];
    //设置数据
    button.item = item;
//    [button setTitle:item.title forState:UIControlStateNormal];
//    [button setImage:item.image forState:UIControlStateNormal];
//    [button setImage:item.selectedImage forState:UIControlStateSelected];
    //监听按钮点击事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
    
    
    
}
- (void)buttonClick:(TabBarButton *)button{
    //1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didselectedButtonFrom:To:)]) {
        [self.delegate tabBar:self didselectedButtonFrom:(int)self.selectedButton.tag To:(int)button.tag];
    }
    //2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat H = self.frame.size.height;
    CGFloat W = self.frame.size.width;
    self.plusButton.center = CGPointMake(W * 0.5, H * 0.5);
    
    CGFloat buttonH = H;
    CGFloat buttonW = W/self.subviews.count;
    CGFloat buttonY = 0;
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        //1.取出按钮
        TabBarButton *button = self.tabBarButtons[index];
        //2.设置frame
        CGFloat buttonX = index*buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //3.绑定tag
        button.tag = index;
    }
    
}
@end
