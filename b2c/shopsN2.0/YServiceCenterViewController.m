//
//  YServiceCenterViewController.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceCenterViewController.h"
#import "YServiceFirstHeadView.h"
#import "YServiceSecondHeadView.h"
#import "YServiceAutoCell.h"
#import "YServiceAskCell.h"
#import "YServiceAskModel.h"

#import "YReturnsViewController.h"
#import "YSalesManagementViewController.h"
#import "YFeedBackViewController.h"
#import "YInfoServiceViewController.h"
#import "ChatViewController.h"
#import "YSAnnouncementViewController.h"
#import "YSAnnounceDetailViewController.h"
#import "YServiceMessageViewController.h"

@interface YServiceCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YServiceFirstHeadViewDelegate,YServiceAskCellDelegate>

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) NSArray *imageArr;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSMutableArray *announceArr;//公告

@end

@implementation YServiceCenterViewController

- (void)getData {
    _titleArr= @[@"返修退换货",@"售后管理"];
    _imageArr = @[@"Service01",@"Service02"];

//    _dataArr = [NSMutableArray array];
//    YServiceAskModel *model1 = [[YServiceAskModel alloc]init];
//    model1.className= @"订单问题";
//    model1.titleArr = @[@"物流配送",@"售后咨询",@"退款问题",@"退货换货"];
//    [_dataArr addObject:model1];
//    YServiceAskModel *model2 = [[YServiceAskModel alloc]init];
//    model2.className= @"购物问题";
//    model2.titleArr = @[@"订单修改",@"选购商品",@"结算支付",@"活动咨询"];
//    [_dataArr addObject:model2];
//    YServiceAskModel *model3 = [[YServiceAskModel alloc]init];
//    model3.className= @"其他问题";
//    model3.titleArr = @[@"财务问题",@"账户问题",@"活动&购买",@"满返满赠介绍"];
//    [_dataArr addObject:model3];


    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [JKHttpRequestService POST:@"Callcenter/Announcement" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSArray *data = jsonDic[@"data"];
                strongSelf.announceArr = [YSParseTool getParseAnnounce:data];
                [_mainV reloadData];

            }
        } failure:^(NSError *error) {

        } animated:NO];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [JKHttpRequestService GET:@"Pcenter/article" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSMutableArray *data = jsonDic[@"data"];
                _dataArr = [YSParseTool getParseServiceTitles:data];
                 [_mainV reloadData];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服中心";

    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-74, 30, 23, 24)];
    [self.headV addSubview:searchBtn];
    [searchBtn setImage:MImage(@"head_search") forState:BtnNormal];
    [searchBtn addTarget:self action:@selector(searchQuestion) forControlEvents:BtnTouchUpInside];
    [self.rightBtn setImage:MImage(@"head_service") forState:BtnNormal];
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [self getData];
       dispatch_async(dispatch_get_main_queue(), ^{
           [self initView];
       });
   });
 
}


- (void)initView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _mainV = [[UICollectionView alloc]
              initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)
              collectionViewLayout:flowLayout];
    [self.view addSubview:_mainV];
    _mainV.backgroundColor = __BackColor;
    _mainV.delegate = self;
    _mainV.dataSource = self;
    //section 0
    [_mainV registerClass:[YServiceFirstHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YServiceFirstHeadView"];
    [_mainV registerClass:[YServiceAutoCell class] forCellWithReuseIdentifier:@"YServiceAutoCell"];

    //section 1
    [_mainV registerClass:[YServiceSecondHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YServiceSecondHeadView"];
    [_mainV registerClass:[YServiceAskCell class] forCellWithReuseIdentifier:@"YServiceAskCell"];
}

#pragma mark ==搜索==
- (void)searchQuestion {
    YInfoServiceViewController *vc =[[YInfoServiceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chooseRight {
    ChatViewController *vc = [[ChatViewController alloc]initWithConversationChatter:HXchatter conversationType:eConversationTypeChat];
    YNavigationController *navi = [[YNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navi animated:NO completion:nil];
}

#pragma mark ==UICollectionViewDelegate ==
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else{
        return _dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cells =nil;
    if (indexPath.section==0) {
        YServiceAutoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YServiceAutoCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YServiceAutoCell alloc]init];
        }
        cell.title =_titleArr[indexPath.row];
        cell.imageName = _imageArr[indexPath.row];
        cells= cell;
    }else{
        YServiceAskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YServiceAskCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YServiceAskCell alloc]init];
        }
        YServiceAskModel *model = _dataArr[indexPath.row];
        cell.tag = indexPath.row;
        cell.title =model.className;
        cell.titleArr = model.titleArr;
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView  *reuseV;
    if (indexPath.section==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            YServiceFirstHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YServiceFirstHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YServiceFirstHeadView alloc]init];
            }
            header.titleArr =_announceArr;
            header.delegate = self;
            reuseV=header;
        }
    }else if (indexPath.section==1){
        if (kind == UICollectionElementKindSectionHeader) {
            YServiceSecondHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YServiceSecondHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YServiceSecondHeadView alloc]init];
            }
            reuseV = header;
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
    if (section==0) {
        return 1;
    }else{
        return 0;
    }
}

//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return CGSizeMake((__kWidth-2)/3, 116);
    }else{
        if (indexPath.row==_dataArr.count-1) {
            return CGSizeMake(__kWidth, 102);
        }else{
            return CGSizeMake(__kWidth, 92);
        }
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(__kWidth, 85);
    }else{
        return CGSizeMake(__kWidth, 45);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            YReturnsViewController *vc = [[YReturnsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            YSalesManagementViewController *vc = [[YSalesManagementViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
}


#pragma mark ==YServiceFirstHeadViewDelegate==
- (void)getMore {
    NSLog(@"更多");
    YSAnnouncementViewController *vc = [[YSAnnouncementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chooseWarnIndex:(NSInteger)index {

    YWarnModel *model = _announceArr[index-33];
    NSLog(@"%@",model.warnId);
    YSAnnounceDetailViewController *vc = [[YSAnnounceDetailViewController alloc]init];
    vc.warnId = model.warnId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YServiceAskCellDelegate==
- (void)getQuestion:(NSInteger)type index:(NSInteger)index {
    YServiceAskModel *model = _dataArr[type];
    YServiceTitleModel *titles = model.titleArr[index];
    YServiceMessageViewController *vc = [[YServiceMessageViewController alloc]init];
    vc.model = titles;
    [self.navigationController pushViewController:vc animated:YES];
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
