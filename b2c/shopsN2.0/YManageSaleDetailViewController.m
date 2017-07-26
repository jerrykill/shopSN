
//
//  YManageSaleDetailViewController.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YManageSaleDetailViewController.h"
#import "YManageSaleDetailCell.h"
#import "YSalesManageModel.h"

@interface YManageSaleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic)  YSalesManageModel *model;

@property (strong,nonatomic) NSArray *titleArr;

@end

@implementation YManageSaleDetailViewController

-(void)getData{
   _model = [[YSalesManageModel alloc]init];
    _model.salesId = @"8300984254";
    _model.orderId = @"8300984254";
    _model.Type  = @"未收到货";
    _model.ask = @"要求退款";
    _model.status = @"未发货";
    _model.info = @"确认下单了20天还没收到货。确认下单了20天还没收到货。确认下单了20天还没收到货。确认下单了20天还没收到货。确认下单了20天还没收到货。";
    _model.applyTime =@"2016-12-09 10:52:36";
    _model.cancelTime = @"2016-12-12 10:52:36";
    _model.money = @"30.50";

    _titleArr = @[@"售后编号：",@"订单编号：",@"售后类型：",@"售后要求：",@"货物状态：",@"问题描述：",@"申请时间：",@"撤销时间：",@"退款金额："];

    [JKHttpRequestService POST:@"Pcenter/customerServiceList" withParameters:@{@"id":_salesId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            _model = [YSParseTool getParseAfterSaleManageDetail:data];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"售后管理详情";
    [self getData];
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YManageSaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YManageSaleDetailCell"];
    if (!cell) {
        cell = [[YManageSaleDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YManageSaleDetailCell"];
    }
    cell.title = _titleArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            cell.detail = _model.salesId;
        }
            break;
        case 1:
        {
            cell.detail = _model.orderId;
        }
            break;
        case 2:
        {
            cell.detail = _model.type;
            cell.index = @"类型";
        }
            break;
        case 3:
        {
            cell.detail = _model.ask;
            cell.index = @"要求";
        }
            break;
        case 4:
        {
            cell.detail = _model.status;
            cell.index = @"状态";
        }
            break;
        case 5:
        {
            cell.detail = _model.info;
            cell.color = @"1";
        }
            break;
        case 6:
        {
            cell.detail = _model.applyTime;
            cell.color = @"2";
        }
            break;
        case 7:
        {
            cell.detail = _model.cancelTime;
            cell.color = @"2";
        }
            break;
        case 8:
        {
            cell.detail = [NSString stringWithFormat:@"%@元",_model.money];
            cell.color = @"1";
        }
            break;
        default:
            break;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==5) {
        NSString  *str = _model.info;
        CGSize size =[str boundingRectWithSize:CGSizeMake(__kWidth-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
        return size.height+26;
    }else{
        return 41;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
