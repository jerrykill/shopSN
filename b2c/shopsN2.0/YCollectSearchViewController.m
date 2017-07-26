//
//  YCollectSearchViewController.m
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCollectSearchViewController.h"
#import "YSearchPushView.h"
#import "YGoodCell.h"
#import "YGoodShareView.h"
#import "YSGoodDetailViewController.h"

@interface YCollectSearchViewController ()<YSearchPushViewDelegate,UITableViewDelegate,UITableViewDataSource,YGoodCellDelegate,YGoodShareViewDelegate>

@property (strong,nonatomic) YSearchPushView *headerV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YGoodShareView *shareV;

@property (strong,nonatomic) YGoodsModel *shareModel;

@property (strong,nonatomic) NSString *keyWord;

@end

@implementation YCollectSearchViewController

- (void)getSearchData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Order/myCollection_search" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            strongSelf.dataArr = [YSParseTool getParseGoods:jsonDic[@"data"][@"goods"]];
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNavi];
    [self initView];
}

-(void)getNavi{
    [self.view addSubview:self.headerV];
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
-(YGoodShareView *)shareV{
    if (!_shareV) {
        _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        _shareV.delegate = self;
    }
    return _shareV;
}

-(YSearchPushView *)headerV{
    if (!_headerV) {
        _headerV = [[YSearchPushView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
        NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"请输入商品名称..."];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
        _headerV.searchTF.attributedPlaceholder = attr;
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
    [self.view endEditing:YES];
    _keyWord = text;
    [self getSearchData];

}
#pragma mark ==UITableViewDelegate and Datasource==
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
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
