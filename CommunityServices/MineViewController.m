//
//  MineViewController.m
//  JK189Apple
//
//  Created by 李玉刚 on 3/30/15.
//  Copyright (c) 2015 yalin. All rights reserved.
//

#import "MineViewController.h"
#import "TabbarViewController.h"
#import "LogOnViewController.h"
#import "User.h"
#import "MBProgressHUD+MJ.h"
#import "PersonalSettingViewController.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,PersonalSettingViewControllerDelegate>{
    NSArray *dataArray;
//    UIImage* newAvatar;
//    User *user;
//    NSString *newName;
}
//@property (nonatomic ,strong) UIImage* newAvatar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = @[@[@{}],@[@{@"image":@"",@"name":@"退出当前账号"}]];
    
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    newName = [defaults stringForKey:kUserName];
//    user = [UserDefaultsUtils getCurrentUser];
//    NSLog(@"username ====== %@",user.name);
    [self.tableView reloadData];
//    [self tryUploadAvatar];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tableView reloadData];
}
#pragma private method


-(void)showQuitAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销登陆" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [defaults removePersistentDomainForName:appDomain];
        [defaults removeObjectForKey:kUser];
        [defaults synchronize];
        [UIApplication sharedApplication].keyWindow.rootViewController=[[UINavigationController alloc] initWithRootViewController:[[LogOnViewController alloc] init]];
    }];
    [alertController addAction:cancel];
    [alertController addAction:confirm];
    [self presentViewController:alertController animated:YES completion:^{}];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MineHeaderViewCell * mCell=(MineHeaderViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"MineHeaderViewCell" owner:self options:nil] lastObject];
        User *user = [UserDefaultsUtils getCurrentUser];
        NSLog(@"------------%@",user.name);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *name = [defaults stringForKey:kUserName];
        NSString *mobile = [defaults stringForKey:kMobile];
        [mCell.nameLabel setText:name];
        [mCell.phoneLabel setText:mobile];
//        if ([user.photo isEqualToString:@""]) {
//            mCell.avatarView.image = [UIImage imageNamed:@"comm_activate_portrait"];
////
//        }else{
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *ava = [defaults stringForKey:kUserPhoto];
            NSData *imageData = [[NSData alloc]initWithBase64EncodedString:ava options:NSDataBase64DecodingIgnoreUnknownCharacters];
//            UIImage *image = [UIImage imageWithData:imageData];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            NSString *ava = [defaults stringForKey:kUserPhoto];
//            NSData *imageData = [[NSData alloc] initWithBase64Encoding:ava];
            UIImage *image = [UIImage imageWithData:imageData];
            mCell.avatarView.image = image;
        mCell.avatarView.clipsToBounds = YES;
        mCell.avatarView.contentMode = UIViewContentModeScaleAspectFill;

//        }
        [mCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return mCell;
    }else if(indexPath.section == dataArray.count - 1){
        ExistViewCell *mCell = (ExistViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ExistViewCell" owner:self options:nil] lastObject];
        return mCell;
    }
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonalSettingViewController *psVc = [[PersonalSettingViewController alloc] init];
    switch (indexPath.section) {
        case 0:
            [self.navigationController pushViewController:psVc animated:YES];
            psVc.delegate = self;
            break;

        default:
            [self showQuitAlert];
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 86;
    }else{
        return 44;
    }
}
-(void)changeAvatar:(UIImage *)avatar{
//    NSData *imageData = [[NSData alloc] initWithBase64Encoding:avaStr];
//    
//    UIImage *newImage = [UIImage imageWithData:imageData];
//    MineHeaderViewCell *mCell=(MineHeaderViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"MineHeaderViewCell" owner:self options:nil] lastObject];
//    mCell.avatarView.image = avatar;
//    NSData *imgData = UIImageJPEGRepresentation(avatar, 1.0f);
//    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [self saveAvatar:encodedImageStr];
//    [self.tableView reloadData];
}
//- (void)tryUploadAvatar{
//    User *user = [UserDefaultsUtils getCurrentUser];
//    NSData *imgData = UIImageJPEGRepresentation(newAvatar, 1.0f);
//    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSLog(@"===Encoded image:\n%@", encodedImageStr);
//    //    PersonalTableViewCell *cell = [self.view viewWithTag:333];
////    NSDictionary *newAvaParameters = @{@"mobile":user.mobile,@"newPhoto":encodedImageStr};
//    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
//        NSDictionary *newAvaParameters = @{@"mobile":user.mobile,@"newPhoto":encodedImageStr};
//        [MBProgressHUD showMessage:@"正在保存信息..." toView:self.view];
//        [CSHttpClient tryRename:newAvaParameters success:^(id response) {
//            NSLog(@"reponse----------%@",response);
//            int status = [response intValue];
//            if (status == 1) {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
////                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////                [self saveAvatar:encodedImageStr];
//                //                NSLog(@"cell.contentLabel.text----------%@",cell.contentLabel.text);
//                
//                //                NSLog(@"user.name----------%@",user.name);
//                
////                [defaults synchronize];
//                //                User *user = [UserDefaultsUtils getCurrentUser];
//                //                NSLog(@"user.name----------%@",user.name);
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
//    }
//    
//}
-(void)saveAvatar:(NSString *)avatar {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:avatar forKey:kUserPhoto];
    [defaults synchronize];
}
@end
