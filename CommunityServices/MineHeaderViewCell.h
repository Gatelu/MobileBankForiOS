//
//  MineHeaderViewCell.h
//  JK189Apple
//
//  Created by 李玉刚 on 3/30/15.
//  Copyright (c) 2015 yalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avatarBgView;
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
