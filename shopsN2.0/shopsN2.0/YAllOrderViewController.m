//
//  YAllOrderViewController.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAllOrderViewController.h"
#import "YOrderTypeChooseView.h"
#import "YOrderOneCell.h"
#import "YOrderTwoCell.h"
#import "YOrderSectionHeadView.h"
#import "YOrderSectionFootView.h"
#import "YEvaluteOrderViewController.h"

#import "YOrderTypeTitleView.h"
#import "YGroupOrderTypeChooseView.h"
#import "YGroupOrderdetailViewController.h"
#import "YOrdersDetailViewController.h"
#import "YOrderSearchViewController.h"
#import "YSOrderModel.h"

@interface YAllOrderViewController ()<YOrderTypeChooseViewDelegate,UITableViewDelegate,UITableViewDataSource,YOrderSectionFootViewDelegate,YOrderTypeTitleViewDelegate,YGroupOrderTypeChooseViewDelegate,YOrderOneCellDelegate,YOrderTwoCellDelegate>

@property (strong,nonatomic) YOrderTypeChooseView *orderTypeV;

@property (strong,nonatomic) YGroupOrderTypeChooseView *groupTypeV;

@property (strong,nonatomic) UITableView *tableV;


@property (nonatomic) BOOL isGroup;

@property (assign,nonatomic) NSInteger  page;

@property (strong,nonatomic) NSString *status;

@property (strong,nonatomic) NSString *isComment;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YAllOrderViewController

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
            if (strongSelf.page==1) {
                 strongSelf.dataArr = [YSParseTool getParseOrders:data];
                 [strongSelf.tableV.footer endRefreshing];
            }else{
                NSMutableArray *list = [YSParseTool getParseOrders:data];
                [strongSelf.tableV.footer endRefreshing];
                [strongSelf.dataArr addObjectsFromArray:list];
            }
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.tableV.footer endRefreshing];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)getWaitEvalueData{
    WK(weakSelf)
    [JKHttpRequestService POST:@"Order/notEvaluate" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (strongSelf.page==1) {
                strongSelf.dataArr = [YSParseTool getParseOrders:data];
                [strongSelf.tableV.footer endRefreshing];
            }else{
                NSMutableArray *list = [YSParseTool getParseOrders:data];
                [strongSelf.tableV.footer endRefreshing];
                [strongSelf.dataArr addObjectsFromArray:list];
            }
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.tableV.footer endRefreshing];
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

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData:) name:@"OrderData" object:nil];
    [self getNavititle];
}

-(void)getNavititle{
    YOrderTypeTitleView *titleV = [[YOrderTypeTitleView alloc]initWithFrame:CGRectMake((__kWidth-172)/2, 26, 172*__kWidth/375, 31)];
    [self.headV addSubview:titleV];
    titleV.delegate = self;

    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-74, 30, 23, 24)];
    [self.headV addSubview:searchBtn];
    [searchBtn setImage:MImage(@"head_search") forState:BtnNormal];
    [searchBtn addTarget:self action:@selector(searchOrder) forControlEvents:BtnTouchUpInside];
}


-(void)initView{
    [self.view addSubview:self.orderTypeV];
    if (_selectIndex) {
        _orderTypeV.selectIndex = _selectIndex;
    }
    [self.view addSubview:self.groupTypeV];
    _groupTypeV.hidden = YES;
    _groupTypeV.countArr = @[@"10",@"5",@"5"];

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

-(YGroupOrderTypeChooseView *)groupTypeV{
    if (!_groupTypeV) {
        _groupTypeV = [[YGroupOrderTypeChooseView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 46)];
        _groupTypeV.delegate = self;
    }
    return _groupTypeV;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isGroup) {
        return 3;
    }
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (_isGroup) {
        YOrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrderTwoCell"];
        if (!cell) {
            cell = [[YOrderTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrderTwoCell"];
        }
        YSOrderModel *model =[[YSOrderModel alloc]init];
        model.title = @"齐心C330办公必备 透明按口袋A4 透明按口袋A4";
        NSMutableArray *type = [NSMutableArray array];
        YGoodTypeModel *size = [[YGoodTypeModel alloc]init];
        size.name = @"颜色";
        size.size = @"红";
        YGoodTypeModel *size1 = [[YGoodTypeModel alloc]init];
        size1.name = @"规格";
        size1.size = @"24";
        YGoodTypeModel *size2 = [[YGoodTypeModel alloc]init];
        size2.name = @"型号";
        size2.size = @"C0754-8";
        [type addObject:size];
        [type addObject:size1];
        [type addObject:size2];
        model.typeArr = type;
        model.payMoney = @"160.90";
        NSMutableArray *oma = [NSMutableArray array];
        for (int i=0; i<1000; i++) {
            [oma addObject:@""];
        }
        model.imageArr = oma;
        model.goodCount = @"1000";
        cell.model = model;
        cells = cell;
    }else{
        YSOrderModel *model = _dataArr[indexPath.section];
    if (model.imageArr.count==1) {
        YOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrderOneCell"];
        if (!cell) {
            cell = [[YOrderOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrderOneCell"];

        }
        cell.tag = indexPath.row;
        cell.delegate = self;
        cell.model = model;
        cells = cell;
    }else{
        YOrderTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrderTwoCell"];
        if (!cell) {
            cell = [[YOrderTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrderTwoCell"];
        }
        cell.tag = indexPath.row;
        cell.delegate = self;
        cell.model = model;
        cells = cell;
    }
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YOrderSectionHeadView *headV = [[YOrderSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 40)];
    if (_isGroup) {
        switch (section) {
            case 0:
            {
                 headV.typeLb.text = @"待兑换";
                 headV.typeLb.textColor = __DefaultColor;
            }
                break;
            case 1:
            {
                headV.typeLb.text = @"待兑换";
                headV.typeLb.textColor = __DefaultColor;
            }
                break;
            case 2:
            {
                headV.typeLb.text = @"已兑换";
                headV.typeLb.textColor = __DefaultColor;
            }
                break;
            default:
                break;
        }
    }else{
        YSOrderModel *model =_dataArr[section];
        switch ([model.orderStatus integerValue]) {
           case 0:
           {
              headV.typeLb.text = @"待付款";
              headV.typeLb.textColor = __DefaultColor;
           }
             break;
           case 1:
           case 2:
           {
             headV.typeLb.text = @"待处理";
             headV.typeLb.textColor = __DefaultColor;
           }
             break;
           case 3:
           {
             headV.typeLb.text = @"已发货";
             headV.typeLb.textColor = __DefaultColor;
            }
              break;
           case 4:
            {
                if ([model.comment isEqualToString:@"1"]) {
                    headV.typeLb.text = @"已完成";
                }else{
                    headV.typeLb.text = @"待评价";
                }
            }
              break;
           case -1:
           {
             headV.typeLb.text = @"已取消";
               
           }
             break;
           default:
             break;
    }
    }
    return headV;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    YOrderSectionFootView *footV = [[YOrderSectionFootView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 45)];
    footV.tag =section;
    footV.delegate = self;
    if (_isGroup) {
        footV.time = @"2015-07-20 13:16";
        footV.action = @"查看订单";
    }else{
        YSOrderModel *model =_dataArr[section];
        footV.time = model.createTime;
        switch ([model.orderStatus integerValue]) {
        case 0:
        {
            footV.action = @"马上付款";
        }
            break;
        case 1:
        case 2:
        {
            footV.action = @"查看订单";
        }
            break;
        case 3:
        {
            footV.action = @"查看物流";
        }
            break;
        case 4:
        {
            if ([model.comment isEqualToString:@"1"]) {
                footV.action = @"再次购买";
            }else{
            footV.action = @"马上评价";
            }
        }
            break;
        case -1:
        {
            footV.action = @"再次购买";
        }
            break;
        default:
            break;
    }
    }
    CGFloat sectionHeaderHeight = 40;
    CGFloat sectionFooterHeight = 45;
    CGFloat offsetY = tableView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableView.contentSize.height - tableView.frame.size.height - sectionFooterHeight)
    {
        tableView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableView.contentSize.height - tableView.frame.size.height - sectionFooterHeight && offsetY <= tableView.contentSize.height - tableView.frame.size.height)
    {
        tableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableView.contentSize.height - tableView.frame.size.height - sectionFooterHeight), 0);
    }
    return footV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}

#pragma mark ==YOrderSectionFootViewDelegate==
-(void)chooseAction:(NSInteger)sender index:(NSInteger)tag{
    YSOrderModel *model = _dataArr[tag];
    switch (sender) {
        case 0:
        {

            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"待付款";
            vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 1:
        {
            if (_isGroup) {
                NSLog(@"查看团购订单%ld",tag);
                YGroupOrderdetailViewController *vc = [[YGroupOrderdetailViewController alloc]init];
                if (tag==2) {
                    vc.status = @"已兑换";
                }else{
                    vc.status = @"待兑换";
                }
                [self.navigationController pushViewController:vc animated:YES];
            }else{
            NSLog(@"查看订单%ld",tag);
                YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
                vc.status = @"待处理";
                vc.orderId = model.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 2:
        {

            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"已发货";
             vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 3:
        {
            YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
            vc.status = @"待评价";
             vc.orderId = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 4:{
            if (tag==4) {
                YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
                vc.status = @"已取消";
                 vc.orderId = model.orderId;
                [self.navigationController pushViewController:vc animated:YES];

            }else{
                YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
                vc.status = @"已完成";
                 vc.orderId = model.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            }
            NSLog(@"再次购买%ld",tag);
        }
        default:
            break;
    }
}


#pragma mark ==YOrderTypeChooseViewDelegate==
-(void)chooseOrderHeadType:(NSInteger)type{
    NSLog(@"%ld",(long)type);
    if (type) {
        _isGroup = YES;
        _orderTypeV.hidden = YES;
        _groupTypeV.hidden = NO;
    }else{
        _isGroup = NO;
        _orderTypeV.hidden = NO;
        _groupTypeV.hidden = YES;
    }
   _tableV.contentOffset =CGPointMake(0, 0);
    [_tableV reloadData];
}
#pragma mark ==查找==
- (void)searchOrder{
    NSLog(@"查找订单");
    YOrderSearchViewController *vc = [[YOrderSearchViewController alloc]init];
    vc.isGroup = _isGroup;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ==YOrderTypeTitleViewDelegate==
-(void)chooseOrderType:(NSInteger)type{
    NSLog(@"%ld",(long)type);
    _tableV.contentOffset = CGPointMake(0, 0);
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
#pragma mark ==YGroupOrderTypeChooseViewDelegate==
-(void)chooseGroupOrderType:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            NSLog(@"全部");
        }
            break;
        case 1:
        {
            NSLog(@"待兑换");
        }
            break;
        case 2:
        {
            NSLog(@"已兑换");
        }
            break;
        default:
            break;
    }
}

#pragma mark ==YOrderOneCellDelegate==
- (void)makeOrderDelete:(NSInteger)sender{
    NSLog(@"删除：%ld",sender);
}

#pragma mark ==YOrderTwoCellDelegate==
- (void)makeTheOrderDeletes:(NSInteger)sender{
    NSLog(@"删除：%ld",sender);
}


//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 40;
    CGFloat sectionFooterHeight = 45;
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
    {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
    {
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
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
