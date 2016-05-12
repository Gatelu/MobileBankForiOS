//
//  UIBarButtonItem+HiSF_User.m
//  HiSF-User
//
//  Created by Gate on 15/11/11.
//  Copyright © 2015年 yunwiiTech. All rights reserved.
//

#import "UIBarButtonItem+Lcx.h"
#import "UIView+KGViewExtend.h"
@implementation UIBarButtonItem (Lcx)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.centerX = button.centerX + 42;
    label.centerY = button.centerY + 14;
    label.textColor = [UIColor colorWithWhite:0.467 alpha:1.000];
//    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:13];
    label.text = title;
    [button addSubview:label];
    
    [button setTitleColor:[UIColor colorWithWhite:0.467 alpha:1.000] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 60, 30);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
//
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.467 alpha:1.000];
//    textAttrs[NSBaselineOffsetAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
//    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:13];
//    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
