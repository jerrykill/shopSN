//
//  YFeatureBusinessViewController.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFeatureBusinessViewController.h"
#import "YMessageCell.h"
#import "YGroupExchangeViewController.h"
#import "YBuyingLeadsViewController.h"
#import "YApplicationJoinViewController.h"
#import "YPrinterRentViewController.h"

@interface YFeatureBusinessViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *imageArr;

@property (strong,nonatomic) NSArray *titleArr;



@end

@implementation YFeatureBusinessViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"特色业务";
    _imageArr = @[@"business01",@"business02",@"business03",@"business04"];
    _titleArr = @[@"企业团购",@"采购需求单",@"加盟申请",@"打印机租贷"];
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, __kWidth, __kHeight-74)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
        YGroupExchangeViewController *vc = [[YGroupExchangeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        YBuyingLeadsViewController *vc = [[YBuyingLeadsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        YApplicationJoinViewController *vc = [[YApplicationJoinViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YPrinterRentViewController *vc = [[YPrinterRentViewController alloc]init];
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
