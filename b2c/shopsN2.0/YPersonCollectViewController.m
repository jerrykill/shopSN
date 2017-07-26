//
//  YPersonCollectViewController.m
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonCollectViewController.h"
#import "YCollectHeadView.h"
#import "YGoodCell.h"
#import "YGoodsModel.h"
#import "YCollectSearchViewController.h"
#import "YGoodShareView.h"
#import "YSGoodDetailViewController.h"

@interface YPersonCollectViewController ()<UITableViewDelegate,UITableViewDataSource,YGoodCellDelegate,YCollectHeadViewDelegate,YGoodShareViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YCollectHeadView *collectHeadV;

@property (strong,nonatomic) NSMutableArray *listArr;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YGoodShareView *shareV;

@property (strong,nonatomic) YGoodsModel *shareModel;

@end

@implementation YPersonCollectViewController

#pragma mark ==选择类别==
-(void)chooseClass:(NSString *)classId{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Order/classGoods" withParameters:@{@"class_id":classId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            strongSelf.dataArr = [YSParseTool getParseGoods:jsonDic[@"data"]];
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.dataArr removeAllObjects];
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

#pragma mark ==获取数据==

-(void)getData{
    _dataArr = [NSMutableArray array];
//    for (int i=0; i<10; i++) {
//        YGoodsModel *model = [[YGoodsModel alloc]init];
//        model.goodTitle = @"各种一些了的得莫利测试数据标题";
//        model.goodMoney = @"299.00";
//        [_dataArr addObject:model];
//    }
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Order/myCollection" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = jsonDic[@"data"];
            strongSelf.dataArr = [YSParseTool getParseGoods:dic[@"goods"]];
            strongSelf.listArr = [YSParseTool getParseGoodCollectClass:dic[@"classname"]];
            [strongSelf.tableV reloadData];
            strongSelf.collectHeadV.dataArr = _listArr;
        }
    } failure:^(NSError *error) {
       
    } animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-74, 30, 23, 24)];
    [self.headV addSubview:searchBtn];
    [searchBtn setImage:MImage(@"head_search") forState:BtnNormal];
    [searchBtn addTarget:self action:@selector(searchOrder) forControlEvents:BtnTouchUpInside];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self getData];
         dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
         });
    });   
}


-(void)initView{
    [self.view addSubview:self.collectHeadV];

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_collectHeadV), __kWidth, __kHeight-64-47)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

}

#pragma mark ==懒加载==
-(YGoodShareView *)shareV{
    if (!_shareV) {
        _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        _shareV.delegate = self;
    }
    return _shareV;
}

-(YCollectHeadView *)collectHeadV{
    if (!_collectHeadV) {
        _collectHeadV = [[YCollectHeadView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 47)];
        _collectHeadV.delegate = self;
    }
    return _collectHeadV;
}


#pragma mark ==搜索==
- (void)searchOrder{
    NSLog(@"搜索");
    YCollectSearchViewController *vc = [[YCollectSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==UITableViewDelegate and Datasource==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGoodCell"];
    if (!cell) {
        cell = [[YGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGoodCell"];
    }
    cell.tag = indexPath.row;
    YGoodsModel *model = _dataArr[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 37)];
//    header.backgroundColor =__BackColor;
//    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(9, 13, __kWidth-40, 15)];
//    [header addSubview:titleLb];
//    titleLb.textAlignment = NSTextAlignmentLeft;
//    titleLb.textColor = LH_RGBCOLOR(102, 102, 102);
//    titleLb.font = MFont(13);
//    NSArray *titleArr = @[@"最近一个月收藏",@"三个月内收藏",@"三个月以前收藏"];
//    titleLb.text = titleArr[section];
//    return header;
//}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 37;
//}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    UITableViewRowAction *cancelAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"          " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [strongSelf.dataArr removeObjectAtIndex:indexPath.row];
        [strongSelf.tableV reloadData];
    }];
    cancelAction.backgroundColor = __DefaultColor;
    return @[cancelAction];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    YGoodsModel *model = _dataArr[indexPath.row];
    vc.goodsId = model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ==YCollectHeadViewDelegate==
-(void)getCollectType:(YGoodClassModel *)text{
    [self chooseClass:text.classID];
}


-(void)GoodListAction:(NSInteger)sender index:(NSInteger)tag{
    YGoodsModel *model = _dataArr[tag];
    _shareModel = model;
    switch (sender) {
        case 0:
        {
            [self.view addSubview:self.shareV];
            _shareV.goodID = model.goodId;
        }
            break;
        case 1:
        {
            NSLog(@"加入购物车");
            [YGoodCollectAndCartService MakeGoodShopCart:@{@"goods_id":_shareModel.goodId,@"goods_num":@"1",@"price_new":_shareModel.goodMoney,@"app_user_id":[UdStorage getObjectforKey:Userid]}];
        }
            break;
        case 2:
        {
            NSLog(@"找相似");
            YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
            vc.likeID = _shareModel.goodId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
}

#pragma mark ==YGoodShareViewDelegate==
-(void)shareType:(NSInteger)sender Url:(NSString *)goodID{
    NSLog(@"分享%ld",sender);
    [YShareTool shareMessage:@"商品信息" title:@"测试" Url:[NSString stringWithFormat:@"%@%@.html",ShareGoodRoot,goodID] type:sender];
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
