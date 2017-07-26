

//
//  YOrderGoodListViewController.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderGoodListViewController.h"
#import "YOrderGoodListCell.h"


@interface YOrderGoodListViewController ()<UITableViewDelegate,UITableViewDataSource,YOrderGoodListCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) UILabel *numLb;


@property (strong,nonatomic) NSString *freight;//运费

@end

@implementation YOrderGoodListViewController

#pragma mark ==修改数量==
-(void)changeOrderGoodNum:(YShopGoodModel*)model moreOrLess:(BOOL)sender{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if (IsNilString(model.shopCartId)) {
        model.shopCartId = @"";
    }
    [JKHttpRequestService POST:@"Order/orderGoodsNumChange" withParameters:@{@"cart_id":model.shopCartId,@"type":sender?@"2":@"1",@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            strongSelf.freight= [NSString stringWithFormat:@"%.2f",[jsonDic[@"data"] floatValue]];
            [strongSelf.delegate orderListFreight:_freight];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


-(void)getdata{

    __block NSInteger count = 0;
    [_datas enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count +=[obj.goodCount integerValue];
    }];
    _numLb.text = [NSString stringWithFormat:@"共%ld件",count];
    [_tableV reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品清单";
    self.rightBtn.hidden = YES;
    [self getRight];
    [self initView];
    [self getdata];
}

-(void)getRight{
    _numLb= [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-50, 35, 45, 15)];
    [self.headV addSubview:_numLb];
    _numLb.textColor = [UIColor whiteColor];
    _numLb.font = MFont(14);
    _numLb.textAlignment = NSTextAlignmentLeft;

}


-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YOrderGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YOrderGoodListCell"];
    if (!cell) {
        cell = [[YOrderGoodListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YOrderGoodListCell"];
    }
    YShopGoodModel *model = _datas[indexPath.row];
    cell.tag = indexPath.row;
    cell.delegate = self;
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


#pragma mark ==YOrderGoodListCellDelegate==
-(void)changeGoodCount:(BOOL)sender index:(NSInteger)tag{
    YShopGoodModel *model = _datas[tag];
    NSInteger num = [model.goodCount integerValue];
    if (sender) {
        num ++;
        [self changeOrderGoodNum:model moreOrLess:YES];
    }else{
        num --;
        [self changeOrderGoodNum:model moreOrLess:NO];
    }
    model.goodCount = [NSString stringWithFormat:@"%ld",num];
    [_datas replaceObjectAtIndex:tag withObject:model];
    __block NSInteger count = 0;
    [_datas enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count +=[obj.goodCount integerValue];
    }];
    _numLb.text = [NSString stringWithFormat:@"共%ld件",count];

    [[NSNotificationCenter defaultCenter] postNotificationName:YSOrdersGoodChange object:_datas userInfo:nil];
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
