//
//  RenewVipView.h
//  myTalk
//
//  Created by LYoung on 15/1/14.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommitMoneyCountDelegate<NSObject>
/**
 *  提交续费按钮事件
 *
 *  @param moneyCount 钱的数目
 */
-(void)commitMoneyButtonClickWithMoneyCount:(NSString *)moneyCount;

@end

@interface RechargeView : UIView

@property (nonatomic, assign) id<CommitMoneyCountDelegate>delelgate;

@end
