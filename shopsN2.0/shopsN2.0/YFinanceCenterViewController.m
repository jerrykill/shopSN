//
//  YFinanceCenterViewController.m
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFinanceCenterViewController.h"
#import "YMessageCell.h"

#import "YOtherOrdersViewController.h"
#import "YPersonBillViewController.h"
#import "YPersonPayMoneyViewController.h"
//#import "YPersonDeliveryViewController.h"
#import "YPersonDeliverysViewController.h"
#import "YAlreadyStatementViewController.h"
#import "YFutureStatementViewController.h"

@interface YFinanceCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *imageArr;

@property (strong,nonatomic) NSArray *titleArr;


@end

@implementation YFinanceCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"财务中心";
    _titleArr = @[@"其他订单",@"我的发票",@"我的付款",@"我的发货",@"已出对账单",@"未出对账单"];
    _imageArr = @[@"Finance_list01",@"Finance_list02",@"Finance_list03",@"Finance_list04",@"Finance_list05",@"Finance_list06"];
     [self initView];
}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, __kWidth, __kHeight-74)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

}
#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMessageCell"];
    if (!cell) {
        cell = [[YMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YMessageCell"];
    }
    cell.title = _titleArr[indexPath.row];
    cell.imageName = _imageArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row==0) {
         UIViewController *vc = [[YOtherOrdersViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        UIViewController *vc = [[YPersonBillViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        UIViewController *vc = [[YPersonPayMoneyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3){
        UIViewController *vc = [[YPersonDeliverysViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
        UIViewController *vc = [[YAlreadyStatementViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==5){
        UIViewController *vc = [[YFutureStatementViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
