//
//  YOrderSearchViewController.m
//  shopsN
//
//  Created by imac on 2016/12/26.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderSearchViewController.h"
#import "YSearchPushView.h"
#import "YSOrderGoodCell.h"

#import "YOrdersDetailViewController.h"
#import "YSOrderModel.h"


@interface YOrderSearchViewController ()<YSearchPushViewDelegate,UITableViewDelegate,UITableViewDataSource,YSOrderGoodCellDelegate>

@property (strong,nonatomic) YSearchPushView *headerV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *keyWord;

@end

@implementation YOrderSearchViewController

- (void)getdata {
    WK(weakSelf)
     __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Order/orderSearch" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"word":_keyWord} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (!data.count) {
                [SXLoadingView showAlertHUD:@"暂无数据" duration:SXLoadingTime];
            }
            strongSelf.dataArr = [YSParseTool getParseOrders:data];
            [strongSelf.tableV reloadData];

        }
    } failure:^(NSError *error) {

    } animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
    [_tableV reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNavi];
    [self initView];
}

-(void)getNavi{
    [self.view addSubview:self.headerV];
    NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"请输入商品名称..."];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
    _headerV.searchTF.attributedPlaceholder = attr;
}


-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==懒加载==
-(YSearchPushView *)headerV{
    if (!_headerV) {
        _headerV = [[YSearchPushView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
        _headerV.delegate = self;
    }
    return _headerV;
}



#pragma mark ==YSearchPushViewDelegate==
-(void)chooseBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchDid:(NSString *)text{
    NSLog(@"检索%@",text);
    _keyWord = text;
    [self.view endEditing:YES];
    [self getdata];
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
            [self getdata];
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
