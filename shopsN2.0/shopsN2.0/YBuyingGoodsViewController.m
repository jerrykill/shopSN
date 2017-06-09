//
//  YBuyingGoodsViewController.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingGoodsViewController.h"
#import "YBuyingGoodsCell.h"
#import "YAddBuyingGoodsViewController.h"
#import "YEditBuyingGoodsViewController.h"


@interface YBuyingGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) UIButton *totalBtn;

@end

@implementation YBuyingGoodsViewController

-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if (IsNilString(_orderId)) {
        [JKHttpRequestService GET:@"Pcenter/purchaseList" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
                if (succe) {
                    NSArray *data = jsonDic[@"data"];
                    if (data.count) {
                        strongSelf.dataArr = [YSParseTool getParsePurchase:data];
                        [strongSelf.delegate chooseGoodList:_dataArr];
                        [strongSelf.tableV reloadData];
                        [strongSelf clearTotal];
                    }
                }else{
                    [strongSelf.dataArr removeAllObjects];
                    [strongSelf.tableV reloadData];
                    [strongSelf clearTotal];
                }
            } failure:^(NSError *error) {
                
            } animated:YES];
    }else{
        [JKHttpRequestService GET:@"Pcenter/purchaseList" withParameters:@{@"purchase_id":_orderId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSArray *data = jsonDic[@"data"];
                if (data.count) {
                    strongSelf.dataArr = [YSParseTool getParsePurchase:data];
                    [strongSelf.delegate chooseGoodList:_dataArr];
                    [strongSelf.tableV reloadData];
                    [strongSelf clearTotal];
                }
            }else{
                [strongSelf.dataArr removeAllObjects];
                [strongSelf.tableV reloadData];
                [strongSelf clearTotal];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
    [self getdata];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"采购商品";
    [self initView];
    [self getdata];
    [self changeRightBtn];
    [self clearTotal];
}


-(void)changeRightBtn{
    self.rightBtn.frame = CGRectMake(__kWidth-70, 30, 60, 20);
    self.rightBtn.titleLabel.font = MFont(14);
    [self.rightBtn setImage:MImage(@"") forState:BtnNormal];
    [self.rightBtn setTitle:@"添加商品" forState:BtnNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    self.rightBtn.backgroundColor = [UIColor clearColor];
}


- (void)chooseRight{
    NSLog(@"添加商品");
    if (![_status isEqualToString:@"1"]&&!IsNilString(_status)) {
        [SXLoadingView showAlertHUD:@"已提交后不可编辑" duration:SXLoadingTime];
        return;
    }
    YAddBuyingGoodsViewController *vc = [[YAddBuyingGoodsViewController alloc]init];
    vc.purchaseId = _orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-45)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

    _totalBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 45)];
    [self.view addSubview:_totalBtn];
    _totalBtn.backgroundColor = __DefaultColor;
    _totalBtn.titleLabel.font = MFont(14);
    [_totalBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_totalBtn setTitle:@"总统计¥0.00" forState:BtnNormal];
}

#pragma mark ==UITableView==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YBuyingGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingGoodsCell"];
    if (!cell) {
        cell = [[YBuyingGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingGoodsCell"];
    }
    YBuyingGoodModel *model = _dataArr[indexPath.row];
    cell.count =model.goodCount;
    cell.money = model.goodMoney;
    cell.name = model.goodName;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![_status isEqualToString:@"1"]&&!IsNilString(_status)) {
        [SXLoadingView showAlertHUD:@"已提交后不可编辑" duration:SXLoadingTime];
        return;
    }
    YEditBuyingGoodsViewController *vc = [[YEditBuyingGoodsViewController alloc]init];
    YBuyingGoodModel *model = _dataArr[indexPath.row];
    vc.editId =model.goodID;
    vc.purchaseId = _orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clearTotal{
    __block CGFloat allMoney = 0.00;
    [_dataArr enumerateObjectsUsingBlock:^(YBuyingGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        allMoney+=[obj.goodMoney floatValue]*[obj.goodCount integerValue];
    }];
    if (allMoney>0) {
        [_totalBtn setTitle:[NSString stringWithFormat:@"总统计¥%.2f",allMoney] forState:BtnNormal];
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
