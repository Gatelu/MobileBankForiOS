//
//  GenerateViewController.m
//  手机银行
//
//  Created by Gate on 16/1/4.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "GenerateViewController.h"
#import "MyQRViewController.h"
#import "QRCodeGenerator.h"
#import "User.h"
@interface GenerateViewController ()
@property (strong, nonatomic) IBOutlet UIButton *generateBtn;
@property (strong, nonatomic) IBOutlet UITextField *moneyTextField;
@property (strong, nonatomic) IBOutlet UIImageView *codeImageView;

@end

@implementation GenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款码";
    self.generateBtn.clipsToBounds = YES;
    self.generateBtn.layer.cornerRadius = 10;
}
- (IBAction)generate:(id)sender {
    User *user = [UserDefaultsUtils getCurrentUser];
    NSString *mobile = user.mobile;
    NSString *completeStr = [NSString stringWithFormat:@"%@%@",mobile,self.moneyTextField.text];
    self.codeImageView.image = [QRCodeGenerator qrImageForString:completeStr imageSize:self.codeImageView.bounds.size.width];
        [self.view endEditing:YES];
}

@end
