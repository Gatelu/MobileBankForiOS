//
//  TransferCardViewController.m
//  手机银行
//
//  Created by Gate on 16/1/6.
//  Copyright © 2016年 Gate. All rights reserved.
//
#import "TransferCardViewController.h"
#import "MBProgressHUD+MJ.h"
@interface TransferCardViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *cardField;
@property (weak, nonatomic) IBOutlet UITextField *moneyField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation TransferCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账到银行卡";
    self.confirmBtn.layer.cornerRadius = 10;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAllResponders)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
- (void)resignAllResponders{
    [self.view endEditing:YES];
}
- (IBAction)confirm:(id)sender {
    [self.view endEditing:YES];
    NSString *card = self.cardField.text;
    NSString *pwd = self.pwdField.text;
    NSString *amount = self.moneyField.text;
    NSDictionary *pay2CardParameters = @{@"cardNum":card,@"password":pwd,@"amount":amount};
    [MBProgressHUD showMessage:@"正在转账" toView:self.view];
    [CSHttpClient tryPay2card:pay2CardParameters success:^(id response) {
        int status = [[response objectForKey:kStatus] intValue];
        NSLog(@"------------%@",response);
        if (status == 1) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showSuccess:@"转账成功"];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            NSString *amountStr = [defaults stringForKey:kUserAmount];
//            int amount = [amountStr intValue];
//            int amountLeft = amount - [self.moneyField
//                                       .text intValue];
//            NSString *amountLeftStr = [NSString stringWithFormat:@"%d",amountLeft];
//            [defaults setObject:amountLeftStr forKey:kUserAmount];
//            [defaults synchronize];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"账户或密码错误，请检查"];
        }
        
    } failure:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"转到银行卡失败的错误是%@",err);
        [MBProgressHUD showError:@"网络异常，请检查"];
    }];

    
}


@end
