//
//  HeaderTableViewCell.m
//  HiSF-User
//
//  Created by Gate on 15/11/19.
//  Copyright © 2015年 yunwiiTech. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headerImg.clipsToBounds = YES;
    self.headerImg.layer.cornerRadius = self.headerImg.height / 2;
    self.headerImg.image = [UIImage imageNamed:@"icon_user_header"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
