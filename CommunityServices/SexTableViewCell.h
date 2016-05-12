//
//  SexTableViewCell.h
//  HiSF-User
//
//  Created by Gate on 15/11/19.
//  Copyright © 2015年 yunwiiTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiShiFuRadioButton.h"
@interface SexTableViewCell : UITableViewCell<RadioButtonDelegate>
@property (strong, nonatomic) UIImageView *manBar;
@property (strong, nonatomic) UIImageView *womanBar;
@property (nonatomic ,strong) UILabel *sexMan;
@property (nonatomic ,strong) UILabel *sexWoman;
@property (nonatomic ,copy) NSString *sex;


@end
