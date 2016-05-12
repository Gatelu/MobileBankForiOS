//
//  ChangeNameViewController.m
//  JK189Apple
//
//  Created by wang basil on 14-12-17.
//  Copyright (c) 2014年 yalin. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "MBProgressHUD+MJ.h"
#import "User.h"
@interface ChangeNameViewController ()<UITextFieldDelegate>

@end

@implementation ChangeNameViewController

-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewWillAppear:animated];;
    [name becomeFirstResponder];
}
-(void) creatNavigationBar{
    [[self navigationController]setNavigationBarHidden:NO];
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClicked:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavigationBar];
    // Do any additional setup after loading the view.
    name = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, SCREEN_WIDTH - 60, 30)];
    name.delegate = self;
    name.borderStyle = UITextBorderStyleRoundedRect;
    [name setTextColor:[UIColor blackColor]];
    name.text = defaultName;
    [self.view addSubview:name];
}
-(void) setName:(NSString *)dName{
    defaultName=dName;
}

-(IBAction)saveBtnClicked:(id)sender{
    [self.delegate changeName:name.text];
    [[self navigationController] popViewControllerAnimated:YES];
    User *user = [UserDefaultsUtils getCurrentUser];
    NSString *newName = name.text;
    NSLog(@"新姓名是-----%@",newName);
    NSDictionary *renameParameters = @{@"mobile":user.mobile,@"newName":newName};
    [self saveUserName:newName];
    [CSHttpClient tryRename:renameParameters success:^(id response) {
        NSLog(@"reponse--------%@",response);
        int status = [[response objectForKey:kStatus] intValue];
        if (status == 1) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            NSString *msg = [response objectForKey:@"msg"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@",msg]];
        }
        }failure:^(NSError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络错误"];
            
        }];
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveUserName:(NSString *)userName {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:kUserName];
    [defaults synchronize];
}
#pragma UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    [self.navigationItem.rightBarButtonItem setEnabled:newLength > 0];
    return YES;
}

@end
