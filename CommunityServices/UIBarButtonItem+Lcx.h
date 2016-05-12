//
//  UIBarButtonItem+HiSF_User.h
//  HiSF-User
//
//  Created by Gate on 15/11/11.
//  Copyright © 2015年 yunwiiTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Lcx)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
