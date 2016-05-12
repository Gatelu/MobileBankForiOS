//
//  LogOnViewController.m
//  HiSF-User
//
//  Created by Gate on 15/11/19.
//  Copyright © 2015年 yunwiiTech. All rights reserved.
//

#import "LogOnViewController.h"
#import "TabbarViewController.h"
#import "RegisterViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MineViewController.h"
@interface LogOnViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *logOnBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumField;
@property (strong, nonatomic) IBOutlet UITextField *securityCodeField;
@property (strong, nonatomic) IBOutlet UIButton *resignBtn;
@end

@implementation LogOnViewController{
    NSTimer *timer;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneNumField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.securityCodeField];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)initView{
    
    self.title = @"登录";
    self.resignBtn.layer.cornerRadius = self.resignBtn.height / 2;
    self.logOnBtn.layer.cornerRadius = self.logOnBtn.height / 2;
    self.phoneNumField.delegate = self;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAllResponders)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
- (void)textChange{
    self.logOnBtn.enabled = (self.phoneNumField.text.length && self.securityCodeField.text.length);
}
- (void)resignAllResponders{
    [self.view endEditing:YES];
}

- (BOOL)isValidateInfoUserName:(NSString *)phoneNum AndCheckCode:(NSString *)checkCode  {
    if ([phoneNum length] != 11) {
        [self showMessage: @"请输入合法的手机号码"];
        return NO;
    }
    if ([checkCode length] == 0) {
        [self showMessage: @"密码不能为空"];
        return NO;
    }
        return YES;
}

- (void)showMessage:(NSString *)message{
    [self.view makeToast: message];
}
- (IBAction)login:(id)sender {
    NSString *phoneNum = self.phoneNumField.text;
    NSString *password = self.securityCodeField.text;
    NSDictionary *loginParameters = @{@"mobile":phoneNum,@"password":password};
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    [CSHttpClient tryLoginWith:loginParameters success:^(id response) {
       int status = [[response objectForKey:kStatus] intValue];
        NSLog(@"------------%@",response);
        if (status == 1) {
            self.view.window.rootViewController = [TabbarViewController sharedInstance];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            User *user = [[User alloc] init];
            [user setValuesForKeysWithDictionary:[response objectForKey:@"data"]];
            [UserDefaultsUtils saveCustomObject:user forKey:kUser];
            [UserDefaultsUtils saveStringValue:user.id forKey:kId];
            [defaults setObject:user.name forKey:kUserName];
            [defaults setObject:user.mobile forKey:kUserMobile];
            [defaults setObject:user.amount forKey:kUserAmount];
            [defaults setObject:user.birthday forKey:kUserBirthday];
            [defaults synchronize];
            UIImage *originImage = [UIImage imageNamed:@"comm_activate_portrait"];
            if ([user.photo isEqualToString:@""]) {
                NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [defaults setObject:encodedImageStr forKey:kUserPhoto];
                [defaults synchronize];
            }else{
                [defaults setObject:user.photo forKey:kUserPhoto];
                [defaults synchronize];
            }
            NSLog(@"--------------%@",user.name);
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"账户或密码错误，请检查"];
        }
        
    } failure:^(NSError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"登录失败的错误是%@",err);
        [MBProgressHUD showError:@"网络异常，请检查"];
    }];
}
- (IBAction)resign:(id)sender {
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}
#pragma mark -UITextFieldDelegate方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 11) return NO;//限制长度
    return YES;
}
@end
