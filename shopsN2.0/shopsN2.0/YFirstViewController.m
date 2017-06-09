//
//  YFirstViewController.m
//  shopsN
//
//  Created by imac on 2016/11/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YFirstViewController.h"
#import "YAdHeadView.h"
#import "YADClassCell.h"
#import "YADwarnView.h"
#import "YSectionHeadView.h"
#import "YGoodClassCell.h"
#import "YGoodLikeCell.h"
#import "YGoodFoundCell.h"
#import "YSectionBottomView.h"
#import "YFisrtSearchView.h"

#import "YGoodFilterViewController.h"
#import "YPrintConsumablesViewController.h"
#import "YGoodSearchViewController.h"
#import "YSAnnouncementViewController.h"
#import "YSAnnounceDetailViewController.h"
#import "YClearanceViewController.h"
#import "YHotSaleViewController.h"
#import "YNowPromotionViewController.h"
#import "YSGoodDetailViewController.h"
#import "YSLoginViewController.h"
#import "YGoodFilterViewController.h"
#import "YScanViewController.h"
#import "YPersonMoreViewController.h"//测试
#import "YGuideViewController.h"
#import "YSBannerView.h"
#import "YSADDetailViewController.h"//广告页

#import "YPlistAddressTool.h"


@interface YFirstViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YAdHeadViewDelegate,YADwarnViewDelegate,YGoodFoundCellDelegate,YSectionBottomViewDelegate,YFisrtSearchViewDelegate>

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) UITextField *searchTF;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSMutableArray *likeArr;

@property (strong,nonatomic) NSArray *imageArr;//分类图标

@property (strong,nonatomic) NSArray *classArr;//分类标题

@property (strong,nonatomic) NSString *rootImg;//图片根url

@property (strong,nonatomic) NSArray *bannerArr;//头部广告图数组


@property (strong,nonatomic) NSMutableArray *announceArr;//公告数组

@property (strong,nonatomic) NSMutableArray *goodsTypes;//商品分类数组


@property (strong,nonatomic) NSMutableArray *foundGoods;//发现好货

@property (strong,nonatomic) NSMutableArray *mayLoves;//猜你喜欢数组

@property (strong,nonatomic) NSMutableArray *hotImageArr;//分类底部广告

@property (strong,nonatomic) NSMutableArray *foundsImageArr;//发现好货广告



@end

@implementation YFirstViewController

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


- (void)getdata{
    _announceArr =[NSMutableArray array];
    _goodsTypes = [NSMutableArray array];
    _mayLoves = [NSMutableArray array];
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Index/home" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           NSDictionary *dic= jsonDic[@"data"];
           strongSelf.bannerArr   = [YSParseTool getParseHeadAD:dic[@"banner"]];
           strongSelf.announceArr = [YSParseTool getParseAnnounce:dic[@"announcement"]];
           strongSelf.foundGoods = [YSParseTool getParseFounds:dic[@"find_goods"]];
           strongSelf.foundsImageArr = [YSParseTool getParseAD:dic[@"find_goods_ad"]];
           strongSelf.goodsTypes  = [YSParseTool getParseGoodTypes:dic[@"goods_type"]];
           strongSelf.hotImageArr = [YSParseTool getParseAD:dic[@"goods_type_ad"]];
           strongSelf.mayLoves    = [YSParseTool getParseGoodLoves:dic[@"maybe_love"]];
           [strongSelf.mainV reloadData];
       }
   } failure:^(NSError *error) {

   } animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = NO;
    //页面 代码如下
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
    self.navigationController.navigationBar.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self getAddressData];
    });
    [self getNavi];
 
}

#pragma mark ==懒加载==
-(UICollectionView *)mainV{
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

- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr =@[@"Home_nav1",@"Home_nav2",@"Home_nav3",@"Home_nav4"];
    }
    return _imageArr;
}

- (NSArray *)classArr {
    if (!_classArr) {
        _classArr = @[@"热卖馆",@"最新促销",@"打印耗材",@"尾货清仓"];
    }
    return _classArr;
}

#pragma mark ==初始化UI==
- (void)initView{

    [self.view addSubview:self.mainV];

    //注册cell和ReusableView
    //section0
    [_mainV registerClass:[YADClassCell class]
            forCellWithReuseIdentifier:@"YADClassCell"];
    [_mainV registerClass:[YAdHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YAdHeadView"];
    [_mainV registerClass:[YADwarnView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YADwarnView"];
    //section1
    [_mainV registerClass:[YSectionHeadView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSectionHeadView"];//标题
    [_mainV registerClass:[YGoodClassCell class]
            forCellWithReuseIdentifier:@"YGoodClassCell"];
    [_mainV registerClass:[YSectionBottomView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YSectionBottomView"];//底部广告
    //section2
    [_mainV registerClass:[YGoodFoundCell class]
        forCellWithReuseIdentifier:@"YGoodFoundCell"];
    //section3
    [_mainV registerClass:[YGoodLikeCell class]
     forCellWithReuseIdentifier:@"YGoodLikeCell"];

//    [_mainV addFooterWithTarget:self action:@selector(loadMoreLikeData)];

}


- (void)getNavi{
    YFisrtSearchView *headV = [[YFisrtSearchView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:headV];
    headV.delegate = self;
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

#pragma mark ==更多==
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

//#pragma mark ==加载更多底部数据==
//-(void)loadMoreLikeData{
//  [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionAutoreverse animations:^{
//      [_mainV footerEndRefreshing];
//      [_mainV setFooterHidden:YES];
//      [_mainV setFooterHidden:NO];
//  } completion:nil];
//}

#pragma mark ==UICollectionDelegate And DataSource==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return  4;
    }else if (section == 1) {
        return _goodsTypes.count;
    }else if (section == 2){
        return 1;
    }else{
        return _mayLoves.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *goodCell = nil;
    if (indexPath.section ==0) {
        YADClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YADClassCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YADClassCell alloc]init];
        }
        YHeadClass *class =[[YHeadClass alloc]init];
        class.title = self.classArr[indexPath.row];
        class.imageName = self.imageArr[indexPath.row];
        cell.data = class;
        goodCell = cell;
    }else if (indexPath.section == 1) {
        YGoodClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodClassCell"
                                      forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodClassCell alloc]init];
        }
        YGoodClassModel *model = _goodsTypes[indexPath.row];
        cell.dataModel = model;
        goodCell = cell;
    }else if (indexPath.section == 2){
        YGoodFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodFoundCell"
                                      forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodFoundCell alloc]init];
        }
        cell.delegate = self;
        cell.dataArr = _foundGoods;
        goodCell = cell;
    }else if (indexPath.section == 3){
        YGoodLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodLikeCell"
                                      forIndexPath:indexPath];
        if (!cell) {
            cell = [[YGoodLikeCell alloc]init];
        }
        YGoodsModel *model = _mayLoves[indexPath.row];
        cell.dataModel = model;
        goodCell= cell;
    }
    return goodCell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV = nil;
    if (indexPath.section == 0) {
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
    }else if (indexPath.section ==1){
        if (kind == UICollectionElementKindSectionHeader) {
            YSectionHeadView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSectionHeadView" forIndexPath:indexPath];
            [headerV initTitle:@"商品分类专区" Image:@"Home_h1"];
            reuseV = headerV;
        }
        if (kind == UICollectionElementKindSectionFooter&&_hotImageArr.count) {
            YSectionBottomView *footerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YSectionBottomView" forIndexPath:indexPath];
            if (!footerV) {
                footerV = [[YSectionBottomView alloc]init];
            }
            footerV.imageArr = _foundsImageArr;
            footerV.delegate = self;
            reuseV = footerV;
        }
    }else if (indexPath.section == 2){
        if (kind == UICollectionElementKindSectionHeader) {
            YSectionHeadView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSectionHeadView" forIndexPath:indexPath];
            [headerV initTitle:@"发现好货" Image:@"Home_h2"];
            reuseV = headerV;
        }
        if (kind == UICollectionElementKindSectionFooter&&_hotImageArr.count) {
            YSectionBottomView *footerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YSectionBottomView" forIndexPath:indexPath];
            if (!footerV) {
                footerV = [[YSectionBottomView alloc]init];
            }
            footerV.imageArr = _hotImageArr;
            footerV.delegate = self;
            reuseV = footerV;
        }
    }else{
        if (kind == UICollectionElementKindSectionHeader) {
            YSectionHeadView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSectionHeadView" forIndexPath:indexPath];
            [headerV initTitle:@"猜你喜欢" Image:@"Home_h3"];
            reuseV = headerV;
        }
    }
    return reuseV;
}

//内容距离屏幕边缘的距离 参数顺序是top,left,bottom,right
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
        return UIEdgeInsetsZero;
}


//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 0;
    }
    if (section ==3) {
        return 4;
    }
    return 0;
}

//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 0;
    }
    if (section == 3) {
        return 4;
    }
    //选择类别
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 ) {
        return CGSizeMake(__kWidth/4, 105);
    }else if (indexPath.section == 1){
        return CGSizeMake((__kWidth-6)/4, 120);
    }else if (indexPath.section == 2){
        return CGSizeMake(__kWidth, 192);
    }else{
        return CGSizeMake((__kWidth-4)/2, 248);
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(__kWidth, 158*__kWidth/375);
    }else{
        return CGSizeMake(__kWidth, 30);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(__kWidth, 40);
    }else if (section == 1){
        if (_foundsImageArr.count) {
            return CGSizeMake(__kWidth, 85*__kWidth/375+5);
        }else{
            return CGSizeZero;
        }
    }else if (section==2){
        if (_hotImageArr.count) {
            return CGSizeMake(__kWidth, 85*__kWidth/375+5);
        }else{
            return CGSizeZero;
        }
    }else{
        return CGSizeZero;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"分类广告%ld",(long)indexPath.row);
        if (indexPath.row ==0) {
            YHotSaleViewController *vc = [[YHotSaleViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }if (indexPath.row == 1) {
            YNowPromotionViewController *vc = [[YNowPromotionViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            YPrintConsumablesViewController *vc = [[YPrintConsumablesViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==3){
            YClearanceViewController *vc = [[YClearanceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 1){
        NSLog(@"测试分类%ld",indexPath.row);
        YGoodClassModel *model = _goodsTypes[indexPath.row];
        YGoodFilterViewController *vc= [[YGoodFilterViewController alloc]init];
        vc.classId = model.classID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3){
        NSLog(@"推荐%ld",indexPath.row);
        YGoodsModel *model = _mayLoves[indexPath.row];
        YSGoodDetailViewController *vc= [[YSGoodDetailViewController alloc]init];
        vc.goodsId = model.goodId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ==YSectionBottomV Delegate==
-(void)chooseBottomV:(NSString *)url{
    if (!IsNilString(url)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ==SectionHeadView Delegate==
-(void)chooseAD:(NSString *)url{
    NSLog(@"选中头部广告");
    if (!IsNilString(url)) {
        YSADDetailViewController *vc = [[YSADDetailViewController alloc]init];
        vc.activityURL = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark ==YGoodFoundCell Delegate==
-(void)chooseTapView:(NSInteger)sender{
    NSLog(@"%ld", sender);
    YSGoodDetailViewController *vc= [[YSGoodDetailViewController alloc]init];
    YGoodsModel *model = _foundGoods[sender];
    vc.goodsId =model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
