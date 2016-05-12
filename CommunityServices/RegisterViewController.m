//
//  RegisterViewController.m
//  手机银行
//
//  Created by Gate on 16/1/6.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "RegisterViewController.h"
#import "InputTableViewCell.h"
#import "SexTableViewCell.h"
#import "TabbarViewController.h"
#import "QuestionTableViewCell.h"
#import "MBProgressHUD+MJ.h"
#import "User.h"
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>{
    UIButton *saveBtn;
}
@property (strong, nonatomic) IBOutlet UIButton *resignBtn;

@end

@implementation RegisterViewController
static NSString *UserCell = @"InputTableViewCell";
static NSCharacterSet* __nonNumbersSet;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addNotification];
    [[NSUserDefaults standardUserDefaults] setObject:@"4444" forKey:@"444"];
}
- (void)initView{
    
    self.title = @"注册";
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAllResponders)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.resignBtn.layer.cornerRadius = self.resignBtn.height / 2;;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)addNotification{
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:102];
    UITextField *nameField = (UITextField *)[self.view viewWithTag:200];
    UITextField *pwdField = (UITextField *)[self.view viewWithTag:300];
    UITextField *queField = (UITextField *)[self.view viewWithTag:400];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:phoneField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:pwdField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:queField];
}
- (void)textChange{
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:102];
    UITextField *nameField = (UITextField *)[self.view viewWithTag:200];
    UITextField *pwdField = (UITextField *)[self.view viewWithTag:300];
    UITextField *queField = (UITextField *)[self.view viewWithTag:400];
    self.resignBtn.enabled = (phoneField.text.length && nameField.text.length && pwdField.text.length && queField.text.length);
}
- (void)resignAllResponders{
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        InputTableViewCell *cell = (InputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserCell];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:UserCell owner:self options:nil] lastObject];
        }
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"手机号";
                cell.inputField.placeholder = @"手机号";
                cell.inputField.keyboardType = UIKeyboardTypeNumberPad;
                cell.inputField.tag = 102;
                break;
            case 1:
                cell.title.text = @"昵称";
                cell.inputField.placeholder = @"昵称";
                cell.inputField.tag = 200;
                break;
            case 2:
                cell.title.text = @"密码";
                cell.inputField.placeholder = @"密码";
                cell.inputField.tag = 300;
                break;
            default:
                break;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *QuCell = @"QuestionTableViewCell";
            QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QuCell];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:QuCell owner:self options:nil] lastObject];
            }
            return cell;
        }
        if (indexPath.row == 1) {
            InputTableViewCell *cell = (InputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserCell];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:UserCell
                                                      owner:self
                                                    options:nil] lastObject];
            }
            cell.title.text = @"密保答案";
            cell.inputField.placeholder = @"密保答案";
            cell.inputField.tag = 400;
            return cell;
        }
    }   if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            static NSString *sexCell = @"SexTableViewCell";
            SexTableViewCell *cell = (SexTableViewCell *)[tableView dequeueReusableCellWithIdentifier:sexCell];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:sexCell owner:self options:nil] lastObject];
            }
            cell.tag = 900;
            return cell;
        }
        if (indexPath.row == 1) {
            InputTableViewCell *cell = (InputTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserCell];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:UserCell
                                                      owner:self
                                                    options:nil] lastObject];
            }
            cell.title.text = @"出生年月";
            cell.inputField.placeholder = @"出生年月";
            cell.inputField.tag = 600;
            UIDatePicker *datePicker = [[UIDatePicker alloc] init];
            datePicker.backgroundColor = [UIColor colorWithRed:0.973 green:0.993 blue:1.000 alpha:1.000];
            datePicker.alpha = 1.0;
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
            cell.inputField.inputView = datePicker;
            return cell;
        }
    }
    return nil;
}
- (void)chooseDate:(UIDatePicker *)sender {
    UITextField *birField = [self.view viewWithTag:600];
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    birField.text = dateString;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (IBAction)redignBtnClick:(id)sender {
    UITextField *textField = [self.view viewWithTag:102];
    NSString *phoneNo=[textField text];
    if([phoneNo length] != 11){
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }else{
        [MBProgressHUD showMessage:@"正在注册" toView:self.view];
        UITextField *phoneField = (UITextField *)[self.view viewWithTag:102];
        UITextField *nameField = (UITextField *)[self.view viewWithTag:200];
        UITextField *pwdField = (UITextField *)[self.view viewWithTag:300];
        UITextField *queField = (UITextField *)[self.view viewWithTag:400];
        UITextField *birField = (UITextField *)[self.view viewWithTag:600];
        SexTableViewCell *sexCell = [self.view viewWithTag:900];
        NSString *mobile = phoneField.text;
        NSString *name = nameField.text;
        NSString *answer = queField.text;
        NSString *sex = sexCell.sex;
        NSString *dateStr = birField.text;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDictionary *registerParameters = @{@"mobile":mobile,@"name":name,@"password":pwdField.text,@"answer":answer,@"sex":sex,@"birthday":dateStr};
        [CSHttpClient tryRegisterWith:registerParameters success:^(id response) {
            int status = [[response objectForKey:kStatus] intValue];
            if (status == 1) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                User *user = [[User alloc] init];
                [user setValuesForKeysWithDictionary:[response objectForKey:@"data"]];
                [UserDefaultsUtils saveCustomObject:user forKey:kUser];
                [UserDefaultsUtils saveStringValue:user.id forKey:kId];
                [defaults setObject:user.name forKey:kUserName];
                [defaults setObject:user.mobile forKey:kUserMobile];
                [defaults setObject:user.birthday forKey:kUserBirthday];
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
                [defaults synchronize];
                self.view.window.rootViewController = [[TabbarViewController alloc] init];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:@"注册失败"];
            }
           
        } failure:^(NSError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"注册失败"];
            NSLog(@"注册失败的原因是=======%@",err);
            return;
        }];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (textField.tag == 102) {
        if (proposedNewLength > 11) return NO;//限制长度
        return YES;
        
    }else{
        return YES;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 400 || textField.tag == 600) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = CGRectMake(0.0, -178, self.view.width, self.view.height);
        [UIView commitAnimations];
    }
}
@end
