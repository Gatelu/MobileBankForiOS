//
//  SexTableViewCell.m
//  HiSF-User
//
//  Created by Gate on 15/11/19.
//  Copyright © 2015年 yunwiiTech. All rights reserved.
//

#import "SexTableViewCell.h"

@implementation SexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    HiShiFuRadioButton *rb1 = [[HiShiFuRadioButton alloc] initWithGroupId:@"1" index:0];
    HiShiFuRadioButton *rb2 = [[HiShiFuRadioButton alloc] initWithGroupId:@"1" index:1];
    self.sexMan = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    self.sexMan.text = @"先生";
    self.sexMan.textColor = [UIColor colorWithWhite:0.784 alpha:1.000];
    self.sexMan.font = [UIFont systemFontOfSize:15];
    self.sexWoman = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    self.sexWoman.text = @"女士";
    self.sexWoman.textColor = [UIColor colorWithWhite:0.784 alpha:1.000];
    self.sexWoman.font = [UIFont systemFontOfSize:15];
    //蓝色标记
    self.manBar = [[UIImageView alloc] initWithFrame:CGRectMake(80,self.height - 2 , 30, 2)];
    self.manBar.backgroundColor = [UIColor colorWithRed:0.643 green:0.851 blue:0.973 alpha:1.000];
    self.manBar.frame = CGRectMake(75,self.height - 2 , 30, 2);
    self.manBar.hidden = YES;
    [self addSubview:_manBar];
    self.womanBar = [[UIImageView alloc] initWithFrame:CGRectMake(120,self.height - 2 , 30, 20)];
    self.womanBar.backgroundColor = [UIColor colorWithRed:0.643 green:0.851 blue:0.973 alpha:1.000];
    self.womanBar.frame = CGRectMake(130,self.height - 2 , 30, 2);
    self.womanBar.hidden = YES;
    [self addSubview:_womanBar];
    
    
    rb1.frame = CGRectMake(75,0,30,40);
    rb2.frame = CGRectMake(130,0,30,40);
    [rb1 addSubview:self.sexMan];
    [rb2 addSubview:self.sexWoman];
    [self addSubview:rb1];
    [self addSubview:rb2];
    [HiShiFuRadioButton addObserverForGroupId:@"1" observer:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    switch (index) {
        case 0:
            NSLog(@"nan");
            self.manBar.hidden = NO;
            self.womanBar.hidden = YES;
            self.sexMan.textColor = [UIColor colorWithRed:0.286 green:0.333 blue:0.361 alpha:1.000];
            self.sexWoman.textColor = [UIColor colorWithWhite:0.784 alpha:1.000];
            self.sex = @"男";
            break;
        case 1:
            NSLog(@"nv");
            self.womanBar.hidden = NO;
            self.manBar.hidden = YES;
            self.sexWoman.textColor = [UIColor colorWithRed:0.286 green:0.333 blue:0.361 alpha:1.000];
            self.sexMan.textColor = [UIColor colorWithWhite:0.784 alpha:1.000];
            self.sex = @"女";
            break;

            
        default:
            break;
    }
    
}


@end
