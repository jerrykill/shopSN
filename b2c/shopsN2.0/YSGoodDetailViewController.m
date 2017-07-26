//
//  YSGoodDetailViewController.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSGoodDetailViewController.h"
#import "YGoodDetailBottomActionView.h"
#import "YGoodDetailHeadView.h"
#import "YGoodDetailChooseCell.h"
#import "YGooddetailLikeHeadView.h"
#import "YGoodDetailLikeCell.h"
#import "YGoodRefreshBoottomView.h"
#import "YGoodBottomCell.h"
#import "YOrderGoodsModel.h"
#import "YGoodShopModel.h"
#import "YGoodColorAndWayCheckView.h"
#import "YGoodLocationCheckView.h"
#import "YGoodShareView.h"

#import "YSureOrderViewController.h"

@interface YSGoodDetailViewController ()<YGoodDetailBottomActionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YGooddetailLikeHeadViewDelegate,YGoodBottomCellDelegate,YGoodDetailHeadViewDelegate,YGoodColorAndWayCheckViewdelegate,YGoodLocationCheckViewDelegate,YGoodShareViewDelegate>


@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) UICollectionView *goodBootomV;

@property (strong,nonatomic) YGoodDetailBottomActionView *bottomV;

@property (nonatomic) BOOL isLoad;

@property (strong,nonatomic) YGoodDetailModel *model;

@property (strong,nonatomic) NSMutableArray *loves;//猜你喜欢

@property (strong,nonatomic) NSMutableArray *collocations;//搭配套餐

@property (strong,nonatomic) YShopGoodModel *checkModel;//选择模型

@property (strong,nonatomic) YGoodColorAndWayCheckView *typeCheckV;

@property (strong,nonatomic) YGoodLocationCheckView *locationCheckV;

@property (strong,nonatomic) YGoodShareView *shareV;

@property (strong,nonatomic) UIButton *countBtn;

@property (nonatomic) NSInteger count;

@property (assign,nonatomic) NSInteger selectType;

@property (strong,nonatomic) NSMutableArray<YSGoodTypeEditModel*>*types;//商品规格



@end

@implementation YSGoodDetailViewController

-(void)getdata{
    _count = 0;
    _selectType = 0;
//    _goodsId = @"3435";
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    _checkModel = [[YShopGoodModel alloc]init];
    [JKHttpRequestService GET:@"goods/goods" withParameters:@{@"goods_id":_goodsId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = jsonDic[@"data"];
            strongSelf.model = [YSParseTool getParseGoodDetail:dic];
            
            if (IsNilString(weakSelf.model.goodId)) {
                strongSelf.model.goodId = _goodsId;
            }
            strongSelf.types = [YSParseTool getParseChooseGood:dic[@"compatriot"]];
            strongSelf.checkModel.goodTitle = _model.goodTitle;
            strongSelf.checkModel.goodUrl = _model.goodUrl;
            strongSelf.checkModel.goodMoney = _model.goodMoney;
            strongSelf.checkModel.goodCount = @"1";
            strongSelf.checkModel.goodId = _model.goodId;
            strongSelf.checkModel.goodTypeArr = [NSMutableArray array];
            strongSelf.collocations = [YSParseTool getParseGoodMatchs:dic[@"recommend"]];
            [strongSelf.mainV reloadData];
            [strongSelf.goodBootomV reloadData];
            NSString *collect = [NSString stringWithFormat:@"%@",strongSelf.model.isCollected];
            strongSelf.bottomV.isCollect = [collect isEqualToString:@"1"];
            strongSelf.count = [dic[@"goods_num"] integerValue];
            [strongSelf.countBtn setTitle:[NSString stringWithFormat:@"%ld",strongSelf.count] forState:BtnNormal];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)changeLoves{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Goods/my_love" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.loves = [YSParseTool getParseGoodsGuessLoves:data];
            [strongSelf.mainV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
     [self getNavis];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self changeLoves];
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });

}

- (void)getNavis{
    UIButton *cartBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-80, 30, 30, 23)];
    [self.headV addSubview:cartBtn];
    cartBtn.backgroundColor= [UIColor clearColor];
    [cartBtn setImage:MImage(@"head_cart") forState:BtnNormal];
    [cartBtn addTarget:self action:@selector(chooseCart) forControlEvents:BtnTouchUpInside];

    _countBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, -2, 17, 17)];
    [cartBtn addSubview:_countBtn];
    _countBtn.layer.cornerRadius = 8.5;
    _countBtn.backgroundColor = LH_RGBCOLOR(255, 114, 0);
    _countBtn.titleLabel.font = MFont(10);
    [_countBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];

    UIImageView *lust = [[UIImageView alloc]init];
    
}

-(void)initView{
    [self.view addSubview:self.mainV];
    [self.view sendSubviewToBack:self.mainV];
    //section 0
    [_mainV registerClass:[YGoodDetailHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YGoodDetailHeadView"];
    [_mainV registerClass:[YGoodDetailChooseCell class] forCellWithReuseIdentifier:@"YGoodDetailChooseCell"];

    //section 1
    [_mainV registerClass:[YGooddetailLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YGooddetailLikeHeadView"];
    [_mainV registerClass:[YGoodDetailLikeCell class] forCellWithReuseIdentifier:@"YGoodDetailLikeCell"];
    //section 2
    [_mainV registerClass:[YGoodRefreshBoottomView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YGoodRefreshBoottomView"];

    [self.view addSubview:self.goodBootomV];
    [self.view sendSubviewToBack:_goodBootomV];
      //section 0
    [_goodBootomV registerClass:[YGoodBottomCell class] forCellWithReuseIdentifier:@"YGoodBottomCell"];

    [self.view addSubview:self.bottomV];
    [self.view bringSubviewToFront:self.bottomV];
}
#pragma mark ==懒加载==
-(UICollectionView *)mainV{
    if (!_mainV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50) collectionViewLayout:flowLayout];
        _mainV.backgroundColor = [UIColor whiteColor];
        _mainV.delegate = self;
        _mainV.dataSource = self;
        _mainV.tag = 31;
    }
    return _mainV;
}

-(UICollectionView *)goodBootomV{
    if (!_goodBootomV) {
        UICollectionViewFlowLayout *flowLayouts = [[UICollectionViewFlowLayout alloc]init];
        _goodBootomV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectYH(_mainV), __kWidth, __kHeight-64-50) collectionViewLayout:flowLayouts];

        _goodBootomV.backgroundColor = __BackColor;
        _goodBootomV.delegate = self;
        _goodBootomV.dataSource = self;
        _goodBootomV.tag = 32;

    }
    return _goodBootomV;
}

-(YGoodDetailBottomActionView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[YGoodDetailBottomActionView alloc]initWithFrame:CGRectMake(0, __kHeight-50, __kWidth, 50)];
        _bottomV.delegate =self;
    }
    return _bottomV;
}

- (YGoodLocationCheckView *)locationCheckV{
    if (!_locationCheckV) {
        _locationCheckV = [[YGoodLocationCheckView alloc]initWithFrame:CGRectMake(0, __kHeight*2/3, __kWidth, __kHeight/3)];
        _locationCheckV.locationArr = _model.location;
        _locationCheckV.delegate = self;
    }
    return _locationCheckV;
}

-(YGoodColorAndWayCheckView *)typeCheckV{
    if (!_typeCheckV) {
        _typeCheckV = [[YGoodColorAndWayCheckView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        _typeCheckV.model = _model;
        _typeCheckV.checkModel = _checkModel;
        _typeCheckV.delegate = self;
    }
    return _typeCheckV;
}

#pragma mark ==修改布局上拉==
-(void)changeFrame{
    [UIView animateWithDuration:0.3 animations:^{
        _mainV.frame = CGRectMake(0, 50-__kHeight, __kWidth, __kHeight-64-50);
        _goodBootomV.frame = CGRectMake(0, 64, __kWidth, __kHeight-64-50);
    }];

}

#pragma mark ==进购物车==
-(void)chooseCart{
    if (IsNilString([UdStorage getObjectforKey:Userid])) {
        YSLoginViewController *vc = [[YSLoginViewController alloc]init];
        BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
        tab.selectIndex = 2;
        [self.navigationController popToRootViewControllerAnimated:YES];
    });

}

#pragma mark ==YGoodBottomCellDelegate==
-(void)getHeadFresh{
    [UIView animateWithDuration:0.3 animations:^{
        _mainV.frame = CGRectMake(0, 64, __kWidth, __kHeight-64-50);
        _goodBootomV.frame = CGRectMake(0, CGRectYH(_mainV), __kWidth, __kHeight-64-50);
    }];

}


#pragma mark ==UICollectionViewDelegate==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag ==32) {
        return 1;
    }
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag ==31) {
    if (section ==0) {
        return 1;
    }else if (section==1){
        return _loves.count;
    }else{
        return _collocations.count;
    }
    }else{
        return 1;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cells= nil;
    if (collectionView.tag==31) {
    if (indexPath.section == 0) {
        YGoodDetailChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodDetailChooseCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodDetailChooseCell alloc]init];
        }
        cell.title = @"已选";
        if (_checkModel.goodTypeArr.count) {
            NSString *str =@"";
            for (YGoodTypeModel *dic in _checkModel.goodTypeArr) {
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",dic.name,dic.size]];
            }
            cell.detail =str;
        }else{
            if (_model.goodSize.count) {
                cell.detail = @"点击选择颜色、规格";
            }else{
                cell.detail = @"无附加规格";
            }
        }
        cells = cell;
    }else if (indexPath.section == 1){
        YGoodDetailLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodDetailLikeCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodDetailLikeCell alloc]init];
        }
        cell.model = _loves[indexPath.row];
        cells =  cell;
    }else if (indexPath.section == 2){
        YGoodDetailLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodDetailLikeCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodDetailLikeCell alloc]init];
        }
        cell.model =_collocations[indexPath.row];
        cells = cell;
    }
    }else{
        YGoodBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodBottomCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodBottomCell alloc]init];
        }
        cell.delegate =self;
        cell.goodID = _model.goodId;
        cells = cell;
    }
    return cells;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV = nil;
    if (collectionView.tag==31) {
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            YGoodDetailHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YGoodDetailHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YGoodDetailHeadView alloc]init];
            }
            header.delegate = self;
            header.model = _model;
            reuseV = header;
        }
    }else if (indexPath.section == 1){
        if (kind == UICollectionElementKindSectionHeader) {
            YGooddetailLikeHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YGooddetailLikeHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YGooddetailLikeHeadView alloc]init];
            }
            header.titles= @"猜你喜欢";
            header.delegate = self;
            reuseV = header;
        }
    }else if (indexPath.section == 2){
        if (kind == UICollectionElementKindSectionHeader) {
            YGooddetailLikeHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YGooddetailLikeHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YGooddetailLikeHeadView alloc]init];
            }
            header.titles = @"搭配套餐推荐";
            header.delegate = self;
            reuseV = header;
        }else if (kind == UICollectionElementKindSectionFooter){
            YGoodRefreshBoottomView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YGoodRefreshBoottomView" forIndexPath:indexPath];
            if (!footer) {
                footer = [[YGoodRefreshBoottomView alloc]init];
            }
            footer.chooseIndex = _selectType;
            reuseV =footer;
        }
    }
    }
    return reuseV;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

//y
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//x
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==31) {
    if (indexPath.section ==0) {
        return CGSizeMake(__kWidth, 56);
    }else{
        return CGSizeMake(__kWidth/3, 190);
    }}else{
        return CGSizeMake(__kWidth, __kHeight-50-64);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionView.tag==31) {
    if (section == 0) {
        if (_model.list.count) {
            return CGSizeMake(__kWidth, __kWidth+125+30*_model.list.count);
        }else{
            return CGSizeMake(__kWidth, __kWidth+110);
        }
    }else{
        return CGSizeMake(__kWidth, 40);
    }
    }else{
        return CGSizeZero;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (collectionView.tag==31) {
    if (section ==2) {
        return CGSizeMake(__kWidth, 45);
    }else{
        return CGSizeZero;
    }
    }else{
        return CGSizeZero;
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag==31) {
    if (indexPath.section ==0) {
        if (_model.goodSize.count) {
            [self changeColorAndWay];
        }
    }else if (indexPath.section==1){
        NSLog(@"喜欢%ld",indexPath.row);
        YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
        YGoodDetailModel *model = _loves[indexPath.row];
        vc.goodsId = model.goodId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==2) {
        NSLog(@"搭配%ld",indexPath.row);
        YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
        YGoodDetailModel *model =  _collocations[indexPath.row];
        vc.goodsId = model.goodId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    }
}

#pragma mark ==选择颜色规格==
-(void)changeColorAndWay{
 NSLog(@"选择颜色规格");
    [self.view addSubview:self.typeCheckV];
    [self.view bringSubviewToFront:_typeCheckV];
}


#pragma mark ==YGooddetailLikeHeadViewDelegate==
-(void)changeNext{
    NSLog(@"换一批");
    [self changeLoves];
}

#pragma mark ==YGoodDetailBottomActionView==
-(void)chooseGoodAction:(NSInteger)index isCollect:(BOOL)sender{
    if (IsNilString([UdStorage getObjectforKey:Userid])) {
        YSLoginViewController *vc = [[YSLoginViewController alloc]init];
        BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    switch (index) {
        case 0:
        {
            if (sender) {
                NSLog(@"收藏");
                [YGoodCollectAndCartService MakeGoodCollect:@{@"goods_id":_checkModel.goodId,@"type":@"1",@"app_user_id":[UdStorage getObjectforKey:Userid]}];
            }else{
                NSLog(@"不收藏");
                [YGoodCollectAndCartService MakeGoodCollect:@{@"goods_id":_checkModel.goodId,@"type":@"2",@"app_user_id":[UdStorage getObjectforKey:Userid]}];
            }
        }
            break;
        case 1:{
            NSLog(@"加入购物车");
            if (_checkModel.goodTypeArr.count!=_model.goodSize.count) {
                [self changeColorAndWay];
                return;
            }else{
                _count++;
                [_countBtn setTitle:[NSString stringWithFormat:@"%ld",_count] forState:BtnNormal];
                if (IsNilString(_checkModel.wareHouseId)) {
                    _checkModel.wareHouseId =@"";
                }
                [YGoodCollectAndCartService MakeGoodShopCart:@{@"goods_id":_checkModel.goodId,@"goods_num":_checkModel.goodCount,@"price_new":_checkModel.goodMoney,@"warehouse_id":_checkModel.wareHouseId,@"app_user_id":[UdStorage getObjectforKey:Userid]}];
            }
        }
            break;
        case 2:{
            NSLog(@"立即购买");
            if (_checkModel.goodTypeArr.count!=_model.goodSize.count) {
                [self changeColorAndWay];
                return;
            }
            NSMutableArray *goods = [NSMutableArray array];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:_checkModel.goodId forKey:@"id"];
            [dic setValue:_checkModel.goodCount forKey:@"num"];
            [goods addObject:dic];
            NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

            [JKHttpRequestService POST:@"Order/goBuy" withParameters:@{@"goods":jsonStr,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
                if (succe){
                    NSDictionary *dics = jsonDic[@"data"];
                    YSureOrderViewController *vc = [[YSureOrderViewController alloc]init];
                    vc.datas = [NSMutableArray arrayWithArray:@[_checkModel]];
                    vc.totalPay = dics[@"total_price"];
                    NSArray *adds = @[dics[@"address"]];
                    vc.address = [YSParseTool getParseAddress:adds].firstObject;
                    vc.freight = [NSString stringWithFormat:@"%@",dics[@"freight"]];
                    vc.personIntegral = dics[@"integral"];
                    vc.buyType = @"2";
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } failure:^(NSError *error) {
                
            } animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag ==31) {
        CGPoint point = scrollView.contentOffset;
        if (point.y>scrollView.contentSize.height+56-__kHeight&&!scrollView.isDragging) {
            if (_isLoad) {
                [self changeFrame];
                _isLoad= NO;
            }else{
            _isLoad=YES;
            }
        }
    }
}

#pragma mark ==YGoodDetailHeadViewDelegate==
-(void)ShareGood{
    _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self.view addSubview:_shareV];
    _shareV.delegate = self;
    _shareV.goodID = _model.goodId;
}
#pragma mark ==YGoodShareViewDelegate==
-(void)shareType:(NSInteger)sender Url:(NSString *)goodID{
    NSLog(@"分享%ld",sender);
    [YShareTool shareMessage:@"商品信息" title:@"测试" Url:[NSString stringWithFormat:@"%@%@.html",ShareGoodRoot,goodID] type:sender];
}

#pragma mark ==YGoodColorAndWayCheckView==
-(void)addShop{
    NSLog(@"添加购物车");
    if (_checkModel.goodTypeArr.count!=_model.goodSize.count) {
        [SXLoadingView showAlertHUD:@"商品信息不全" duration:1.5];
        return;
    }else{
        if (IsNilString([UdStorage getObjectforKey:Userid])) {
            YSLoginViewController *vc = [[YSLoginViewController alloc]init];
            BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:navi animated:YES completion:nil];
            return;
        }
        _count++;
        [_countBtn setTitle:[NSString stringWithFormat:@"%ld",_count] forState:BtnNormal];
        [YGoodCollectAndCartService MakeGoodShopCart:@{@"goods_id":_checkModel.goodId,@"goods_num":_checkModel.goodCount,@"price_new":_checkModel.goodMoney,@"warehouse_id":@"0",@"app_user_id":[UdStorage getObjectforKey:Userid]}];
    }
}
-(void)PayNow{
    NSLog(@"购买");
    if (_checkModel.goodTypeArr.count!=_model.goodSize.count) {
        [SXLoadingView showAlertHUD:@"商品信息不全" duration:1.5];
        return;
    }
    if (IsNilString([UdStorage getObjectforKey:Userid])) {
        YSLoginViewController *vc = [[YSLoginViewController alloc]init];
        BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    NSMutableArray *goods = [NSMutableArray array];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_checkModel.goodId forKey:@"id"];
    [dic setValue:_checkModel.goodCount forKey:@"num"];
    [goods addObject:dic];
    NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    [JKHttpRequestService POST:@"Order/goBuy" withParameters:@{@"goods":jsonStr,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe){
            NSDictionary *dics = jsonDic[@"data"];
            YSureOrderViewController *vc = [[YSureOrderViewController alloc]init];
            vc.datas = [NSMutableArray arrayWithArray:@[_checkModel]];
            vc.totalPay = dics[@"total_price"];
            NSArray *adds = @[dics[@"address"]];
            vc.address = [YSParseTool getParseAddress:adds].firstObject;
            vc.freight = [NSString stringWithFormat:@"%@",dics[@"freight"]];
            vc.personIntegral = dics[@"integral"];
            vc.buyType = @"2";
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}
#pragma mark ==选择规格==
-(void)chooseModel:(YShopGoodModel *)model{
    if (model.goodTypeArr.count) {
        _checkModel.goodTypeArr = model.goodTypeArr;
    }
    if (model.goodTypeArr.count== _model.goodSize.count) {
        NSMutableArray *counts = [NSMutableArray arrayWithArray:model.goodTypeArr];
        for (YGoodTypeModel *tp in _checkModel.goodTypeArr) {
            for (int i=0; i<_model.goodSize.count; i++) {
                YGoodSizeModel *lt = _model.goodSize[i];
                if ([lt.typeName isEqualToString:tp.name]) {
                    [counts replaceObjectAtIndex:i withObject:tp.sizeId];
                }
            }
        }
        NSArray *datas =[self comparess:counts];
        if (datas.count) {
            NSString *key=datas[0];
            for (int i=1; i<datas.count; i++) {
                key =[key stringByAppendingString:[NSString stringWithFormat:@"_%@",datas[i]]];
            }
            for (YSGoodTypeEditModel *god in _types) {
                if ([god.key isEqualToString:key] ) {
                    if ([god.stock integerValue]>=[_checkModel.goodCount integerValue]) {
                        _checkModel.goodId = god.goodsId;
                        _checkModel.goodMoney= god.goodMoney;
                        _model.goodId = god.goodsId;
                        _model.goodMoney = god.goodMoney;
                        _model.stock = god.stock;
                    }else{
                        [SXLoadingView showAlertHUD:@"该类商品库存不足，请重新选择" duration:0.5];
                    }
                }
            }
        }
    }
    [_mainV reloadData];
    _typeCheckV.checkModel = _checkModel;
    _typeCheckV.model = _model;
}

-(NSArray*)comparess:(NSMutableArray*)data{
    [data sortUsingComparator:^NSComparisonResult(id  obj1, id  obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]){
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    return data;
}

#pragma mark ==YGoodLocationCheckViewDelegate==
-(void)chooseLoaction:(YSGoodLocationModel*)sender{
    _checkModel.wareHouse = sender.name;
    _checkModel.wareHouseId = sender.locationId;
    [_mainV reloadData];
}

#pragma mark ==YGoodBottomCellDelegateDelegate==
-(void)putQuestions:(NSString *)text{
    NSLog(@"%@",text);
}

-(void)chooseType:(NSInteger)index{
    _selectType=index;
    [_mainV reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_locationCheckV removeFromSuperview];
    [self.popV removeFromSuperview];
}


@end
