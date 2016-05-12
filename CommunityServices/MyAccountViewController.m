//
//  MyAccountViewController.m
//  手机银行
//
//  Created by Gate on 16/1/8.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "MyAccountViewController.h"
#import "AccountDetailsViewController.h"
#import "RechargeMoneyViewController.h"
#import "User.h"
#import "MBProgressHUD+MJ.h"
@interface MyAccountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (nonatomic ,strong) NSString *moneyLeft;

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的账户";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.amountLabel.text = [defaults stringForKey:kUserAmount];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    User *user = [UserDefaultsUtils getCurrentUser];
    NSDictionary *getamountPra = @{@"mobile":user.mobile};
    [CSHttpClient tryGetamount:getamountPra success:^(id response) {
        NSString *amountLeft = [response objectForKey:@"amount"];
        int status = [[response objectForKey:kStatus] intValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:amountLeft forKey:kUserAmount];
        [defaults synchronize];
        if (status ==1) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
//            MyAccountViewController *vc = [[MyAccountViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络异常，请检查"];
        }
    } failure:^(NSError *err) {
        [MBProgressHUD showError:@"网络异常，请检查"];
        NSLog(@"error-------%@",err);
    }];

}
- (IBAction)accountDetails:(id)sender {
    AccountDetailsViewController *adVc = [[AccountDetailsViewController alloc] init];
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    User *user = [UserDefaultsUtils getCurrentUser];
    NSDictionary *getamountPra = @{@"mobile":user.mobile};
    [CSHttpClient tryGetamount:getamountPra success:^(id response) {
    int status = [[response objectForKey:kStatus] intValue];
        adVc.recordStr = [response objectForKey:@"record"];
    if (status ==1) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController pushViewController:adVc animated:YES];
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误，请检查"];
    }
    } failure:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误，请检查"];
        NSLog(@"error----%@",err);
        }];
    
    
}
- (IBAction)recharge:(id)sender {
    [self.navigationController pushViewController:[[RechargeMoneyViewController alloc] init] animated:YES];
}

@end
