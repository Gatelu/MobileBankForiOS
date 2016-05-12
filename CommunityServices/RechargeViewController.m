//
//  RechargeViewController.m
//  手机银行
//
//  Created by Gate on 16/1/7.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "RechargeViewController.h"
#import "RenewVipView.h"
#import "MBProgressHUD+MJ.h"
@interface RechargeViewController ()<UITextFieldDelegate,CommitMoneyCountDelegate>{
    RenewVipView *vipView;
}
@property (strong, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UIView *shadowView;
@property (nonatomic,strong)NSString *textStr;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机充值";
    self.rechargeBtn.layer.cornerRadius = 10;

}

- (IBAction)changeMoney:(id)sender {
    self.shadowView.hidden = NO;
    vipView = [[RenewVipView alloc] init];
    vipView.frame = CGRectMake(25, 100, SCREEN_WIDTH - 50, 460);
    vipView.alpha = 0.0;
    vipView.delelgate = self;
    [self.view addSubview:vipView];
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.7 animations:^{
        vipView.alpha = 1.0;
        self.shadowView.alpha = 0.5;
    }];

}
- (IBAction)rechargeBtnClick:(id)sender {
    [self.view endEditing:YES];
    NSString *phoneNo=[self.phoneField text];
    if([phoneNo length] != 11){
        [self.view makeToast:@"请填写正确的手机号码"];
    }else{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确认充值%@元？",self.moneyLabel.text] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入密码（与登录密码一致）";
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *passWord = alertC.textFields.firstObject;
        self.textStr = passWord.text;
        NSLog(@"self.textStr---=======---%@",self.textStr);
        NSString *mobile = self.phoneField.text;
        NSString *amount = self.moneyLabel.text;
        NSString *pwd = passWord.text;
        NSLog(@"self.textStr---=======---%@---%@",amount,pwd);
        NSDictionary *pay2MobilePra = @{@"mobile":mobile,@"password":pwd,@"amount":amount};
        [MBProgressHUD showMessage:@"正在充值" toView:self.view];
        [CSHttpClient tryPay2Mobile:pay2MobilePra success:^(id response) {
            int status = [[response objectForKey:kStatus] intValue];
            if (status == 1) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"充值成功"];
                NSString *amountLeft = [response objectForKey:@"amount"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:amountLeft forKey:kUserAmount];
                [defaults synchronize];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:@"网络错误，请检查"];

            }
        } failure:^(NSError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络错误，请检查"];

        }];

        
        
        
        
        
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    
    [self.navigationController presentViewController:alertC animated:YES completion:^{}];
    }
}
-(void)commitMoneyButtonClickWithMoneyCount:(NSString *)moneyCount{
    self.moneyLabel.text = moneyCount;
    [UIView animateWithDuration:0.7 animations:^{
        vipView.alpha = 0.0;
        self.shadowView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [vipView removeFromSuperview];
        self.shadowView.hidden = YES;
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 11) return NO;//限制长度
    return YES;
}
@end
