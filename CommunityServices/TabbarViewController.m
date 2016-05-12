//
//  TabbarViewController.m
//  Weibo2
//
//  Created by Gate on 15/11/3.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "TabbarViewController.h"
#import "ServiceViewController.h"
#import "DiscoverViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "TabBar.h"
#import "CSNavigationController.h"
#import "PopMenu.h"
#import "RechargeViewController.h"
//#import "ComposeViewController.h"
@interface TabbarViewController ()<TabBarDelegate>
@property (nonatomic,strong) TabBar *customTabBar;
@property (nonatomic, strong) PopMenu *popMenu;

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTabBar];
    [self setupAllChildViewControllers];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
+ (TabbarViewController *)sharedInstance
{
    static TabbarViewController *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}
#pragma mark - 监听tabBar按钮的改变
- (void)tabBar:(TabBar *)tabBar didselectedButtonFrom:(int)from To:(int)to{
    NSLog(@"-------------%d-----%d",from,to);
    self.selectedIndex = to;
}

- (void)tabBarDidClickedPlusButton:(TabBar *)tabBar
{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"二手" iconName:@"walk_big" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    menuItem = [[MenuItem alloc] initWithTitle:@"超市" iconName:@"run_big" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:1];
    [items addObject:menuItem];
    menuItem = [[MenuItem alloc] initWithTitle:@"物业" iconName:@"ride_big" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:2];
    [items addObject:menuItem];
    menuItem = [[MenuItem alloc] initWithTitle:@"水电" iconName:@"ride_big" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:3];
    [items addObject:menuItem];
    menuItem = [[MenuItem alloc] initWithTitle:@"旅游" iconName:@"ride_big" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:4];
    [items addObject:menuItem];
    menuItem = [[MenuItem alloc] initWithTitle:@"新闻" iconName:@"ride_big" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:5];
    [items addObject:menuItem];
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.window.frame items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        return;
    }
    __block TabbarViewController *controller = self;
    CSNavigationController *secondGoodsController = [[CSNavigationController alloc] initWithRootViewController:[[RechargeViewController alloc] init]];
    CSNavigationController *goodsPushController = [[CSNavigationController alloc] initWithRootViewController:[[RechargeViewController alloc] init]];

    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        switch (selectedItem.index) {
            case 0:
                [controller presentViewController:secondGoodsController animated:YES completion:nil];
                break;
                
            case 1:
                 [controller presentViewController:goodsPushController animated:YES completion:nil];
                break;
            case 2:
                 [[TabbarViewController sharedInstance].navigationController pushViewController:[[RechargeViewController alloc] init] animated:YES];
                break;
            default:
                break;
        }
    };
[_popMenu showMenuAtView:self.view.window startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(0, CGRectGetHeight(self.view.bounds))];
}

- (void)setupTabBar{
    
    TabBar *myTabBar = [[TabBar alloc]init];
//    myTabBar.backgroundColor = [UIColor redColor];
    myTabBar.delegate = self;

    myTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:myTabBar];
    self.customTabBar = myTabBar;
    
}
- (void)setupAllChildViewControllers{
    //初始化子控制器
    //1.首页
    HomeViewController *home = [[HomeViewController alloc] init];
//    home.tabBarItem.badgeValue = @"19";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home_os7" selectedImageName:@"tabbar_home_selected_os7"];
//    2.服务
    ServiceViewController *message = [[ServiceViewController alloc] init];
//    message.tabBarItem.badgeValue = @"10";
    [self setupChildViewController:message title:@"服务" imageName:@"home_service" selectedImageName:@"home_service_s"];
    //3.广场
    DiscoverViewController *square = [[DiscoverViewController alloc] init];
    [self setupChildViewController:square title:@"发现" imageName:@"home_find"
                 selectedImageName:@"home_find_s"];
    //4.我
    MineViewController *mine = [[MineViewController alloc] init];
    [self setupChildViewController:mine title:@"个人中心" imageName:@"home_my" selectedImageName:@"home_my_s"];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CSNavigationController *nav = [[CSNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    //添加tabbar内部按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}


@end
