//
//  YBuyingLeadsViewController.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingLeadsViewController.h"
#import "YAllTypesChooseView.h"
#import "YBuyingLeadsCell.h"
#import "YBuyingLeadsOrderViewController.h"
#import "YSearchBuyingLeadsViewController.h"
#import "YBuyingLeadsModel.h"

@interface YBuyingLeadsViewController ()<YAllTypesChooseViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic) YAllTypesChooseView *orderTypeV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *imageArr;

@property (strong,nonatomic) NSArray *typeArr;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (assign,nonatomic) NSInteger page;

@property (strong,nonatomic) NSString *type;

@end

@implementation YBuyingLeadsViewController

-(void)loadMore{
    _page++;
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/myPurchaseOrder" withParameters:@{@"type":_type,@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (data.count) {
                NSMutableArray *list = [YSParseTool getParseMyPurchase:data];
                [strongSelf.dataArr addObjectsFromArray:list];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV footerEndRefreshing];
            }else{
                [strongSelf.tableV.footer setHidden:YES];
            }

        }else{
            [strongSelf.tableV.footer setHidden:YES];
        }
    } failure:^(NSError *error) {
    } animated:YES];
}

-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/myPurchaseOrder" withParameters:@{@"type":_type,@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (data.count) {
                strongSelf.dataArr = [YSParseTool getParseMyPurchase:data];
                [strongSelf.tableV reloadData];
                if (strongSelf.dataArr.count<10) {
                    [strongSelf.tableV.footer setStateHidden:YES];
                }else{
                   [strongSelf.tableV.footer endRefreshing];
                }
            }else{
            }
        }else{
            [strongSelf.dataArr removeAllObjects];
            [strongSelf.tableV reloadData];
            [strongSelf.tableV.footer endRefreshing];
            [strongSelf.tableV.footer setHidden:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
    [self getdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _type=@"";
    _page= 1;
    self.title = @"我的采购需求";
    [self getNavis];
    [self initView];
    [self getdata];
}

- (void)getNavis{
    _typeArr = @[@"未提交",@"已提交",@"已反馈",@"已取消",@"已关闭"];
    _imageArr = @[@"fettle_bg_01",@"fettle_bg_02",@"fettle_bg_03",@"fettle_bg_04",@"fettle_bg_05"];
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-74, 30, 23, 24)];
    [self.headV addSubview:searchBtn];
    [searchBtn setImage:MImage(@"head_search") forState:BtnNormal];
    [searchBtn addTarget:self action:@selector(searchOrder) forControlEvents:BtnTouchUpInside];
}

-(void)initView{
    _orderTypeV = [[YAllTypesChooseView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 48)];
    [self.view addSubview:_orderTypeV];
    _orderTypeV.typeArr = @[@"全部",@"未提交",@"已提交",@"已反馈",@"已取消",@"已关闭"];
    _orderTypeV.delegate = self;

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 112, __kWidth, __kHeight-112-45)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [_tableV addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

    UIButton *putBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV), __kWidth-20, 44)];
    [self.view addSubview:putBtn];
    putBtn.layer.cornerRadius = 5;
    putBtn.backgroundColor = __DefaultColor;
    [putBtn setTitle:@"提采购需求" forState:BtnNormal];
    [putBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [putBtn addTarget:self action:@selector(putNeed) forControlEvents:BtnTouchUpInside];

}


#pragma mark ==提需求==
-(void)putNeed{
    NSLog(@"提需求");
    YBuyingLeadsOrderViewController *vc = [[YBuyingLeadsOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ==查找需求==
-(void)searchOrder{
    NSLog(@"查找需求单");
    YSearchBuyingLeadsViewController *vc = [[YSearchBuyingLeadsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YBuyingLeadsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingLeadsCell"];
    if (!cell) {
        cell = [[YBuyingLeadsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingLeadsCell"];
    }
    YBuyingLeadsModel *model = _dataArr[indexPath.row];
    cell.imageName = _imageArr[[model.status integerValue]-1];
    cell.type = _typeArr[[model.status integerValue]-1];
    cell.title = model.title;
    cell.time = model.creatTime;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    YBuyingLeadsOrderViewController *vc = [[YBuyingLeadsOrderViewController alloc]init];
    YBuyingLeadsModel *model = _dataArr[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ==YAllTypesChooseViewDelegate==
-(void)chooseOrderType:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            NSLog(@"全部");
            _type= @"";
        }
            break;
        case 1:
        {
            NSLog(@"未提交");
            _type = @"1";
        }
            break;
        case 2:
        {
            NSLog(@"已提交");
            _type = @"2";
        }
            break;
        case 3:
        {
            NSLog(@"已反馈");
            _type = @"3";
        }
            break;

        case 4:
        {
            NSLog(@"已取消");
            _type = @"4";
        }
            break;
        case 5:
        {
            NSLog(@"已关闭");
            _type = @"5";
        }
            break;
        default:
            break;
    }
    _page = 1;
    [self getdata];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
