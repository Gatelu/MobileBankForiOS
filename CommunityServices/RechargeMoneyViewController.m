//
//  RechargeMoneyViewController.m
//  手机银行
//
//  Created by Gate on 16/4/2.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "RechargeMoneyViewController.h"
#import "RechargeView.h"
#import "MBProgressHUD+MJ.h"
@interface RechargeMoneyViewController ()<CommitMoneyCountDelegate>{
    RechargeView *reView;
}
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *chooseCardLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation RechargeMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户充值";
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAllResponders)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
- (void)resignAllResponders{
    [self.view endEditing:YES];
}
- (IBAction)chooseCard:(id)sender {
    self.shadowView.hidden = NO;
    reView = [[RechargeView alloc] init];
    reView.frame = CGRectMake(25, 100, SCREEN_WIDTH - 50, 460);
    reView.alpha = 0.0;
    reView.delelgate = self;
    [self.view addSubview:reView];
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.7 animations:^{
        reView.alpha = 1.0;
        self.shadowView.alpha = 0.5;
        
    }];
}
-(void)commitMoneyButtonClickWithMoneyCount:(NSString *)moneyCount{
    self.chooseCardLabel.text = moneyCount;
    [UIView animateWithDuration:0.7 animations:^{
        reView.alpha = 0.0;
        self.shadowView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [reView removeFromSuperview];
        self.shadowView.hidden = YES;
    }];
}
- (IBAction)confimBtn:(id)sender {
    [MBProgressHUD showMessage:@"正在充值..." toView:self.view];
    NSString *cardNum = self.chooseCardLabel.text;
    NSString *pwd = self.pwdField.text;
    NSString *amount = self.moneyField.text;
    User *user = [UserDefaultsUtils getCurrentUser];
    NSLog(@"^^^^^^^^^^%@",user);
    NSDictionary *pay2HostParameters = @{@"cardNum":cardNum,@"password":pwd,@"amount":amount};
    NSLog(@"-------------%@------%@------%@",cardNum,pwd,amount);
    [CSHttpClient tryPay2host:pay2HostParameters success:^(id response) {
        int status = [[response objectForKey:kStatus] intValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *amountLeft = [response objectForKey:@"amount"];
        [defaults setObject:amountLeft forKey:kUserAmount];
        [defaults synchronize];
        NSLog(@"------------%@",response);
        if (status == 1){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showSuccess:@"充值成功"];
//            NSString *amountStr = [defaults stringForKey:kUserAmount];
//            int amount = [amountStr intValue];
//            int amountLeft = amount - [self.moneyField
//                                       .text intValue];
//            NSString *amountLeftStr = [NSString stringWithFormat:@"%d",amountLeft];
            
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络异常，请检查"];
        }
        
    } failure:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"充值的错误是%@",err);
        [MBProgressHUD showError:@"网络异常，请检查"];
    }];
    
    
}
@end
