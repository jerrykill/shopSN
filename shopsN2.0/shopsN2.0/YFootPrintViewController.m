//
//  YFootPrintViewController.m
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFootPrintViewController.h"
#import "YGoodCell.h"
#import "YGoodShareView.h"
#import "YSGoodDetailViewController.h"


@interface YFootPrintViewController ()<UITableViewDelegate,UITableViewDataSource,YGoodCellDelegate,YGoodShareViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YGoodShareView *shareV;

@property (strong,nonatomic) YGoodsModel *shareModel;

@end

@implementation YFootPrintViewController


- (void)getData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/myFootprint" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *list = jsonDic[@"data"];
            if (list.count&&[list.firstObject isKindOfClass:[NSDictionary class]]) {
                strongSelf.dataArr = [YSParseTool getParseFooterGoods:jsonDic[@"data"]];
                [strongSelf.tableV reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    } animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的足迹";
    [self initView];
    [self getData];
    [self getNaviDel];
}

-(void)getNaviDel{
    UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-70, 31, 20, 20)];
    [self.headV addSubview:delBtn];
    [delBtn setImage:MImage(@"head_delete") forState:BtnNormal];
    [delBtn addTarget:self action:@selector(deleteAll) forControlEvents:BtnTouchUpInside];
}


-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

}
#pragma mark ==删除全部==
- (void)deleteAll{
    NSLog(@"删除全部");

}
#pragma mark ==懒加载==
-(YGoodShareView *)shareV{
    if (!_shareV) {
        _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        _shareV.delegate = self;
    }
    return _shareV;
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
//   titleLb.font = MFont(13);
//    titleLb.text = @"11月30日";
//    return header;
//}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 37;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    YGoodsModel *model = _dataArr[indexPath.row];
    vc.goodsId = model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YGoodCellDelegate==
-(void)GoodListAction:(NSInteger)sender index:(NSInteger)tag{
    YGoodsModel *model = _dataArr[tag];
    _shareModel = model;
    switch (sender) {
        case 0:
        {
            [self.view addSubview:self.shareV];
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
-(void)shareType:(NSInteger)sender{
    NSLog(@"分享%ld",sender);
    [YShareTool shareMessage:@"商品信息" title:@"测试" Url:@"https:www.baidu.com" type:sender];
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
