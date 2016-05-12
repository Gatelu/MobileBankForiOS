//
//  AccountDetailsViewController.m
//  手机银行
//
//  Created by Gate on 16/1/8.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import "AccountDetailsTableViewCell.h"
#import "User.h"
#import "NSString+NSStringExt.h"
#import "AccountDetails.h"
@interface AccountDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int rowsNum;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *details;
@end

@implementation AccountDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    NSString *checkStr = @";";
    rowsNum = [_recordStr calculateSubStringCount:checkStr];
}
-(NSArray *)details{
    NSArray *strArray = [_recordStr componentsSeparatedByString:@";"];
//    NSLog(@"分割后的字符串-----%@------%lu----第一组是%@",strArray,(unsigned long)strArray.count,strArray[0]);
    //    AccountDetails.transferType = 0;
    NSString *separateStr = [[NSString alloc] init];
    NSArray *separateArray = [NSArray array];
    NSDictionary *dict = [NSDictionary dictionary];
    NSMutableArray *muArr = [NSMutableArray array];
    for (int i = 0; i < strArray.count - 1; i ++) {
        separateStr = strArray[i];
        //        NSLog(@"获得每组字符串%@",separateStr);
        separateArray = [separateStr componentsSeparatedByString:@","];
        dict = @{@"type":separateArray[0],@"amount":separateArray[1],@"mobile":separateArray[2]};
        [muArr addObject:dict];
//        NSLog(@"分开后是-----%@",dict);
    }

    if (_details == nil) {
        NSMutableArray *detailsArr = [NSMutableArray array];
        for (NSDictionary *dict in muArr) {
            AccountDetails *acDetail = [AccountDetails detailsWithDict:dict];
            [detailsArr addObject:acDetail];
        }
        _details = detailsArr;
    }
//    [self.tableView reloadData];
    return _details;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return rowsNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myCell = @"AccountDetailsTableViewCell";
    AccountDetailsTableViewCell *cell = (AccountDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myCell];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:myCell
                                              owner:self
                                            options:nil] lastObject];
    }
    AccountDetails *details = self.details[indexPath.row];
//    cell.transferType.text = details.transferType;
//    cell.transferAmount.text = details.transferAmount;
    NSString *transferDetails = [NSString new];
    if ([details.transferType isEqualToString:@"转入"]) {
        transferDetails = [NSString stringWithFormat:@"由%@账户转入%@元",details.mobile,details.transferAmount];
    }else{
        transferDetails = [NSString stringWithFormat:@"转出至%@账户%@元",details.mobile,details.transferAmount];
    }
    cell.transferMobile.text = transferDetails;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
@end
