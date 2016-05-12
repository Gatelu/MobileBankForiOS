//
//  HomeViewController.m
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
#import "HomeViewController.h"
#import "PopMenu.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "SubLBXScanViewController.h"
#import "MyQRViewController.h"
#import "GenerateViewController.h"
#import "CalculateViewController.h"
#import "TransferAccountsViewController.h"
#import "RegisterViewController.h"
#import "RechargeViewController.h"
#import "MyAccountViewController.h"
#import "MBProgressHUD+MJ.h"
#import "WYScrollView.h"
#import "HZWebViewController.h"
#import "SerialLocationViewController.h"
#import "ViewController.h"
@interface HomeViewController ()<UIScrollViewDelegate,WYScrollViewLocalDelegate>{
    HZWebViewController *webViewController;
}

@property (strong, nonatomic) IBOutlet UIButton *scanBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic ,strong) NSMutableArray *muArray;
@property(nonatomic,strong)NSArray *localImageArray;
#define imageCount 4
@end
@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    [self createLocalScrollView];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}
-(void)createLocalScrollView
{
    /** 设置本地scrollView的Frame及所需图片*/
    WYScrollView *WYLocalScrollView = [[WYScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 130) WithLocalImages:self.localImageArray];
    
    /** 设置滚动延时*/
    WYLocalScrollView.AutoScrollDelay = 2;
    
    /** 获取本地图片的index*/
    WYLocalScrollView.localDelagate = self;
    
    /** 添加到当前View上*/
    [self.view addSubview:WYLocalScrollView];
}

/** 获取本地图片的index*/
-(void)didSelectedLocalImageAtIndex:(NSInteger)index
{
    webViewController = [HZWebViewController new];
    NSLog(@"点中本地图片的下标是:%ld",(long)index);
//    NSString *message = [NSString stringWithFormat:@"点中本地图片的下标是:%ld",index];
//    [MBProgressHUD showError:message];

    NSString *urlStr = [[NSString alloc] init];
    switch (index) {
        case 0:
            urlStr = @"http://tuan.ruyigou.cc/index.php/index/agricultural";
            webViewController.titleStr = @"北国如意购";
            break;
        case 1:
            urlStr = @"http://abcbank.caihuinet.com/yxywzyapp/";
            webViewController.titleStr = @"e动天地";
            break;
        case 2:
            urlStr = @"http://abc.tianhu.com/wap/?type=1";
            webViewController.titleStr = @"e购天街";
            break;
        case 3:
            urlStr = @"http://app.abchina.com/client/phone/MobileApp/CreditCard/CreditCard/PreferentialMerchants";
            webViewController.titleStr = @"特惠商户";
            break;
        default:
            break;
    }
//    HZWebViewController *webViewController = ;
    //    webViewController.mode = HZWebBrowserModeNavigation;
    webViewController.mode = HZWebBrowserModeModal;
    webViewController.URL = [NSURL URLWithString:urlStr];
    [self.navigationController pushViewController:webViewController animated:YES];
//    [self presentViewController:webViewController animated:YES completion:^{}];
}
-(NSArray *)localImageArray
{
    if(!_localImageArray)
    {
        _localImageArray = @[@"1",@"2",@"3",@"4"];
    }
    return _localImageArray;
}
- (IBAction)scan:(UIButton *)sender {
    
    SEL normalSelector = NSSelectorFromString(@"qqStyle");
    if ([self respondsToSelector:normalSelector]) {
        
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
    
}
- (IBAction)generate:(id)sender {
    
    SEL normalSelector = NSSelectorFromString(@"myQR");
    if ([self respondsToSelector:normalSelector]) {
        
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
    
}
- (void)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)myQR
{
    GenerateViewController *vc = [[GenerateViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)myAccount:(id)sender {
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    User *user = [UserDefaultsUtils getCurrentUser];
    NSDictionary *getamountPra = @{@"mobile":user.mobile};
    [CSHttpClient tryGetamount:getamountPra success:^(id response) {
            NSString *amountLeft = [response objectForKey:@"amount"];
            int status = [[response objectForKey:kStatus] intValue];
            if (status ==1) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:amountLeft forKey:kUserAmount];
                [defaults synchronize];
                MyAccountViewController *vc = [[MyAccountViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:@"网络异常，请检查"];
            }
        } failure:^(NSError *err) {
            [MBProgressHUD showError:@"网络异常，请检查"];
            NSLog(@"error-------%@",err);
        }];

}
- (IBAction)calculateExchangeRate:(id)sender {
    webViewController = [HZWebViewController new];
    webViewController.mode = HZWebBrowserModeModal;
    webViewController.URL = [NSURL URLWithString:@"http://www.fxdiv.com/huilvhuansuanqi/"];
    webViewController.titleStr = @"汇率计算";
    [self.navigationController pushViewController:webViewController animated:YES];
//    CalculateExchangeRateViewController *vc = [[CalculateExchangeRateViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)calculate:(id)sender {
    
    CalculateViewController *vc = [[CalculateViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
}
- (IBAction)transfer:(id)sender {
    TransferAccountsViewController *vc = [[TransferAccountsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
- (IBAction)recharge:(id)sender {
    RechargeViewController *vc = [[RechargeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)unAchieve:(id)sender {
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}
@end
