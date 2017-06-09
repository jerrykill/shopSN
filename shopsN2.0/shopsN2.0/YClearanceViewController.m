//
//  YClearanceViewController.m
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClearanceViewController.h"
#import "YSecondSearchView.h"
#import "YClearanceTimeView.h"
#import "YClearanceOneCell.h"
#import "YClearanceTwoCell.h"
#import "YClearanceThreeCell.h"
#import "YPrintBOXCell.h"
#import "YPrintHotCell.h"
#import "YClearanceTitleHeadView.h"
#import "YSectionBottomView.h"
#import "YGoodSearchViewController.h"
#import "YSGoodDetailViewController.h"
#import "YGoodFilterViewController.h"
#import "YPopView.h"

@interface YClearanceViewController ()<YSecondSearchViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YPopViewDelegate,YClearanceTimeViewDelegate,YSectionBottomViewDelegate,YPrintBOXCellDelegate>

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) NSArray *list;

@property (strong,nonatomic) NSArray *images;

@property (strong,nonatomic) NSMutableArray *headAdArr;//头部广告

@property (strong,nonatomic) NSMutableArray *activityArr;//活动数组

@property (strong,nonatomic) NSMutableArray *classArr;//尾货清仓

@property (strong,nonatomic) NSMutableArray *lastArr;//最后清仓

@property (strong,nonatomic) NSString *endTime;

@property (strong,nonatomic) NSMutableArray *hotImgArr;//广告数组

@end

@implementation YClearanceViewController

- (void)getdata {
   [JKHttpRequestService POST:@"Index/poopClear" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           NSDictionary *data = jsonDic[@"data"];
           _headAdArr = [YSParseTool getParseAD:data[@"top_img"]];
           _activityArr = [YSParseTool getParseHotGoods:data[@"activity"]];
           NSArray *list = data[@"activity"];
           NSDictionary *dic = list.firstObject;
           _endTime = dic[@"time"];
           _classArr = [YSParseTool getParseClearance:data[@"poopClear"]];
           _lastArr = [YSParseTool getParseHotGoods:data[@"last_clear"]];
           _hotImgArr = [YSParseTool getParseAD:data[@"poopClear_ad"]];
           [_mainV reloadData];
       }
   } failure:^(NSError *error) {

   } animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
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

    //section0
    [_mainV registerClass:[YPrintBOXCell class]
            forCellWithReuseIdentifier:@"YPrintBOXCell"];
    [_mainV registerClass:[YClearanceTimeView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:@"YClearanceTimeView"];
     //section1
    [_mainV registerClass:[YClearanceOneCell class]
            forCellWithReuseIdentifier:@"YClearanceOneCell"];
    [_mainV registerClass:[YClearanceTwoCell class]
            forCellWithReuseIdentifier:@"YClearanceTwoCell"];
    [_mainV registerClass:[YClearanceThreeCell class]
            forCellWithReuseIdentifier:@"YClearanceThreeCell"];
    [_mainV registerClass:[YClearanceTitleHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YClearanceTitleHeadView"];
    //section2
    [_mainV registerClass:[YPrintHotCell class]
            forCellWithReuseIdentifier:@"YPrintHotCell"];
    [_mainV registerClass:[YSectionBottomView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YSectionBottomView"];


}
#pragma mark == YSecondSearchViewDelegate==

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
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return  1;
    }else if (section == 1){
        return _classArr.count;
    }else{
        return _lastArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cells= [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        YPrintBOXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPrintBOXCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPrintBOXCell alloc]init];
        }
        cell.delegate = self;
        cell.goodArr = _activityArr;
        cells = cell;
    }else if (indexPath.section == 1){
         YGoodsModel *model = _classArr[indexPath.row];
        if (indexPath.row ==0 ||indexPath.row == 1) {
            YClearanceOneCell *cell = [collectionView
                            dequeueReusableCellWithReuseIdentifier:@"YClearanceOneCell"
                                    forIndexPath:indexPath];
            if (!cell) {
                cell = [[YClearanceOneCell alloc]init];
            }
            if (indexPath.row == 1) {
                cell.logoBtn.hidden = YES;
            }
            cell.model = model;
            cells = cell;
            }else if (indexPath.row==2||indexPath.row==3){
               YClearanceThreeCell *cell = [collectionView
                  dequeueReusableCellWithReuseIdentifier:@"YClearanceThreeCell" forIndexPath:indexPath];
                   if (!cell) {
                cell = [[YClearanceThreeCell alloc]init];
            }
            if (indexPath.row==2) {
                cell.logoBtn.hidden = YES;
            }
            cell.model = model;
            cells = cell;
        }else{
            YClearanceTwoCell *cell = [collectionView
                            dequeueReusableCellWithReuseIdentifier:@"YClearanceTwoCell"
                                       forIndexPath:indexPath];
            if (!cell) {
                cell = [[YClearanceTwoCell alloc]init];
            }
             cell.tag = indexPath.row-4;
//            YGoodsModel *model = [[YGoodsModel alloc]init];
//            model.goodTitle = @"长尾票夹";
//            model.goodDesc = @"您的办公神器";
            cell.model = model;
            cell.disCount = @"5折";
            cells = cell;
        }
    }else{
        YPrintHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPrintHotCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YPrintHotCell alloc]init];
        }

//        YGoodsModel *model = [[YGoodsModel alloc]init];
//        model.goodTitle = @"得力 6606 思达中性笔";
//        model.goodMoney = @"10.00";
//        model.goodUrl = @"";
        YGoodsModel *model = _lastArr[indexPath.row];
        cell.model = model;
        cells = cell;
    }
    return cells;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV = [[UICollectionReusableView alloc]init];;
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            YClearanceTimeView *headV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YClearanceTimeView" forIndexPath:indexPath];
            if (!headV) {
                headV = [[YClearanceTimeView alloc]init];
            }
//            NSMutableArray *headArr =[NSMutableArray array];
//            for (int i =0; i<3; i++) {
//                YHeadImage *head = [[YHeadImage alloc]init];
//                head.imageName = @"";
//                head.imageUrl = @"";
//                [headArr addObject:head];
//            }
            headV.imageArr = _headAdArr;
            headV.time = _endTime;
            reuseV = headV;
        }
    }else if (indexPath.section ==1){
        if (kind == UICollectionElementKindSectionHeader) {
            YClearanceTitleHeadView *headV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YClearanceTitleHeadView" forIndexPath:indexPath];
            if (!headV) {
                headV = [[YClearanceTitleHeadView alloc]init];
            }
            headV.title = @"尾货清仓";
            reuseV = headV;
        }else if (kind == UICollectionElementKindSectionFooter){
            YSectionBottomView *footer =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YSectionBottomView" forIndexPath:indexPath];
            if (!footer) {
                footer = [[YSectionBottomView alloc]init];
            }
            footer.delegate = self;
//            NSMutableArray *imagArr = [NSMutableArray array];
//            for (int i =0; i<2; i++) {
//                YHeadImage *image = [[YHeadImage alloc]init];
//                image.imageUrl = @"";
//                image.imageName = @"";
//                [imagArr addObject:image];
//            }
            footer.imageArr = _hotImgArr;
            reuseV = footer;
        }
    }else{
        if (kind == UICollectionElementKindSectionHeader) {
            YClearanceTitleHeadView *headV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YClearanceTitleHeadView" forIndexPath:indexPath];
            if (!headV) {
                headV = [[YClearanceTitleHeadView alloc]init];
            }
            headV.title = @"最后清仓";
            reuseV = headV;
        }
    }
    return reuseV;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

//y
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section ==1){
        return 1;
    }else{
        return 4;
    }
}

//x
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 1;
    }else{
        return 4;
    }
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return CGSizeMake(__kWidth, 190);
    }else if (indexPath.section == 1){
        if (indexPath.row ==0||indexPath.row==1||indexPath.row==2||indexPath.row==3) {
            return CGSizeMake((__kWidth-1)/2, 106);
        }else{
            return CGSizeMake((__kWidth-3)/4, 130);
        }
    }else{
       return CGSizeMake((__kWidth-4)/2, 250);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(__kWidth, 158*__kWidth/375+40);
    }else{
        return CGSizeMake(__kWidth, 42);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 1) {
        if (_hotImgArr.count) {
            return CGSizeMake(__kWidth, 85*__kWidth/375+5);
        }else{
            return CGSizeZero;
        }
    }else{
        return CGSizeZero;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSLog(@"尾货商品%ld",indexPath.row);
        YGoodsModel *model = _classArr[indexPath.row];
        [self pushGood:model.goodId];
    }else if (indexPath.section == 2){
        YGoodsModel *model = _lastArr[indexPath.row];
        [self pushGood:model.goodId];
    }
}

#pragma mark ==YPrintBOXCellDelegate==
-(void)chooseGood:(YGoodsModel *)model{
    [self pushGood:model.goodId];
}

#pragma mark ==YClearanceTimeViewDelegate==
-(void)chooseAD:(NSString *)url{
    NSLog(@"选择广告");
}

#pragma mark ==YSectionBottomViewDelegate==
-(void)chooseBottomV:(NSString *)url{
    NSLog(@"选中底部广告");
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
