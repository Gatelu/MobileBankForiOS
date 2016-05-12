//
//  TabBarButton.m
//  Weibo2
//
//  Created by Gate on 15/11/4.
//  Copyright © 2015年 Gate. All rights reserved.
//
//图标比例
#define TabBarButtonRatio 0.6
#import "TabBarButton.h"
@interface TabBarButton();

//提醒数字按钮
@property (strong,nonatomic)UIButton *badgeButton;

@end

@implementation TabBarButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        //文字默认颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //文字选定颜色
        [self setTitleColor:[UIColor colorWithRed:0.173 green:0.769 blue:0.612 alpha:1.000] forState:UIControlStateSelected];
        
        //添加一个提醒数字按钮
        UIButton *badgeButton = [[UIButton alloc] init];
        badgeButton.hidden = YES;
        [self.badgeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_profile_os7"] forState:UIControlStateNormal];
        badgeButton.titleLabel.font = [UIFont systemFontOfSize:11];
        badgeButton.titleLabel.textColor = [UIColor blackColor];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
//        badgeButton.titleLabel.textColor = [UIColor orangeColor];
//        self.badgeButton.titleLabel.textColor = [UIColor orangeColor];
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;

    }
    return self;
}
//重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    
}
//内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height *TabBarButtonRatio;
    return CGRectMake(0, 0, imageW, imageH);
    
}
//内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height *TabBarButtonRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);

}
//设置item
- (void)setItem:(UITabBarItem *)item{
    _item = item;
//    //设置文字
//    [self setTitle:item.title forState:UIControlStateNormal];
//    //设置图片
//    [self setImage:item.image forState:UIControlStateNormal];
//    [self setImage:item.selectedImage forState:UIControlStateSelected];
//    //设置提醒数字
//    if (item.badgeValue) {
//        NSLog(@"上标的内容是------%@",item.badgeValue);
//        self.badgeButton.hidden = NO;
////        [self.badgeButton setHidden:NO];
//        NSLog(@"按钮的状态------%d",self.badgeButton.hidden);
//        //设置badgeValue
//        [self.badgeButton setTitle:item.badgeValue forState:UIControlStateNormal];
//        //设置badge的frame
//        
//        CGFloat badgeButtonY = 10;
//        //文字的尺寸
//        CGSize badgeSize = [item.badgeValue sizeWithFont:self.badgeButton.titleLabel.font];
////        CGSize badgeSize = [item.badgeValue sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};];
//        
//        CGFloat badgeButtonW = badgeSize.width + 10;
//        
//        CGFloat badgeButtonX = self.frame.size.width - badgeButtonW - 5;
//        
//        CGFloat badgeButtonH = self.badgeButton.currentBackgroundImage.size.height;
//        
//        self.badgeButton.frame = CGRectMake(badgeButtonX, badgeButtonY, badgeButtonW, badgeButtonH);
//    }else{
//        self.badgeButton.hidden = YES;
//    }
    //KVO监听按钮属性的改变
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
//移除监听
- (void)dealloc{
    
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    if (self.item.badgeValue) {
        NSLog(@"上标的内容是------%@",self.item.badgeValue);
        self.badgeButton.hidden = NO;
        //        [self.badgeButton setHidden:NO];
        NSLog(@"按钮的状态------%d",self.badgeButton.hidden);
        //设置badgeValue
        [self.badgeButton setTitle:self.item.badgeValue forState:UIControlStateNormal];
        //设置badge的frame
        
        CGFloat badgeButtonY = 10;
        //文字的尺寸
        CGSize badgeSize = [self.item.badgeValue sizeWithFont:self.badgeButton.titleLabel.font];
        //        CGSize badgeSize = [item.badgeValue sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};];
        
        CGFloat badgeButtonW = badgeSize.width + 10;
        
        CGFloat badgeButtonX = self.frame.size.width - badgeButtonW - 5;
        
        CGFloat badgeButtonH = self.badgeButton.currentBackgroundImage.size.height;
        
        self.badgeButton.frame = CGRectMake(badgeButtonX, badgeButtonY, badgeButtonW, badgeButtonH);
    }else{
        self.badgeButton.hidden = YES;
    }

    
    [self setTitle:self.item.title forState:UIControlStateNormal];

    [self setTitle:self.item.title forState:UIControlStateSelected];

//    [self setImage:self.item.image forState:UIControlStateNormal];
    NSLog(@"图片是 ------ %@",self.item.image);
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}
@end
