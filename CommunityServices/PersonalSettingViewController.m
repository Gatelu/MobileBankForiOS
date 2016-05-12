//
//  PersonalSettingViewController.m
//  手机银行
//
//  Created by Gate on 16/1/7.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "PersonalSettingViewController.h"
#import "HeaderTableViewCell.h"
#import "PersonalTableViewCell.h"
#import "TabbarViewController.h"
#import "ChangeNameViewController.h"
#import "User.h"
#import "MBProgressHUD+MJ.h"
@interface PersonalSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ChangeNameViewControllerDelegate>{
    UIImage *headerImg;
    NSString *year;
    NSString *month;
    NSString *day;
    NSInteger __block sourceType;
    NSDate *newDate;
}
@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)ActionSheetDatePicker *actionSheetPicker;
@property (nonatomic,strong) NSDate *selectedDate;
@property (nonatomic,strong) UIButton *senderBtn;
@property (nonatomic,strong) UIAlertController *picAlertController;
@property (nonatomic,strong) NSUserDefaults *defaults;
//@property (nonatomic ,strong) User *user;
@property (nonatomic ,strong) NSString *imageDataStr;

@end

@implementation PersonalSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人设置";
    _senderBtn = [[UIButton alloc] init];
    _defaults = [NSUserDefaults standardUserDefaults];
    headerImg = [UIImage imageNamed:@"comm_activate_portrait"];
}
-(NSString *)mYear{
    return year;
}

-(NSString *)mMonth{
    return month;
}
-(NSString *)mDay{
    return day;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    }
    return 44;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *UserCell = @"HeaderTableViewCell";
        HeaderTableViewCell *cell = (HeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserCell];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:UserCell
                                                  owner:self
                                                options:nil] lastObject];
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *ava = [defaults stringForKey:kUserPhoto];
        NSData *imageData = [[NSData alloc]initWithBase64EncodedString:ava options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.headerImg.image = image;
        headerImg = image;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString *perCell = @"PersonalTableViewCell";
        PersonalTableViewCell *cell = (PersonalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:perCell];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:perCell
                                                  owner:self
                                                options:nil] lastObject];
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *name = [defaults stringForKey:kUserName];
        cell.titleLabel.text = @"昵称";
        cell.contentLabel.text = name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = 333;
        return cell;
    }if (indexPath.row == 2) {
        static NSString *perCell = @"PersonalTableViewCell";
        PersonalTableViewCell *cell = (PersonalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:perCell];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:perCell
                                                  owner:self
                                                options:nil] lastObject];
        }
//        User *user = [UserDefaultsUtils getCurrentUser];
        NSString *birStr = [UserDefaultsUtils getStringValueWithKey:kUserBirthday];
        NSLog(@"生日是--------%@",birStr);
//        NSDate *oldDate = [UserDefaultsUtils getStringValueWithKey:kUserBirthday];
        cell.titleLabel.text = @"生日";
        cell.contentLabel.text = birStr;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        //NSString转NSDate
        NSDate *date=[formatter dateFromString:cell.contentLabel.text];
        self.selectedDate = [NSDate date];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = 201;
        newDate = date;
        return cell;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sourceType = 0;
    if (indexPath.row == 0) {
           self.picAlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
            UIAlertAction *camra = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"选择了相机");
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                }else{
                     sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                }
                [self performSelector:@selector(goToPickPic) withObject:nil afterDelay:0.5];
            }];
            UIAlertAction *albm = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"选择了相册");
                 sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self performSelector:@selector(goToPickPic) withObject:nil afterDelay:0.5];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消按钮被点击!");
                return;
            }];
            
            [_picAlertController addAction:camra];
            [_picAlertController addAction:albm];
            [_picAlertController addAction:cancel];
            [self presentViewController:_picAlertController animated:YES completion:^{}];
        
    }if (indexPath.row == 1) {
        PersonalTableViewCell *cell = [self.view viewWithTag:333];
        ChangeNameViewController *changeNameViewController = [[ChangeNameViewController alloc] init];
        [changeNameViewController setName:cell.contentLabel.text];
        changeNameViewController.title = @"修改姓名";
        changeNameViewController.delegate=self;
        [self.navigationController pushViewController:changeNameViewController animated:YES];
    }if (indexPath.row == 2) {
        [self showDataPicker:_senderBtn];
    }


}
- (void)goToPickPic{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}
#pragma mark - UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    headerImg = image;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0f);
    NSString *imageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"imageStr/n-----------%@",imageStr);
    [self saveAvatar:imageStr];
//    User *user = [UserDefaultsUtils getCurrentUser];
//    NSLog(@"-----------%@",user.photo);
    [self.delegate changeAvatar:image];
//    [defaults synchronize];
    [self.tableView reloadData];
    
}
-(void)changeName:(NSString *)name{
    PersonalTableViewCell *cell = [self.view viewWithTag:333];
    cell.contentLabel.text=name;

}
-(void) showDataPicker:(UIButton *)sender{
    sender = self.senderBtn;
    self.actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"请选择生日" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"请选择生日" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
    self.actionSheetPicker.hideCancel = NO;
    [self.actionSheetPicker showActionSheetPicker];
}
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    self.selectedDate = selectedDate;
    PersonalTableViewCell *cell = [self.view viewWithTag:201];
    cell.contentLabel.text = [selectedDate stringWithFormat:@"yyyy-MM-dd"];
    year =[NSString stringWithFormat:@"%ld",(long)[selectedDate year]];
    month =[NSString stringWithFormat:@"%ld",(long)[selectedDate month]];
    day =[NSString stringWithFormat:@"%ld",(long)[selectedDate day]];
    [_defaults setObject:cell.contentLabel.text forKey:kUserBirthday];
    [_defaults synchronize];
    NSLog(@"选择的生日是----%@",selectedDate);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:cell.contentLabel.text forKey:kUserBirStr];
    [defaults synchronize];
}
-(void)saveUserName:(NSString *)userName {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:kUserName];
    [defaults synchronize];
}
-(void)saveAvatar:(NSString *)avatar {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:avatar forKey:kUserPhoto];
    [defaults synchronize];
}
- (void)tryUploadAvatar{
    User *user = [UserDefaultsUtils getCurrentUser];
    NSData *imgData = UIImageJPEGRepresentation(headerImg, 1.0f);
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSLog(@"===Encoded image:\n%@", encodedImageStr);
//    NSData *data = UIImageJPEGRepresentation(headerImg, 1.0f);
//    NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *temp = [defaults stringForKey:kUserPhoto];
        [self saveAvatar:encodedImageStr];

        NSDictionary *newAvaParameters = @{@"mobile":user.mobile,@"newPhoto":encodedImageStr};
        [MBProgressHUD showMessage:@"正在保存信息..." toView:self.view];
        [CSHttpClient tryUpdateAva:newAvaParameters success:^(id response) {
            int status = [[response objectForKey:kStatus] intValue];
            if (status == 1) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"保存成功"];
            }else{
                NSString *msg = [response objectForKey:@"msg"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[NSString stringWithFormat:@"%@",msg]];
            }
        } failure:^(NSError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络错误"];
            NSLog(@"错误是-----%@",err);

        }];
    

}
- (IBAction)confirm:(id)sender {
    PersonalTableViewCell *cell = [self.view viewWithTag:201];
    NSString *dateString = cell.contentLabel.text;

    User *user = [UserDefaultsUtils getCurrentUser];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newBirthStr = [formatter stringFromDate:newDate];
    NSLog(@"新的生日是 ------%@",newDate);
    NSLog(@"生日是----%@",user.birthday);
        //        [self saveAvatar:encodedImageStr];
        
        NSDictionary *newBirParameters = @{@"mobile":user.mobile,@"newDate":dateString};
        [MBProgressHUD showMessage:@"正在保存信息..." toView:self.view];
        [CSHttpClient tryUpdateBir:newBirParameters success:^(id response) {
            NSLog(@"reponse----------%@",response);
            int status = [[response objectForKey:kStatus] intValue];
            if (status == 1) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }else{
                NSString *msg = [response objectForKey:@"msg"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[NSString stringWithFormat:@"%@",msg]];
                
            }
        } failure:^(NSError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"网络错误"];
            
        }];
    
    
    [self tryUploadAvatar];
//    NSData *imgData = UIImageJPEGRepresentation(headerImg, 1.0f);
//    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSLog(@"===Encoded image:\n%@", encodedImageStr);
//    NSData *data = UIImageJPEGRepresentation(headerImg, 1.0f);
//    NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *temp = [defaults stringForKey:kUserPhoto];
//        [self saveAvatar:encodedImageStr];
//        
//        NSDictionary *newAvaParameters = @{@"mobile":user.mobile,@"newPhoto":encodedImageStr};
//        [MBProgressHUD showMessage:@"正在保存信息..." toView:self.view];
//        [CSHttpClient tryRename:newAvaParameters success:^(id response) {
//            NSLog(@"reponse----------%@",response);
//            int status = [[response objectForKey:kStatus] intValue];
//            if (status == 1) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                NSLog(@"修改头像成功!!!!");
//                
//            }else{
//                NSString *msg = [response objectForKey:@"msg"];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                [MBProgressHUD showError:[NSString stringWithFormat:@"%@",msg]];
//                
//            }
//        } failure:^(NSError *err) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [MBProgressHUD showError:@"网络错误"];
//            
//        }];
    


}
@end
