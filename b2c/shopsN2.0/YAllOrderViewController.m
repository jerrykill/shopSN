//
//  YAllOrderViewController.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAllOrderViewController.h"
#import "YOrderTypeChooseView.h"
#import "YEvaluteOrderViewController.h"
#import "YSOrderGoodCell.h"
#import "YOrdersDetailViewController.h"
#import "YOrderSearchViewController.h"
#import "YSOrderModel.h"



@interface YAllOrderViewController ()<YOrderTypeChooseViewDelegate,UITableViewDelegate,UITableViewDataSource,YSOrderGoodCellDelegate>

@property (strong,nonatomic) YOrderTypeChooseView *orderTypeV;


@property (strong,nonatomic) UITableView *tableV;

@property (assign,nonatomic) NSInteger  page;//页面

@property (strong,nonatomic) NSString *status;//订单类型

@property (strong,nonatomic) NSString *isComment;//是否待评价

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YAllOrderViewController


#pragma mark ==获取数据==
- (void)loadMore{
    _page++;
    if (IsNilString(_isComment)) {
        [self getdata];
    }else{
        [self getWaitEvalueData];
    }
}

- (void)getdata{
    if (_selectIndex==4) {
        [self getWaitEvalueData];
        return;
    }
    WK(weakSelf)
    [JKHttpRequestService GET:@"order/myOrder" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"order_status":_status,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (!data.count) {
                [SXLoadingView showAlertHUD:@"暂无数据" duration:SXLoadingTime];
                [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
            }
            if (strongSelf.page==1) {
                 strongSelf.dataArr = [YSParseTool getParseOrders:data];
                 strongSelf.tableV.contentOffset = CGPointMake(0, 0);
            }else{
                NSMutableArray *list = [YSParseTool getParseOrders:data];
                [strongSelf.tableV.footer endRefreshing];
                if (!list.count) {
                    [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
                }
                [strongSelf.dataArr addObjectsFromArray:list];
            }
            [strongSelf.tableV reloadData];
        }else{
            if (strongSelf.page==1) {
                [strongSelf.dataArr removeAllObjects];
                [strongSelf.tableV reloadData];
            }
            [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)getWaitEvalueData{
    WK(weakSelf)
    [JKHttpRequestService GET:@"Order/notEvaluate" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (!data.count) {
                [SXLoadingView showAlertHUD:@"暂无数据" duration:SXLoadingTime];
            }
            if (strongSelf.page==1) {
                strongSelf.dataArr = [YSParseTool getParseOrders:data];
                 strongSelf.tableV.contentOffset = CGPointMake(0, 0);
            }else{
                NSMutableArray *list = [YSParseTool getParseOrders:data];
                [strongSelf.tableV.footer endRefreshing];
                if (!list.count) {
                    [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
                }
                [strongSelf.dataArr addObjectsFromArray:list];
            }
            [strongSelf.tableV reloadData];
        }else{
            if (strongSelf.page==1) {
                [strongSelf.dataArr removeAllObjects];
                [strongSelf.tableV reloadData];
            }
            [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

- (void)reloadData:(NSNotification*)info {
    _orderTypeV.selectIndex = _selectIndex;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _status =@"";
    _page = 1;
    _dataArr = [NSMutableArray array];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!_selectIndex) {
            [self getdata];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData:) name:YSOrderStatusChange object:nil];
    [self getNavititle];
}

-(void)getNavititle{
    self.title = @"全部订单";
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-74, 30, 23, 24)];
    [self.headV addSubview:searchBtn];
    [searchBtn setImage:MImage(@"head_search") forState:BtnNormal];
    [searchBtn addTarget:self action:@selector(searchOrder) forControlEvents:BtnTouchUpInside];
}

//返回
-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)initView{
    [self.view addSubview:self.orderTypeV];
    if (_selectIndex) {
        _orderTypeV.selectIndex = _selectIndex;
    }

    [self.view addSubview:self.tableV];

}
#pragma mark ==懒加载==
-(YOrderTypeChooseView *)orderTypeV{
    if (!_orderTypeV) {
        _orderTypeV = [[YOrderTypeChooseView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 46)];
        _orderTypeV.delegate = self;
    }
    return _orderTypeV;
}


-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, __kWidth, __kHeight-110)];
        _tableV.backgroundColor = __BackColor;
        _tableV.separatorColor = [UIColor clearColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [_tableV addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }
    return _tableV;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSOrderModel *model = _dataArr[indexPath.row];
    YSOrderGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSOrderGoodCell"];
    if (!cell) {
        cell = [[YSOrderGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSOrderGoodCell"];
    }
    cell.tag = indexPath.row;
    cell.model = model;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushOrderDetail:indexPath.row];
}

#pragma mark ==查找==
- (void)searchOrder{
    YOrderSearchViewController *vc = [[YOrderSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ==YOrderTypeChooseViewDelegate==
-(void)chooseOrderType:(NSInteger)type{
    _page = 1;
    _isComment = nil;
    switch (type) {
        case 0:{
            NSLog(@"全部");
            _status= @"";
            [self getdata];
        }
            break;
        case 1:
        {
            NSLog(@"待付款");
            _status = @"0";
            [self getdata];
        }
            break;
        case 2:
        {
            NSLog(@"待处理");
            _status = @"1";
            [self getdata];
        }
            break;
        case 3:
        {
            NSLog(@"待收货");
            _status = @"3";
            [self getdata];
        }
            break;
        case 4:
        {
            NSLog(@"待评价");
            _isComment= @"yes";
            [self getWaitEvalueData];
        }
            break;
        case 5:
        {
            NSLog(@"已取消");
            _status = @"-1";
            [self getdata];
        }
            break;
        case 6:
        {
            NSLog(@"已完成");
            _status = @"4";
            [self getdata];
        }

        default:
            break;
    }
}

#pragma mark ==YSOrderGoodCellDelegate==
- (void)chooseAction:(NSInteger)sender {
    [self pushOrderDetail:sender];
}

- (void)pushOrderDetail:(NSInteger)sender {
    YSOrderModel *model = _dataArr[sender];
    switch ([model.orderStatus integerValue]) {
        case 0:
        {
            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"待付款";
            vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        case 2:
        {
            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"待处理";
            vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"已发货";
            vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            if ([model.comment isEqualToString:@"1"]) {
                YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
                vc.status = @"已完成";
                vc.orderId = model.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
                vc.status = @"待评价";
                vc.orderId = model.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case -1:
        {
            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"已取消";
            vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }

}

- (void)orderDelete:(NSInteger)index {
    [self deleteOrders:[NSString stringWithFormat:@"%ld",index]];
}

#pragma mark ==删除订单==
- (void)deleteOrders:(NSString *)orderId {
    [JKHttpRequestService POST:@"Order/deleteOrder" withParameters:@{@"order_id":orderId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            if (_isComment) {
                [self getWaitEvalueData];
            }else{
                [self getdata];
            }
        }
    } failure:^(NSError *error) {

    } animated:YES];
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
