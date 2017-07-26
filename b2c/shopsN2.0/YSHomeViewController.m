//
//  YSHomeViewController.m
//  shopsN2.0
//
//  Created by imac on 2017/7/3.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSHomeViewController.h"
#import "YFisrtSearchView.h"
#import "YAdHeadView.h"
#import "YADClassCell.h"
#import "YADwarnView.h"
#import "YSFirstSectionheadView.h"
#import "YSFirstPromotionGoodCell.h"
#import "YSFirstADCircleSectionView.h"
#import "YSTimeSetctionHeadView.h"
#import "YPrintBOXCell.h"
#import "YSBrandStoreCell.h"
#import "YSFirstADSctionHeadView.h"
#import "YGoodLikeCell.h"
#import "YSgiftGoodCell.h"

#import "YGuideViewController.h"//欢迎页
#import "YScanViewController.h"//扫一扫
#import "YSAnnounceDetailViewController.h"//公告详情
#import "YSADDetailViewController.h"//广告详情
#import "YSAnnouncementViewController.h"//公告
#import "YGoodSearchViewController.h"//搜索
#import "YSCLassListViewController.h"//活动列表页（家用电器、手机数码、电脑办公）
#import "YNowPromotionViewController.h"//最新促销
#import "YClearanceViewController.h"//尾货清仓
#import "YGiftFilterViewController.h"//积分列表（积分商城）
#import "YSBrandListViewController.h"//品牌馆
#import "YSBrandDetailViewController.h"//品牌详情页
#import "YGiftGoodDetailViewController.h"//积分商品详情页
#import "YSGoodDetailViewController.h"//商品详情页

@interface YSHomeViewController ()<YFisrtSearchViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YAdHeadViewDelegate,YADwarnViewDelegate,YSFirstSectionheadViewDelegate,YSTimeSetctionHeadViewDelegate,YSFirstPromotionGoodCellDelegate,YSFirstADSctionHeadViewDelegate,YSFirstADCircleSectionViewDelegate,YPrintBOXCellDelegate>

@property (strong,nonatomic) YFisrtSearchView *headV;

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) NSArray *bannerArr;//头部广告图数组

@property (strong,nonatomic) NSMutableArray *announceArr;//公告数组

@property (strong,nonatomic) NSArray *classImageArr;

@property (strong,nonatomic) NSArray *classTitleArr;

@property (strong,nonatomic) NSArray *sectionTitleArr;

@property (strong,nonatomic) NSMutableArray *promotionArr;//促销数组

@property (strong,nonatomic) YHeadImage *promotionImgModel;//促销广告

@property (strong,nonatomic) NSMutableArray *clearArr;//尾货数组

@property (strong,nonatomic) YHeadImage *clearImgModel;//清仓广告

@property (strong,nonatomic) NSMutableArray *brandArr;//品牌数组

@property (strong,nonatomic) YHeadImage *brandImgModel;//品牌广告

@property (strong,nonatomic) NSMutableArray *giftArr;//积分数组

@property (strong,nonatomic) YHeadImage *giftHeadImgModel;//积分头部广告

@property (strong,nonatomic) YHeadImage *giftBottomImgModel;//积分底部广告

@property (strong,nonatomic) NSMutableArray *appliancesArr;//家电数组

@property (strong,nonatomic) YHeadImage *appliancesImgModel;//家电广告

@property (strong,nonatomic) NSMutableArray *digitalArr;//数码数组

@property (strong,nonatomic) YHeadImage *digitalImgModel;//数码广告

@property (strong,nonatomic) NSMutableArray *officeArr;//办公数组

@property (strong,nonatomic) NSMutableArray *officeImgModel;//办公广告

@property (strong,nonatomic) NSString *endTime;//活动倒计时

@end

@implementation YSHomeViewController

#pragma mark ==地址选择器数据==
- (void)getAddressData{
    [JKHttpRequestService POST:@"Pcenter/addressPlace" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            if (data.count) {
                [YPlistAddressTool saveThePlistAddress:data];
            }
        }
    } failure:^(NSError *error) {

    } animated:NO];
}


- (void)getData {
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Index/home" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic= jsonDic[@"data"];
            _endTime = [NSString stringWithFormat:@"%@",dic[@"endtime"]];
            _announceArr = [YSParseTool getParseAnnounce:dic[@"announcement"]];
            _bannerArr = [YSParseTool getParseHeadAD:dic[@"banner"]];
            _promotionArr = [YSParseTool getParseGoodLoves:dic[@"promotions"]];
            _promotionImgModel = [YSParseTool getParseAD:dic[@"promotions_img"]].firstObject;
            _clearArr = [YSParseTool getParseGoodLoves:dic[@"poopClear"]];
            _clearImgModel = [YSParseTool getParseAD:dic[@"poopClear_img"]].firstObject;
            _brandArr = [YSParseTool getParseBrand:dic[@"brand"]];
            _brandImgModel = [YSParseTool getParseAD:dic[@"brand_img"]].firstObject;
            _giftArr = [YSParseTool getParseGoodLoves:dic[@"integral"]];
            _giftHeadImgModel = [YSParseTool getParseAD:dic[@"integral_top_img"]].firstObject;
            _giftBottomImgModel = [YSParseTool getParseAD:dic[@"integral_foot_img"]].firstObject;
            _appliancesArr = [YSParseTool getParseGoodLoves:dic[@"appliances"]];
            _appliancesImgModel = [YSParseTool getParseAD:dic[@"appliances_img"]].firstObject;
            _digitalArr = [YSParseTool getParseGoodLoves:dic[@"phone_digital"]];
            _digitalImgModel = [YSParseTool getParseAD:dic[@"phone_digital_img"]].firstObject;
            _officeArr = [YSParseTool getParseGoodLoves:dic[@"computerOffice"]];
            _officeImgModel = [YSParseTool getParseAD:dic[@"computerOffice_img"]].firstObject;
            [strongSelf.mainV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
    _headV.check = @"yes";
    //引导页 判断如下
    NSUserDefaults *ud = [NSUserDefaults  standardUserDefaults];
    BOOL isVisibled = [ud boolForKey:@"isVisibled"];
    if (!isVisibled) {
        YGuideViewController *vc = [[YGuideViewController alloc]init];
        [self presentViewController:vc animated:NO completion:nil];
    }

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_SERIAL, 0), ^{
         [self getData];
         dispatch_async(dispatch_get_main_queue(), ^{
             [self initView];
         });
     });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self getAddressData];
    });

}

- (void)initView {
    [self.view addSubview:self.headV];
    [self.view addSubview:self.mainV];
    //注册cell和ReusableView
    //section0
    [_mainV registerClass:[YADClassCell class]
            forCellWithReuseIdentifier:@"YADClassCell"];
    [_mainV registerClass:[YAdHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"YAdHeadView"];
    [_mainV registerClass:[YADwarnView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"YADwarnView"];
    //section1
    [_mainV registerClass:[YSFirstSectionheadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"YSFirstSectionheadView"];
    [_mainV registerClass:[YSFirstPromotionGoodCell class]
            forCellWithReuseIdentifier:@"YSFirstPromotionGoodCell"];
    [_mainV registerClass:[YSFirstADCircleSectionView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"YSFirstADCircleSectionView"];
    //section2
    [_mainV registerClass:[YSTimeSetctionHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"YSTimeSetctionHeadView"];
    [_mainV registerClass:[YPrintBOXCell class]
            forCellWithReuseIdentifier:@"YPrintBOXCell"];
    //section3
    [_mainV registerClass:[YSBrandStoreCell class]
            forCellWithReuseIdentifier:@"YSBrandStoreCell"];
    //section4
    [_mainV registerClass:[YSFirstADSctionHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"YSFirstADSctionHeadView"];
    [_mainV registerClass:[YSgiftGoodCell class]
            forCellWithReuseIdentifier:@"YSgiftGoodCell"];
    //section5
    [_mainV registerClass:[YGoodLikeCell class]
            forCellWithReuseIdentifier:@"YGoodLikeCell"];

}

#pragma mark ==懒加载==
- (YFisrtSearchView *)headV {
    if (!_headV) {
        _headV = [[YFisrtSearchView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
        _headV.delegate = self;
        _headV.check = @"yes";
    }
    return _headV;
}


- (UICollectionView *)mainV {
    if (!_mainV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _mainV = [[UICollectionView alloc]
                  initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)
                  collectionViewLayout:flowLayout];
        _mainV.backgroundColor = __BackColor;
        _mainV.delegate = self;
        _mainV.dataSource = self;
    }
    return _mainV;
}

- (NSArray *)classImageArr {
    if (!_classImageArr) {
        _classImageArr = @[@"最新促销",@"尾货清仓",@"品牌馆",@"积分商城",@"家用电器",@"手机数码",@"电脑办公",@"更多"];
    }
    return _classImageArr;
}

- (NSArray *)classTitleArr {
    if (!_classTitleArr) {
        _classTitleArr = @[@"最新促销",@"尾货清仓",@"品牌馆",@"积分商城",@"家用电器",@"手机数码",@"电脑办公",@"更多"];
    }
    return _classTitleArr;
}

- (NSArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = @[@"",@"最新促销",@"",@"品牌馆",@"积分商城",@"家用电器",@"手机数码",@"电脑办公"];
    }
    return _sectionTitleArr;
}

#pragma mark ==UICollectionViewDelegate==
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 8;
    }else if (section==1||section==2){
        return 1;
    }else if (section==3){
        return _brandArr.count;
    }else if (section==4){
        return _giftArr.count;
    }else if (section==5){
        return _appliancesArr.count;
    }else if (section==6){
        return _digitalArr.count;
    }else{
        return _officeArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *goodCell = nil;
    if (indexPath.section==0) {
        YADClassCell *cell = [collectionView
           dequeueReusableCellWithReuseIdentifier:@"YADClassCell"
                                      forIndexPath:indexPath];
        if (!cell) {
            cell = [[YADClassCell alloc]init];
        }
        YHeadClass *class =[[YHeadClass alloc]init];
        class.title = self.classTitleArr[indexPath.row];
        class.imageName = self.classImageArr[indexPath.row];
        cell.data =class;
        goodCell = cell;
    }else if (indexPath.section==1){
       YSFirstPromotionGoodCell *cell = [collectionView
                dequeueReusableCellWithReuseIdentifier:@"YSFirstPromotionGoodCell"
                                    forIndexPath:indexPath];
        if (!cell) {
            cell = [[YSFirstPromotionGoodCell alloc]init];
        }
        cell.goodArr = _promotionArr;
        cell.delegate = self;
        goodCell = cell;
    }else if (indexPath.section == 2){
        YPrintBOXCell *cell = [collectionView
           dequeueReusableCellWithReuseIdentifier:@"YPrintBOXCell"
                                     forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPrintBOXCell alloc]init];
        }
        cell.goodArr = _clearArr;
        cell.delegate = self;
        goodCell = cell;
    }else if (indexPath.section ==3){
        YSBrandStoreCell *cell = [collectionView
           dequeueReusableCellWithReuseIdentifier:@"YSBrandStoreCell"
                                     forIndexPath:indexPath];
        if (!cell) {
            cell = [[YSBrandStoreCell alloc]init];
        }
        cell.model = _brandArr[indexPath.row];
        goodCell = cell;
    }else if (indexPath.section ==4){
        YSgiftGoodCell *cell = [collectionView
           dequeueReusableCellWithReuseIdentifier:@"YSgiftGoodCell"
                                     forIndexPath:indexPath];
        if (!cell) {
            cell = [[YSgiftGoodCell alloc]init];
        }
        YGoodsModel *model = _giftArr[indexPath.row];
        cell.model = model;
        goodCell = cell;
    }else{
       YGoodLikeCell *cell = [collectionView
          dequeueReusableCellWithReuseIdentifier:@"YGoodLikeCell"
                                    forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodLikeCell alloc]init];
        }
        YGoodsModel *model = nil;
        switch (indexPath.section) {
            case 5:
            {
                model = _appliancesArr[indexPath.row];
            }
                break;
            case 6:
            {
                model = _digitalArr[indexPath.row];
            }
                break;
            case 7:
            {
                model = _officeArr[indexPath.row];
            }
                break;
            default:
                break;
        }
        cell.dataModel = model;
        goodCell = cell;
    }
    return goodCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reuseV = nil;
    if (indexPath.section ==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            YAdHeadView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YAdHeadView" forIndexPath:indexPath];
            if (!headerV) {
                headerV = [[YAdHeadView alloc]init];
            }
            headerV.delegate = self;
            headerV.dataArr = _bannerArr;
            reuseV = headerV;
        }
        if (kind == UICollectionElementKindSectionFooter) {
            YADwarnView *footerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YADwarnView" forIndexPath:indexPath];
            footerV.titleArr =_announceArr;
            footerV.delegate = self;
            reuseV = footerV;
        }
    }else if ((indexPath.section ==1||indexPath.section==3)&&kind == UICollectionElementKindSectionHeader){
            YSFirstSectionheadView *headerV = [collectionView
               dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                  withReuseIdentifier:@"YSFirstSectionheadView"
                                         forIndexPath:indexPath];
            headerV.className = self.sectionTitleArr[indexPath.section];
            headerV.tag =indexPath.section;
            headerV.delegate = self;
            reuseV = headerV;
    }else if (indexPath.section == 2&&kind == UICollectionElementKindSectionHeader) {
            YSTimeSetctionHeadView *headerV = [collectionView
               dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                  withReuseIdentifier:@"YSTimeSetctionHeadView"
                                         forIndexPath:indexPath];
            headerV.time = _endTime;
            headerV.tag = 2;
            headerV.delegate = self;
            reuseV = headerV;
    }else if (indexPath.section>3&&kind==UICollectionElementKindSectionHeader){
        YSFirstADSctionHeadView *headerV = [collectionView
           dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                              withReuseIdentifier:@"YSFirstADSctionHeadView"
                                     forIndexPath:indexPath];
        headerV.tag = indexPath.section;
        headerV.className = self.sectionTitleArr[indexPath.section];
        switch (indexPath.section) {
            case 4:
                headerV.model = _giftHeadImgModel;
                break;
            case 5:
                headerV.model = _appliancesImgModel;
                break;
            case 6:
                headerV.model = _digitalImgModel;
                break;
            case 7:
                headerV.model = _officeImgModel;
                break;
            default:
                break;
        }
        headerV.delegate =self;
        reuseV = headerV;
    }else{
        YSFirstADCircleSectionView *footerV = [collectionView
           dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                              withReuseIdentifier:@"YSFirstADCircleSectionView"
                                     forIndexPath:indexPath];
        footerV.delegate = self;
        switch (indexPath.section) {
            case 1:
                footerV.model = _promotionImgModel;
                break;
            case 2:
                footerV.model = _clearImgModel;
                break;
            case 3:
                footerV.model = _brandImgModel;
                break;
            case 4:
                footerV.model = _giftBottomImgModel;
                break;
            default:
                break;
        }
        reuseV = footerV;
    }
    return reuseV;
}


//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==0||section==3) {
        return 1;
    }else if (section>4){
        return 4;
    }else{
        return 0;
    }
}

//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==0||section==3) {
        return 1;
    }else if (section>4){
        return 4;
    }else{
        return 0;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(__kWidth/4-1, 105);
    }else if (indexPath.section==1){
        return CGSizeMake(__kWidth, 180);
    }else if (indexPath.section==2){
        return CGSizeMake(__kWidth, 180);
    }else if (indexPath.section ==3){
        return CGSizeMake((__kWidth-3)/4, (__kWidth-3)/9);
    }else if (indexPath.section==4){
        return CGSizeMake(__kWidth/3, 115);
    }else{
        return CGSizeMake((__kWidth-4)/2, 248);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(__kWidth, 158*__kWidth/375);
    }else if (section==1||section==2||section==3){
        return CGSizeMake(__kWidth, 45);
    }else{
        return CGSizeMake(__kWidth, __kWidth/2+45);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(__kWidth, 40);
    }else if (section==1||section==2||section==3){
        return CGSizeMake(__kWidth, 110);
    }else{
        return CGSizeZero;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            YNowPromotionViewController *vc = [[YNowPromotionViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            YClearanceViewController *vc = [[YClearanceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==2){
            YSBrandListViewController *vc = [[YSBrandListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            YGiftFilterViewController *vc = [[YGiftFilterViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==7) {
            YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
            tab.selectIndex = 1;
        }else{
            YSCLassListViewController *vc = [[YSCLassListViewController alloc]init];
            vc.className = self.classTitleArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section==3){
        YSBrandDetailViewController *vc = [[YSBrandDetailViewController alloc]init];
        YSBrandModel *model =_brandArr[indexPath.row];
        vc.brandId = model.brandId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==4){
        NSLog(@"积分");
        YGoodsModel *model = _giftArr[indexPath.row];
        YGiftGoodModel*gmodel = [[YGiftGoodModel alloc]init];
        gmodel.goodId = model.goodId;
        YGiftGoodDetailViewController *vc = [[YGiftGoodDetailViewController alloc]init];
        vc.model = gmodel;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section>4){
        NSLog(@"商品");
        YGoodsModel *model = nil;
        switch (indexPath.section) {
            case 5:
            {
                model = _appliancesArr[indexPath.row];
            }
                break;
            case 6:
            {
                model = _digitalArr[indexPath.row];
            }
                break;
            case 7:
            {
                model = _officeArr[indexPath.row];
            }
                break;
            default:
                break;
        }
        YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
        vc.goodsId = model.goodId;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark == YFisrtSearchViewDelegate==
-(void)login{
    NSLog(@"登录");
    YSLoginViewController *vc= [[YSLoginViewController alloc]init];
    BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];

}

-(void)search:(NSString *)sender{
    NSLog(@"搜索%@",sender);
    YGoodSearchViewController *vc = [[YGoodSearchViewController alloc]init];
    vc.isList = NO;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)SeeMessage{
    NSLog(@"查看消息");
    YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)QRCodeAction{
    NSLog(@"扫码");
    YScanViewController *vc = [[YScanViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YAdHeadViewDelegate==
-(void)chooseAD:(NSString *)url{
    NSLog(@"选中头部广告");
    if (!IsNilString(url)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ==YADwarnViewDelegate==
-(void)getMore{
    NSLog(@"更多");
    YSAnnouncementViewController *vc = [[YSAnnouncementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)chooseWarn:(NSInteger)index{
    YWarnModel *model = _announceArr[index-33];
    NSLog(@"%@",model.warnId);
    YSAnnounceDetailViewController *vc = [[YSAnnounceDetailViewController alloc]init];
    vc.warnId = model.warnId;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ==YSTimeSetctionHeadViewDelegate==
- (void)lookClearanceMore {
    YClearanceViewController *vc = [[YClearanceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ==YSFirstPromotionGoodCellDelegate==
- (void)choosePromotionGood:(YGoodsModel *)model {
    NSLog(@"查看热销商品");
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    vc.goodsId = model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ==YSFirstSectionheadViewDelegate==
- (void)lookClassSection:(NSInteger)index{
    if (index==1) {
        YNowPromotionViewController *vc = [[YNowPromotionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index==3) {
        YSBrandListViewController *vc = [[YSBrandListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ==YSFirstADCircleSectionViewDelegate==
- (void)chooseSectionADPush:(NSString *)className Id:(NSString *)sender{
    NSLog(@"圆形广告");
    if (!IsNilString(className)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = className;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark ==YPrintBOXCellDelegate==
- (void)chooseGood:(YGoodsModel *)model {
    NSLog(@"商品尾货");
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    vc.goodsId = model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YSFirstADSctionHeadViewDelegate==
- (void)chooseADPush:(NSString *)name Id:(NSString *)sender{
    NSLog(@"广告");
    if (!IsNilString(name)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = name;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)chooseSectionclass:(NSInteger)index {
    NSLog(@"分类%ld",index);
    if (index==4) {
        YGiftFilterViewController *vc = [[YGiftFilterViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YSCLassListViewController *vc = [[YSCLassListViewController alloc]init];
        vc.className = _sectionTitleArr[index];
        [self.navigationController pushViewController:vc animated:YES];
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
