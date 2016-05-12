//
//  MineHeaderViewCell.m
//  JK189Apple
//
//  Created by 李玉刚 on 3/30/15.
//  Copyright (c) 2015 yalin. All rights reserved.
//

#import "MineHeaderViewCell.h"

@implementation MineHeaderViewCell

- (void)awakeFromNib {
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.cornerRadius = _avatarView.width/2;
//    _avatarBgView.image = [UIImage imageNamed:@"avatar_background"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
