//
//  YNowPromotionViewController.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YNowPromotionViewController.h"
#import "YSecondSearchView.h"
#import "YAdHeadView.h"
#import "YPromotionFirstCell.h"
#import "YPromotionTiltleView.h"
#import "YHotPromotionHeadView.h"
#import "YPromotionHotCell.h"
#import "YPromotionBOXCell.h"
#import "YPromotionActiveView.h"
#import "YPromotionSpecialCell.h"
#import "YPromotionClassModel.h"
#import "YGoodSearchViewController.h"
#import "YSGoodDetailViewController.h"
#import "YGoodFilterViewController.h"
#import "YSADDetailViewController.h"//广告页
#import "YGoodClassModel.h"


@interface YNowPromotionViewController ()<YSecondSearchViewDelegate,YPopViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YAdHeadViewDelegate,YPromotionFirstCellDelegate,YPromotionBOXCellDelegate,YHotPromotionHeadViewDelegate,YPromotionActiveViewDelegate,YPromotionSpecialCellDelegate>


@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) NSArray *list;

@property (strong,nonatomic) NSArray *images;

@property (strong,nonatomic) NSMutableArray *headAdArr;//头部广告

@property (strong,nonatomic) NSString *adActivityUrl;//广告活动

@property (strong,nonatomic) NSMutableArray *adGoodArr;//广告商品

@property (strong,nonatomic) NSMutableArray *hotPromotionArr;//热卖促销

@property (strong,nonatomic) NSMutableArray *hotImageArr;//广告数组

@property (strong,nonatomic) NSMutableArray *recommendArr;//推荐热卖

@property (strong,nonatomic) NSMutableArray *classArr;//推荐分类

@property (strong,nonatomic) NSMutableArray *specialArr;//特卖促销


@end

@implementation YNowPromotionViewController

- (void)getdata {
    [JKHttpRequestService POST:@"Index/promotions" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            _headAdArr = [YSParseTool getParseAD:data[@"top_img"]];
            _adGoodArr = [YSParseTool getParseHotGoods:data[@"top_goods"]];
            _hotPromotionArr = [YSParseTool getParseHotGoods:data[@"hot_promotion"]];
            _recommendArr = [YSParseTool getParseHotGoods:data[@"recommend_hot"]];
            _specialArr = [YSParseTool getParseHotGoods:data[@"sale_promotion"]];
            _classArr = [YSParseTool getParseGoodTypes:data[@"classes"]];
            _hotImageArr = [YSParseTool getParseAD:data[@"hot_promotion_img"]];
            YHeadImage *image = [YSParseTool getParseAD:data[@"top_goods_img"]].firstObject;
            _adActivityUrl = image.imageName;
            [_mainV reloadData];

        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNavi];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });

}

-(void)getNavi{
    YSecondSearchView *headV = [[YSecondSearchView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:headV];
    headV.delegate = self;
}

-(void)initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64) collectionViewLayout:flowLayout];
    [self.view addSubview:_mainV];
    _mainV.backgroundColor = __BackColor;
    _mainV.delegate = self;
    _mainV.dataSource = self;
    //section 0
    [_mainV registerClass:[YAdHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:@"YAdHeadView"];
    [_mainV registerClass:[YPromotionFirstCell class] forCellWithReuseIdentifier:@"YPromotionFirstCell"];
   //section 1
    [_mainV registerClass:[YHotPromotionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YHotPromotionHeadView"];
    [_mainV registerClass:[YPromotionHotCell class] forCellWithReuseIdentifier:@"YPromotionHotCell"];
    //section 2
    [_mainV registerClass:[YPromotionTiltleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YPromotionTiltleView"];
    [_mainV registerClass:[YPromotionBOXCell class] forCellWithReuseIdentifier:@"YPromotionBOXCell"];
    [_mainV registerClass:[YPromotionActiveView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YPromotionActiveView"];
    //section 3
    [_mainV registerClass:[YPromotionSpecialCell class] forCellWithReuseIdentifier:@"YPromotionSpecialCell"];
}
#pragma mark == YSecondSearchViewDelegate==
- (void)chooseNaviback {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)search:(NSString *)sender{
    NSLog(@"搜索%@",sender);
    YGoodSearchViewController *vc =[[YGoodSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)chooseRight{
   _list = @[@"首页",@"消息"];
    _images =@[@"home",@"news"];

    [self.view addSubview:self.popV];
    [self.view bringSubviewToFront:self.popV];
}
#pragma mark ==懒加载==
-(YPopView *)popV{
    if (!_popV) {
        _popV = [[YPopView alloc]initWithFrame:CGRectMake(__kWidth-40, 8, __kWidth, __kHeight-60) title:_list image:_images];
        _popV.delegate = self;
        _popV.userInteractionEnabled = YES;
    }
    return _popV;
}

#pragma mark ==YPopViewDelegate==
-(void)chooseIndex:(NSInteger)index{
    if (index==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"查看消息");
        YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ==UICollectionViewDelegate==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section ==1){
        return _hotPromotionArr.count;
    }else if(section ==2){
        return 1;
    }else{
        return _specialArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cells = nil;
    if (indexPath.section ==0) {
        YPromotionFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPromotionFirstCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPromotionFirstCell alloc]init];
        }
        if (_adGoodArr.count) {
            YGoodsModel *model= _adGoodArr[0];
            YGoodsModel *good =_adGoodArr[1];
            cell.hot = model;
            cell.good= good;
        }
        cell.imageName = _adActivityUrl;
        cell.delegate =self;
        cells = cell;
    }else if (indexPath.section ==1){
        YPromotionHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPromotionHotCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPromotionHotCell alloc]init];
        }
        YGoodsModel *model = _hotPromotionArr[indexPath.row];
        model.goodDesc = @"畅销国际 破冰底价";
        cell.model = model;
        switch (indexPath.row) {
            case 0:
            {
                cell.titleLb.textColor = LH_RGBCOLOR(240, 98, 88);
            }
                break;
            case 1:{
                cell.titleLb.textColor = LH_RGBCOLOR(62, 170, 253);
            }
                break;
            case 2:{
                cell.titleLb.textColor = LH_RGBCOLOR(255, 141, 0);
                cell.moneyBtn.hidden = YES;
            }
                break;
            case 3:{
                cell.titleLb.textColor = LH_RGBCOLOR(185, 95, 255);
                cell.moneyBtn.hidden = YES;
            }
                break;
                
            default:
                break;
        }
        cells = cell;
    }else if (indexPath.section == 2){
        YPromotionBOXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPromotionBOXCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPromotionBOXCell alloc]init];
        }
//        NSMutableArray *dataArr = [NSMutableArray array];
//        for (int i=0; i<6; i++) {
//            YGoodsModel *model = [[YGoodsModel alloc]init];
//            model.goodTitle = @"回形针曲别针";
//            model.goodMoney = @"12.00";
//            model.goodUrl = @"";
//            [dataArr addObject:model];
//        }
        cell.goodArr = _recommendArr;
        cell.delegate =self;
        cells = cell;
    }else{
        YPromotionSpecialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPromotionSpecialCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPromotionSpecialCell alloc]init];
        }
        YGoodsModel *model =_specialArr[indexPath.row];
//        model.goodTitle = @"得力 6600 思达中性笔等";
//        model.goodUrl = @"";
//        model.goodMoney = @"10.00";
//        model.goodOldMoney = @"16.00";
        cell.model = model;
        cell.tag = indexPath.row;
        cell.delegate =self;
        cells = cell;
    }
    return cells;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV = nil;
    if (indexPath.section ==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            YAdHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YAdHeadView" forIndexPath:indexPath];
            header.delegate = self;
            header.dataArr = _headAdArr;
            reuseV = header;
        }
    }else if (indexPath.section ==1){
        if (kind == UICollectionElementKindSectionHeader) {
            YHotPromotionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YHotPromotionHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YHotPromotionHeadView alloc]init];
            }
            header.delegate =self;
//            NSMutableArray *headArr =[NSMutableArray array];
//            for (int i =0; i<3; i++) {
//                YHeadImage *head = [[YHeadImage alloc]init];
//                head.imageName = @"";
//                head.imageUrl = @"";
//                [headArr addObject:head];
//            }
            header.title = @"热卖促销";
            header.imageArr = _hotImageArr;
            reuseV = header;
        }
    }else if (indexPath.section == 2){
        if (kind == UICollectionElementKindSectionHeader) {
            YPromotionTiltleView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YPromotionTiltleView" forIndexPath:indexPath];
            if (!header) {
                header = [[YPromotionTiltleView alloc]init];
            }
            header.title = @"推荐热卖";
            reuseV = header;
        }else if (kind == UICollectionElementKindSectionFooter){
            YPromotionActiveView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YPromotionActiveView" forIndexPath:indexPath];
            if (!footer) {
                footer = [[YPromotionActiveView alloc]init];
            }
            NSMutableArray *dataArr = [NSMutableArray array];
            for (YGoodClassModel *model in _classArr) {
                YPromotionClassModel *models = [[YPromotionClassModel alloc]init];
                models.classUrl = model.imageName;
                models.className = model.classTitle;
                models.englishclass = @"Office Equipment";
                models.classId = model.classID;
                [dataArr addObject:models];
            }
            footer.dataArr = dataArr;
            footer.delegate =self;
            reuseV = footer;
        }
    }else{
        if (kind == UICollectionElementKindSectionHeader) {
            YPromotionTiltleView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YPromotionTiltleView" forIndexPath:indexPath];
            if (!header) {
                header = [[YPromotionTiltleView alloc]init];
            }
            header.title = @"特卖促销";
            reuseV = header;
        }
    }
    return reuseV;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 3) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }else{
    return UIEdgeInsetsZero;
    }
}

//y
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 1;
    }else if (section == 3){
        return 10;
    }else{
        return 0;
    }
}
//x
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 1;
    }else if (section ==3){
        return 10;
    }else{
        return 0;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(__kWidth, 250);
    }else if (indexPath.section == 1){
        return CGSizeMake((__kWidth-1)/2, 95);
    }else if (indexPath.section ==2){
        return CGSizeMake(__kWidth, 160);
    }else{
        return CGSizeMake((__kWidth-30)/2, 270);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(__kWidth, 158*__kWidth/375);
    }else if (section ==1){
        return CGSizeMake(__kWidth, 30+85*__kWidth/375);
    }else{
        return CGSizeMake(__kWidth, 30);
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return CGSizeMake(__kWidth, 379);
    }else{
        return CGSizeZero;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSLog(@"热卖%ld",indexPath.row);
        YGoodsModel *model = _hotPromotionArr[indexPath.row];
        [self pushGood:model.goodId];
    }else if (indexPath.section ==3){
        NSLog(@"特卖%ld",indexPath.row);
        YGoodsModel *model = _specialArr[indexPath.row];
        [self pushGood:model.goodId];
    }

}
#pragma mark ==YAdHeadViewDelegate==
-(void)chooseAD:(NSString *)url{
    NSLog(@"选择广告");
    if (!IsNilString(url)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = url;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark ==YPromotionFirstCellDelegate==
-(void)chooseHot:(YGoodsModel *)sender{
    NSLog(@"%@",sender.goodTitle);
    [self pushGood:sender.goodId];
}
-(void)chooseGood:(YGoodsModel *)sender{
    NSLog(@"%@",sender.goodTitle);
    [self pushGood:sender.goodId];
}
#pragma mark ==YHotPromotionHeadViewDelegate==
-(void)choosebottomAD:(NSString *)url{
    NSLog(@"头部的底部图片");
    if (!IsNilString(url)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = url;
        [self.navigationController pushViewController:vc animated:YES];
    }

}
#pragma mark ==YPromotionBOXCellDelegate==
-(void)chooseBoxGood:(YGoodsModel *)model{
    NSLog(@"推荐%@",model.goodTitle);
    [self pushGood:model.goodId];
}
#pragma mark ==YPromotionActiveViewDelegate==
-(void)chooseCLass:(YPromotionClassModel *)model{
    NSLog(@"分类%@",model.className);
    YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
    vc.classId = model.classId;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)chooseTagV:(NSString *)sender{
    NSLog(@"标签%@",sender);
    YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
    vc.search = sender;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark ==YPromotionSpecialCellDelegate==
-(void)chooseSpecialGood:(NSInteger)tag{
    NSLog(@"加入购物车特卖%ld",tag);
    YGoodsModel *model = _specialArr[tag];
     [YGoodCollectAndCartService MakeGoodShopCart:@{@"goods_id":model.goodId,@"goods_num":@"1",@"price_new":model.goodMoney,@"app_user_id":[UdStorage getObjectforKey:Userid]}];

}

-(void)pushGood:(NSString*)sender{
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    vc.goodsId = sender;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_popV removeFromSuperview];
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
