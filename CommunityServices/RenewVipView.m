//
//  RenewVipView.m
//  myTalk
//
//  Created by LYoung on 15/1/14.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "RenewVipView.h"
#define YColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MonthAndMoneyLabelFont 18.0
#define SELECTEDBUTTONWIDTH 60

@interface RenewVipView()
{
    NSString *_tempMoneyCount;
    
    //button数组
    NSMutableArray *_buttonArray;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;

}

@end


@implementation RenewVipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _buttonArray = [NSMutableArray array];
        _tempMoneyCount = @"50";
        self.backgroundColor = YColor(235, 235, 241);
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    [self creatButton:@"10" index:0];
    button1 = [_buttonArray objectAtIndex:0];
    [self creatButton:@"30" index:1];
    button2 = [_buttonArray objectAtIndex:1];
    [self creatButton:@"50" index:2];
    button3 = [_buttonArray objectAtIndex:2];
    [self creatButton:@"100" index:3];
    button4 = [_buttonArray objectAtIndex:3];
    [self creatButton:@"500" index:4];
    button5 = [_buttonArray objectAtIndex:4];
    //默认选择30
    button1.selected = NO;
    button2.selected = NO;
    button3.selected = YES;
    button4.selected = NO;
    button5.selected = NO;
    //提交按钮
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.layer.cornerRadius = 8;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    commitBtn.frame = CGRectMake(10, 50 + 5*(SELECTEDBUTTONWIDTH + 10) , SCREEN_WIDTH - 70, 50);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"share_buttonBg"] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commitBtn];
}
/**
 *  创建一个可选择的button
 *
 *  @param monthTitle 月份
 *  @param money      钱数
 *  @param index      索引
 */
-(void)creatButton:(NSString *)money index:(int)index
{
    //背景
    UIView *bgView = [[UIView alloc] init];
    bgView.layer.cornerRadius = 8;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(10, index * (SELECTEDBUTTONWIDTH + 10 ) + 10, SCREEN_WIDTH - 70, SELECTEDBUTTONWIDTH);
    [self addSubview:bgView];
    //多少钱
    UILabel *moneyL = [[UILabel alloc] init];
    moneyL.text = [NSString stringWithFormat:@"¥ %@",money];
    moneyL.textColor = YColor(249, 142, 21);
    moneyL.font = [UIFont boldSystemFontOfSize:MonthAndMoneyLabelFont];
    moneyL.frame = CGRectMake(SCREEN_WIDTH/2, 20, 100, 20);
    [bgView addSubview:moneyL];

    //选择的事件
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 8;
    btn.layer.masksToBounds = YES;
    btn.tag = index;
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH - 20, SELECTEDBUTTONWIDTH);
    [btn addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"commitMoney_selected"] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"commitMoney"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH - 60)];
    [bgView addSubview:btn];
    [_buttonArray addObject:btn];
}

//点击那个数目
-(void)selectedButtonClick:(UIButton *)sender
{
    //钱数
    NSString *commitMoneyCount;
    if (sender.tag == 0) {
        button1.selected = YES;
        button2.selected = NO;
        button3.selected = NO;
        button4.selected = NO;
        button5.selected = NO;
        commitMoneyCount = @"10";
    }else if (sender.tag == 1){
        button1.selected = NO;
        button2.selected = YES;
        button3.selected = NO;
        button4.selected = NO;
        button5.selected = NO;
        commitMoneyCount = @"30";
    }else if (sender.tag == 2){
        button1.selected = NO;
        button2.selected = NO;
        button3.selected = YES;
        button4.selected = NO;
        button5.selected = NO;
        commitMoneyCount = @"50";
    }else if (sender.tag == 3){
        button1.selected = NO;
        button2.selected = NO;
        button3.selected = NO;
        button4.selected = YES;
        button5.selected = NO;
        commitMoneyCount = @"100";
    }else if(sender.tag == 4){
        button1.selected = NO;
        button2.selected = NO;
        button3.selected = NO;
        button4.selected = NO;
        button5.selected = YES;
        commitMoneyCount = @"500";
    }
    _tempMoneyCount = commitMoneyCount;
}

//提交按钮事件
-(void)commitButtonClick:(UIButton *)sender
{
    if ([self.delelgate respondsToSelector:@selector(commitMoneyButtonClickWithMoneyCount:)]) {
        [_delelgate commitMoneyButtonClickWithMoneyCount:_tempMoneyCount];
    }
}





@end

