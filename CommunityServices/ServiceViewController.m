//
//  MessageViewController.m
//  CommunityServices
//
//  Created by Gate on 15/12/22.
//  Copyright © 2015年 Gate. All rights reserved.
//

#import "ServiceViewController.h"
#import "CalculateViewController.h"
#import "TransferAccountsViewController.h"
#import "RechargeViewController.h"
#import "HZWebViewController.h"
#import "ViewController.h"
@interface ServiceViewController (){
    HZWebViewController *webViewController;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)calculateExchangeRate:(id)sender {
//    CalculateExchangeRateViewController *vc = [[CalculateExchangeRateViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    webViewController = [HZWebViewController new];
    webViewController.mode = HZWebBrowserModeModal;
    webViewController.URL = [NSURL URLWithString:@"http://freecurrencyrates.com/zh-hans/#USD;CNH;1;;fcr"];
    webViewController.titleStr = @"汇率计算";
    [self.navigationController pushViewController:webViewController animated:YES];
    
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
    [self.view.window makeToast:@"暂未实现..."];
}
- (IBAction)stockCheck:(id)sender {
    webViewController = [HZWebViewController new];
    webViewController.mode = HZWebBrowserModeModal;
    webViewController.URL = [NSURL URLWithString:@"http://gupiao.baidu.com/stock/sh000001.html?from=aladingpc"];
    webViewController.titleStr = @"股票查询";
    [self.navigationController pushViewController:webViewController animated:YES];

//    [self.navigationController pushViewController:[[StockViewController alloc] init] animated:YES];
}
- (IBAction)goToMap:(id)sender {
    
}


@end
