//
//  YShopCarViewController.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopCarViewController.h"
#import "YShopCartClearView.h"
#import "YShopCartHeadView.h"
#import "YShopGoodsCell.h"
#import "YGoodShopOneCell.h"
#import "YShopLikeHeadView.h"
#import "YGoodLikeCell.h"
#import "YGoodShopModel.h"
#import "YShopGoodColorAndWayCheckView.h"
#import "YGoodDetailModel.h"
#import "YShopCartTotalModel.h"
#import "YShopCartEditView.h"

#import "YShopNullView.h"
#import "YGoodShareView.h"

#import "YSystemNewsViewController.h"
#import "YSGoodDetailViewController.h"
#import "YSureOrderViewController.h"


@interface YShopCarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YShopCartClearViewDelegate,YShopCartHeadViewDelegate,YShopGoodsCellDelegate,YGoodShopOneCellDelegate,YShopGoodColorAndWayCheckViewDelegate,YShopCartEditViewDelegate,YShopNullViewDelegate,YGoodShareViewDelegate>

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) YShopCartClearView *clearV;

@property (strong,nonatomic) YShopCartEditView *editV;

@property (strong,nonatomic) YGoodShopModel *shopModel;

@property (strong,nonatomic) YShopGoodColorAndWayCheckView *shopCheckV;

@property (strong,nonatomic) YShopCartTotalModel *totalModel;

@property (strong,nonatomic) YShopNullView *backV;

@property (strong,nonatomic) YGoodShareView *shareV;

@property (strong,nonatomic) NSMutableArray<YGoodSizeModel*> *typeArr;

@property (strong,nonatomic) NSMutableArray<YSGoodTypeEditModel*> *goodList;

@property (strong,nonatomic) YGoodDetailModel *checkModel;

@property (strong,nonatomic) NSMutableArray<YShopGoodModel *> *chooseArr;

@property (strong,nonatomic) NSMutableArray *recommondArr;

@end

@implementation YShopCarViewController

#pragma mark ==提交编辑==
-(void)putChooseEdit:(NSString*)cart good:(NSString*)sender{
    [JKHttpRequestService POST:@"Cart/editCart" withParameters:@{@"cart_id":cart,@"goods_id":sender,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [self getdata];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

#pragma mark ==编辑==
-(void)chooseGoodEdit:(NSString*)sender{
    _typeArr = [NSMutableArray array];
    _goodList = [NSMutableArray array];
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Cart/getChildren" withParameters:@{@"id":sender,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = jsonDic[@"data"];
            strongSelf.typeArr = [YSParseTool getParseGoodCheck:dic[@"spec"]];
            strongSelf.goodList = [YSParseTool getParseChooseGood:dic[@"childrenGoods"]];
            strongSelf.checkModel.goodSize = _typeArr;
            strongSelf.shopCheckV.model = _checkModel;
            strongSelf.shopCheckV.goodList = _goodList;
            strongSelf.shopCheckV.hidden = NO;
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

#pragma mark ==删除商品==
-(void)shaopcartDelete:(NSString*)goodId{
    [JKHttpRequestService POST:@"Cart/delete" withParameters:@{@"id":goodId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [self getdata];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

#pragma mark ==数量改变==
- (void)changeShopCart:(NSString*)goodId sender:(NSString*)sender tag:(NSString*)tag{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Cart/addReduce" withParameters:@{@"type":sender,@"id":goodId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [strongSelf getdata];
        }else{
            NSInteger i = [tag integerValue];
            YShopGoodModel *model =weakSelf.shopModel.dataArr[i];
            NSInteger num = [model.goodCount integerValue];
            if ([sender integerValue]>1) {
                num++;
            }else{
                num--;
            }
            model.goodCount = [NSString stringWithFormat:@"%ld",num];
            [strongSelf.shopModel.dataArr replaceObjectAtIndex:[tag integerValue] withObject:model];
            [strongSelf.mainV reloadData];
            [strongSelf clearTotal];
        }
    } failure:^(NSError *error) {
        NSInteger i = [tag integerValue];
        YShopGoodModel *model =_shopModel.dataArr[i];
        NSInteger num = [model.goodCount integerValue];
        if ([sender integerValue]>1) {
            num++;
        }else{
            num--;
        }
        model.goodCount = [NSString stringWithFormat:@"%ld",num];
        [weakSelf.shopModel.dataArr replaceObjectAtIndex:[tag integerValue] withObject:model];
        [weakSelf.mainV reloadData];
        [weakSelf clearTotal];
    } animated:NO];
}

#pragma mark ==获取数据==
-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Cart/myCart" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            if (jsonDic[@"data"]) {
                strongSelf.shopModel.dataArr = [YSParseTool getParseShopCart:jsonDic[@"data"]];
                if (strongSelf.shopModel.dataArr.count) {
                    if (strongSelf.shopModel.isAllChoose) {
                        for (int i=0; i<strongSelf.shopModel.dataArr.count ; i++) {
                            YShopGoodModel *model =_shopModel.dataArr[i];
                            model.isChoose = YES;
                        }
                    }
                    strongSelf.mainV.hidden = NO ;
                    [strongSelf.mainV reloadData];
                    [strongSelf clearTotal];
                    [weakSelf.mainV.header endRefreshing];
                }else{
                    strongSelf.mainV.hidden =YES;
                    strongSelf.clearV.hidden = NO;
                }

            }
        }else{
            strongSelf.mainV.hidden =YES;
            strongSelf.clearV.hidden = NO;
        }
    } failure:^(NSError *error) {
       
    } animated:NO];


}

-(void)getRecommond{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Cart/cart_recommend" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.recommondArr = [YSParseTool getParseGoodLoves:data];
            [strongSelf.mainV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.LeftBtn.hidden = YES;
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getdata) name:YSGoodAddtoShopCart object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.LeftBtn.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    _totalModel = [[YShopCartTotalModel alloc]init];
    _totalModel.totalMoney= @"0.00";
    _totalModel.CouponMoney = @"0.00";
    _totalModel.chooseCount = @"0";

    _shopModel = [[YGoodShopModel alloc]init];
    _shopModel.isEdit = NO;
    _shopModel.isAllChoose = NO;

    _checkModel = [[YGoodDetailModel alloc]init];
    self.title = @"我的购物车";
    [self.rightBtn setImage:MImage(@"head_news") forState:BtnNormal];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        [self getRecommond];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });
    _chooseArr = [NSMutableArray array];
}



-(void)initView{
    [self.view addSubview:self.backV];
    [self.view sendSubviewToBack:self.backV];

    [self.view addSubview:self.mainV];
    //section 0
    [_mainV registerClass:[YShopGoodsCell class]
            forCellWithReuseIdentifier:@"YShopGoodsCell"];
    [_mainV registerClass:[YGoodShopOneCell class]
            forCellWithReuseIdentifier:@"YGoodShopOneCell"];
    [_mainV registerClass:[YShopCartHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:@"YShopCartHeadView"];
    //section 1
    [_mainV registerClass:[YGoodLikeCell class]
            forCellWithReuseIdentifier:@"YGoodLikeCell"];
    [_mainV registerClass:[YShopLikeHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:@"YShopLikeHeadView"];

    [self.view addSubview:self.clearV];

    _mainV.hidden = YES;
    _clearV.hidden = NO;
    [self.view addSubview:self.editV];
    WK(weakSelf)
    [_mainV addLegendHeaderWithRefreshingBlock:^{
        [weakSelf getdata];
        [weakSelf getRecommond];

    }];

}
#pragma mark ==懒加载==
-(YShopNullView *)backV{
    if (!_backV) {
        _backV = [[YShopNullView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
        _backV.delegate = self;
    }
    return _backV;
}

-(UICollectionView *)mainV{
    if (!_mainV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50-50) collectionViewLayout:flowLayout];
        _mainV.delegate = self;
        _mainV.dataSource = self;
        _mainV.backgroundColor = __BackColor;
    }
    return _mainV;
}

-(YShopCartClearView *)clearV{
    if (!_clearV) {
        _clearV = [[YShopCartClearView alloc]initWithFrame:CGRectMake(0, CGRectYH(_mainV), __kWidth, 50)];
        _clearV.delegate = self;
    }
    return _clearV;
}

-(YShopCartEditView *)editV{
    if (!_editV) {
        _editV = [[YShopCartEditView alloc]initWithFrame:CGRectMake(0, CGRectYH(_mainV), __kWidth, 50)];
        _editV.delegate= self;
        _editV.hidden = YES;
    }
    return _editV;
}

#pragma mark ==YShopNullViewDelegate==
-(void)goBuying{
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.selectIndex = 0;
}


- (void)chooseRight{
    NSLog(@"查看消息");
    YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YShopCartClearViewDelegate==
-(void)clear{
    NSLog(@"结算");
    if (!_chooseArr.count) {
        [SXLoadingView showAlertHUD:@"请选择结算商品" duration:SXLoadingTime];
        return;
    }
    NSMutableArray *goods = [NSMutableArray array];
    for (YShopGoodModel *model in _chooseArr) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:model.goodId forKey:@"id"];
        [dic setValue:model.goodCount forKey:@"num"];
        [goods addObject:dic];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    [JKHttpRequestService POST:@"Order/goBuy" withParameters:@{@"goods":jsonStr,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe){
            NSDictionary *dics = jsonDic[@"data"];
            YSureOrderViewController *vc = [[YSureOrderViewController alloc]init];
            vc.datas = _chooseArr;
            vc.totalPay = dics[@"total_price"];
            NSArray *adds = @[dics[@"address"]];
            vc.address = [YSParseTool getParseAddress:adds].firstObject;
            vc.freight = [NSString stringWithFormat:@"%@",dics[@"freight"]];
            vc.personIntegral = dics[@"integral"];
            vc.buyType = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}
#pragma mark ==YShopCartEditViewDelegate==
-(void)sureCollect{
    NSLog(@"收藏");
    __block NSMutableArray *collect=[NSMutableArray array];
    [_shopModel.dataArr enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChoose) {
            [collect addObject:obj.goodId];
        }
    }];
    NSData *data = [NSJSONSerialization dataWithJSONObject:collect options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
    NSDictionary *params = @{@"goods_id":jsonStr,@"app_user_id":[UdStorage getObjectforKey:Userid]};
    [JKHttpRequestService POST:@"Cart/muchCollection" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"加入收藏成功" duration:SXLoadingTime];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

-(void)sureShare{
    NSLog(@"分享");
    if (_chooseArr.count) {
    _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:_shareV];
    _shareV.delegate = self;
    YShopGoodModel *model = _chooseArr.lastObject;
    _shareV.goodID =model.goodId;
    }else{
        [SXLoadingView showAlertHUD:@"请选择分享的商品" duration:SXLoadingTime];
    }
}

-(void)SureCancel:(BOOL)sender{
    if (sender) {
        _shopModel.isAllChoose = YES;
        for (int i=0; i<_shopModel.dataArr.count ; i++) {
            YShopGoodModel *model =_shopModel.dataArr[i];
            model.isChoose = YES;
            [_shopModel.dataArr replaceObjectAtIndex:i withObject:model];
        }
    }else{
        _shopModel.isAllChoose = NO;
        for (int i=0; i<_shopModel.dataArr.count ; i++) {
            YShopGoodModel *model =_shopModel.dataArr[i];
            model.isChoose = NO;
            [_shopModel.dataArr replaceObjectAtIndex:i withObject:model];
        }
    }
    [self clearTotal];
    [_mainV reloadData];
}


#pragma mark ==UICollectionViewDelegate==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section ==0) {
        return _shopModel.dataArr.count;
    }else{
        return _recommondArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cells = nil;
    if (indexPath.section == 0) {
        if (_shopModel.isEdit) {
            YGoodShopOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodShopOneCell"
                                          forIndexPath:indexPath];
            if (!cell) {
                cell = [[YGoodShopOneCell alloc]init];
            }
            YShopGoodModel *model = _shopModel.dataArr[indexPath.row];
            cell.tag =indexPath.row;
            cell.model = model;
            cell.delegate = self;
            cells = cell;
        }else{
            YShopGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YShopGoodsCell"
                                          forIndexPath:indexPath];
            if (!cell) {
                cell = [[YShopGoodsCell alloc]init];
            }
            YShopGoodModel *model = _shopModel.dataArr[indexPath.row];
            cell.tag =indexPath.row;
            cell.model = model;
            cell.delegate = self;
            cells = cell;
        }
    }else{
        YGoodLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodLikeCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodLikeCell alloc]init];
        }
        YGoodsModel *model = _recommondArr[indexPath.row];
        cell.dataModel = model;
        cells = cell;
    }
    return cells;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV = nil;
    if (indexPath.section ==0) {
        YShopCartHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YShopCartHeadView" forIndexPath:indexPath];
        if (!header) {
            header = [[YShopCartHeadView alloc]init];
        }
        header.allChoose = _shopModel.isAllChoose;
        header.delegate = self;
        reuseV = header;
    }else{
        YShopLikeHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YShopLikeHeadView" forIndexPath:indexPath];
        if (!header) {
            header = [[YShopLikeHeadView alloc]init];
        }
        reuseV = header;
    }
    return reuseV;
}
//内容距离屏幕边缘的距离 参数顺序是top,left,bottom,right
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}
//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 4;
    }
    return 0;
}
//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 4;
    }
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(__kWidth, 100);
    }else{
        return CGSizeMake((__kWidth-4)/2, 248);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(__kWidth, 45);
    }else{
        if (_recommondArr.count) {
            return CGSizeMake(__kWidth, 40);
        }else{
            return CGSizeZero;
        }
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        NSLog(@"喜欢%ld",indexPath.row);
        YGoodsModel *model = _recommondArr[indexPath.row];
        YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
        vc.goodsId = model.goodId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (_shopModel.isEdit) {
            NSLog(@"编辑%ld",indexPath.row);
        }else{
            YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
            YShopGoodModel *model = _shopModel.dataArr[indexPath.row];
            vc.goodsId = model.goodId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }


}

#pragma mark ==YShopCartHeadViewDelegate==
-(void)AllEdit:(BOOL)sender{
    if (sender) {
        _shopModel.isEdit =YES;
        _clearV.hidden = YES;
        _editV.hidden = NO;
    }else{
        _shopModel.isEdit = NO;
        _clearV.hidden = NO;
        _editV.hidden = YES;
    }

    [_mainV reloadData];
}

-(void)chooseAll:(BOOL)sender{
    if (sender) {
        _shopModel.isAllChoose = YES;
        _editV.allChoose = YES;
        for (int i=0; i<_shopModel.dataArr.count ; i++) {
            YShopGoodModel *model =_shopModel.dataArr[i];
            model.isChoose = YES;
            [_shopModel.dataArr replaceObjectAtIndex:i withObject:model];
        }
    }else{
        _shopModel.isAllChoose = NO;
        _editV.allChoose = NO;
        for (int i=0; i<_shopModel.dataArr.count ; i++) {
            YShopGoodModel *model =_shopModel.dataArr[i];
            model.isChoose = NO;
            [_shopModel.dataArr replaceObjectAtIndex:i withObject:model];
        }
    }
     [self clearTotal];
    [_mainV reloadData];
}
#pragma mark ==YShopGoodsCellDelegate==
-(void)choose:(BOOL)sender index:(NSInteger)tag{
    YShopGoodModel *model =_shopModel.dataArr[tag];
    model.isChoose = sender;
    [_shopModel.dataArr replaceObjectAtIndex:tag withObject:model];
    __block BOOL all = YES;
    [_shopModel.dataArr enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.isChoose) {
            all=NO;
        }
    }];
    _shopModel.isAllChoose = all;
    _editV.allChoose = all;
    [_mainV reloadData];
   [self clearTotal];
}

#pragma mark ==YGoodShopOneCellDelegate==
-(void)chooses:(BOOL)sender index:(NSInteger)tag{
    YShopGoodModel *model =_shopModel.dataArr[tag];
    model.isChoose = sender;
    [_shopModel.dataArr replaceObjectAtIndex:tag withObject:model];
    __block BOOL all = YES;
    [_shopModel.dataArr enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.isChoose) {
            all=NO;
        }
    }];
    _shopModel.isAllChoose = all;
    _editV.allChoose = all;
    [_mainV reloadData];
    [self clearTotal];
}
#pragma mark ==修改数量==
-(void)countChange:(BOOL)sender index:(NSInteger)tag{
    YShopGoodModel *model =_shopModel.dataArr[tag];
    NSInteger num = [model.goodCount integerValue];
    if (sender) {
        num++;
        [self changeShopCart:model.shopCartId sender:@"1" tag:[NSString stringWithFormat:@"%ld",tag]];
    }else{
        if (num>1) {
            num--;
            [self changeShopCart:model.shopCartId sender:@"2" tag:[NSString stringWithFormat:@"%ld",tag]];
        }
    }
    model.goodCount = [NSString stringWithFormat:@"%ld",num];
    [_shopModel.dataArr replaceObjectAtIndex:tag withObject:model];
    [_mainV reloadData];
    [self clearTotal];
}
#pragma mark ==删除==
- (void)deleteIndex:(NSInteger)tag{
    YShopGoodModel *model = _shopModel.dataArr[tag];
    [self shaopcartDelete:model.shopCartId];
//    [_shopModel.dataArr removeObjectAtIndex:tag];
    [_mainV reloadData];
   [self clearTotal];
}

#pragma mark ==编辑==
-(void)chooseEdit:(NSInteger)tag{
    YShopGoodModel *models =_shopModel.dataArr[tag];
    [self chooseGoodEdit:models.shopCartId];
    _checkModel.goodTitle = models.goodTitle;
    _checkModel.goodUrl = models.goodUrl;
    _checkModel.goodMoney = models.goodMoney;
    _checkModel.goodId = models.shopCartId;

    _shopCheckV = [[YShopGoodColorAndWayCheckView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:_shopCheckV];
    _shopCheckV.tag = tag;
    _shopCheckV.checkModel = models;
    _shopCheckV.delegate = self;
    _shopCheckV.hidden = YES;


}

#pragma mark ==YShopGoodColorAndWayCheckViewDelegate==
-(void)changeModel:(YShopGoodModel *)model index:(NSInteger)tag{
    YShopGoodModel *models =_shopModel.dataArr[tag];
    [self putChooseEdit:models.shopCartId good:model.goodId];
//    if (model.goodTypeArr.count) {
//        models.goodTypeArr= model.goodTypeArr;
//        [_shopModel.dataArr replaceObjectAtIndex:tag withObject:models];
//        [_mainV reloadData];
//    }

}
#pragma mark ==计算总价格==
-(void)clearTotal{
    [_chooseArr removeAllObjects];
    __block  CGFloat totleMoney = 0;
    __block  NSInteger count = 0;
//    __block NSInteger  totalNum = 0;
    [_shopModel.dataArr enumerateObjectsUsingBlock:^(YShopGoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChoose) {
            totleMoney +=[obj.goodMoney floatValue]*[obj.goodCount integerValue];
//            count += [obj.goodCount floatValue];
            count ++;
            [_chooseArr addObject:obj];
        }
//         totalNum +=[obj.goodCount integerValue];
    }];
    _totalModel.totalMoney = [NSString stringWithFormat:@"%.2f",totleMoney];
    _totalModel.chooseCount =  [NSString stringWithFormat:@"%ld",count];;
    _clearV.model = _totalModel;
    if (_shopModel.dataArr.count) {
        self.title = [NSString stringWithFormat:@"我的购物车(%ld)",_shopModel.dataArr.count];
    }else{
        self.title = @"我的购物车";
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
