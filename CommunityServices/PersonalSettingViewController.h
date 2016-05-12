//
//  PersonalSettingViewController.h
//  手机银行
//
//  Created by Gate on 16/1/7.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonalSettingViewControllerDelegate <NSObject>

@optional
-(void) changeAvatar:(UIImage *)avatar;
@end
@interface PersonalSettingViewController : BaseViewController
-(NSString *)mYear;
-(NSString *)mMonth;
-(NSString *)mDay;
@property (nonatomic,assign) id<PersonalSettingViewControllerDelegate> delegate;

@end
