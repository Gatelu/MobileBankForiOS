//
//  TransferAccountsViewController.m
//  手机银行
//
//  Created by Gate on 16/1/5.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "TransferAccountsViewController.h"
#import "TransferMobileViewController.h"
#import "TransferCardViewController.h"
@interface TransferAccountsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TransferAccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账汇款";

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseIdentifier = @"TransferAccountsCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] init];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"epayment_other"];
        cell.textLabel.text = @"转账到手机银行";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.row == 1){
        cell.textLabel.text = @"转账到银行卡";
        cell.imageView.image = [UIImage imageNamed:@"epayment@3x"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        cell.textLabel.text = @"转账到钱宝账户";
        cell.imageView.image = [UIImage imageNamed:@"epayment@3x"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[TransferMobileViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 1){
        [self.navigationController pushViewController:[[TransferCardViewController alloc] init] animated:YES];
    }if (indexPath.row == 2){
        [self.navigationController pushViewController:[[TransferCardViewController alloc] init] animated:YES];
    }
}
@end
