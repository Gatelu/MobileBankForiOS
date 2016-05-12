//
//  TransferMobileViewController.m
//  手机银行
//
//  Created by Gate on 16/1/6.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "TransferMobileViewController.h"
#import "MBProgressHUD+MJ.h"

@interface TransferMobileViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation TransferMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转到手机银行账户";
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
    NSString *mobile = self.mobileField.text;
    NSString *password = self.pwdField.text;
    NSString *amountText = self.amountField.text;
    NSDictionary *pay2MobileParameters = @{@"mobile":mobile,@"password":password,@"amount":amountText};
    [MBProgressHUD showMessage:@"正在转账" toView:self.view];

    [CSHttpClient tryPay2Mobileaccount:pay2MobileParameters success:^(id response) {
        int status = [[response objectForKey:kStatus] intValue];
        if (status == 1) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showSuccess:@"转账成功"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *amountStr = [defaults stringForKey:kUserAmount];
            int amount = [amountStr intValue];
            int amountLeft = amount - [amountText intValue];
            NSString *amountLeftStr = [NSString stringWithFormat:@"%d",amountLeft];
            [defaults setObject:amountLeftStr forKey:kUserAmount];
            [defaults synchronize];
            


            NSLog(@"成功啦！！！！");
        }else{
            NSString *msg = [response objectForKey:@"msg"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",msg]];
        }
    } failure:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误，请检查"];
        NSLog(@"==================%@",err);

    }];
}
#pragma mark -UITextFieldDelegate方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 11) return NO;//限制长度
    return YES;
}

@end
