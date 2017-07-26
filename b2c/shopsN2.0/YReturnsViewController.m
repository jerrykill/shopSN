//
//  YReturnsViewController.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YReturnsViewController.h"
#import "YReturnsHeadView.h"
#import "YReturnsOrderCell.h"
#import "YApplyAfterSaleViewController.h"
#import "YQueryProgressViewController.h"

@interface YReturnsViewController ()<UITableViewDelegate,UITableViewDataSource,YReturnsOrderCellDelegate,YReturnsHeadViewDelegate>


@property (strong,nonatomic) YReturnsHeadView *returnHeadV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *type;

@end

@implementation YReturnsViewController

- (void)getSpeedData {
    [JKHttpRequestService POST:@"Pcenter/speed_check" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _dataArr = [YSParseTool getParseAfterSaleSpeedList:data];
            [self checkType];
            [_tableV reloadData];
        }else{
            [_dataArr removeAllObjects];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}

- (void)getData {
    [JKHttpRequestService POST:@"Pcenter/afetrsale_list" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _dataArr = [YSParseTool getParseAfterSaleApplyList:data];
            [self checkType];
            [_tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}


- (void)checkType {
    for (int i=0; i<_dataArr.count; i++) {
        YReturnsOrdersModel *model = _dataArr[i];
        NSMutableArray *change = [NSMutableArray array];
        for (YReturnsGoodModel *good in model.list) {
            good.status = _type;
            [change addObject:good];
        }
        model.list = change;
        [_dataArr replaceObjectAtIndex:i withObject:model];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"返修/退换";
    _type = @"0";
    [self getData];
    [self initView];
}

-(void)initView{
    _returnHeadV = [[YReturnsHeadView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 103)];
    [self.view addSubview:_returnHeadV];
    _returnHeadV.delegate =self;

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_returnHeadV), __kWidth, __kHeight-64-103)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YReturnsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YReturnsOrderCell"];
    if (!cell) {
        cell = [[YReturnsOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YReturnsOrderCell"];
    }
    cell.model =_dataArr[indexPath.row];
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YReturnsOrdersModel *model = _dataArr[indexPath.row];
    return 110*model.list.count+80;
}

#pragma mark ==YReturnsHeadViewDelegate==
-(void)chooseType:(NSInteger)sender{
    if (sender) {
        NSLog(@"进度查询");
        _type = @"1";
        [self getSpeedData];
    }else{
        NSLog(@"售后申请");
        _type = @"0";
        [self getData];
    }
}

-(void)searchDid:(NSString *)text{
    if (!IsNilString(text)) {
        [self getsearchData:text];
    }
}


#pragma mark ==YReturnsOrderCellDelegate==
-(void)chooseAction:(NSInteger)index tag:(NSInteger)sender{
    YReturnsOrdersModel *order = _dataArr[sender];
    YReturnsGoodModel *good = order.list[index];
    switch ([good.status integerValue]) {
        case 0:
        { NSLog(@"申请售后");
            YApplyAfterSaleViewController *vc = [[YApplyAfterSaleViewController alloc]init];
            YReturnsOrdersModel *model = [[YReturnsOrdersModel alloc]init];
            model.orderId = order.orderId;
            model.createDate = order.createDate;
            NSMutableArray *list = [NSMutableArray array];
            [list addObject:good];
            model.list = list;
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 1:
        {
            NSLog(@"待审核");
            YQueryProgressViewController *vc = [[YQueryProgressViewController alloc]init];
            vc.orderId = order.serviceId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


- (void)getsearchData:(NSString*)key {
    if ([_type isEqualToString:@"1"]) {
        [JKHttpRequestService POST:@"Pcenter/speed_checkSearch" withParameters:@{@"keyword":key,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSArray *data = jsonDic[@"data"];
                _dataArr = [YSParseTool getParseAfterSaleSpeedList:data];
                [self checkType];
                [_tableV reloadData];
            }else{
                [_dataArr removeAllObjects];
                [_tableV reloadData];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    }else{
        [JKHttpRequestService POST:@"Pcenter/afterSaleSearch" withParameters:@{@"keyword":key,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSArray *data = jsonDic[@"data"];
                _dataArr = [YSParseTool getParseAfterSaleApplyList:data];
                [self checkType];
                [_tableV reloadData];
            }else{
                [_dataArr removeAllObjects];
                [_tableV reloadData];
            }
        } failure:^(NSError *error) {

        } animated:YES];
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
