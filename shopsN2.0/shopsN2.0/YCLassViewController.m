//
//  YCLassViewController.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCLassViewController.h"
#import "SearchHeadView.h"
#import "YClassCell.h"
#import "YClassThreeCell.h"
#import "YClassSectionView.h"
#import "YCLassModel.h"
#import "YGoodSearchViewController.h"
#import "YGoodFilterViewController.h"
#import "YSAnnouncementViewController.h"
#import "YSCLassLeftView.h"

@interface YCLassViewController ()<SearchHeadViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YSCLassLeftViewDelegate>

@property (strong,nonatomic) SearchHeadView *headV;

@property (strong,nonatomic) YSCLassLeftView *classLeftV;

@property (strong,nonatomic) UICollectionView *classV;

@property (strong,nonatomic) NSMutableArray *leftArr;

@property (strong,nonatomic) NSMutableArray *rightArr;

@property (strong,nonatomic) NSString *chooseClass;

@end

@implementation YCLassViewController

-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
   [JKHttpRequestService POST:@"class/navigation" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           strongSelf.leftArr = [YSParseTool getParseClassOne:jsonDic[@"data"]];
           strongSelf.classLeftV.dataArr = _leftArr;
           YCLassModel *model =_leftArr.firstObject;
           [weakSelf getCLass:model.classId];
       }
      } failure:^(NSError *error) {
//        NSLog(@"%@",error.description);
//        [strongSelf getdata];
    } animated:NO];
}

-(void)getCLass:(NSString *)classId{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"class/category" withParameters:@{@"fid":classId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            strongSelf.rightArr = [YSParseTool getParseClassTwo:jsonDic[@"data"]];
            [strongSelf.classV reloadData];
            strongSelf.classV.contentOffset = CGPointMake(0, 0);
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self getNavi];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });

}

- (void)getNavi{
    _headV = [[SearchHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:_headV];
    _headV.delegate = self;
    _headV.isEdit = NO;
    [_headV.messageBtn setImage:MImage(@"head_news") forState:BtnNormal];

}

- (void)initView{
    [self.view addSubview:self.classLeftV];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _classV = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectXW(_classLeftV), 64, 570*__kWidth/750, __kHeight-64-50) collectionViewLayout:flowLayout];
    [self.view addSubview:_classV];
    _classV.backgroundColor = __BackColor;
    _classV.delegate = self;
    _classV.dataSource = self;
    [_classV registerClass:[YClassThreeCell class] forCellWithReuseIdentifier:@"YClassThreeCell"];
    [_classV registerClass:[YClassSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YClassSectionView"];

}

- (YSCLassLeftView *)classLeftV {
    if (!_classLeftV) {
        _classLeftV = [[YSCLassLeftView alloc]initWithFrame:CGRectMake(0, 64, 180*__kWidth/750, __kHeight-64-50)];
        _classLeftV.delegate = self;
        _classLeftV.backgroundColor = __BackColor;
    }
    return _classLeftV;
}


#pragma mark ==SearchHeadViewDelegate==
-(void)lookMessage{
    NSLog(@"看消息");
    YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)searchBegin{
    YGoodSearchViewController *vc = [[YGoodSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark ==YSCLassLeftViewDelegate==
- (void)chooseClassOne:(NSString *)classId{
    [self getCLass:classId];

}

#pragma mark ==UICOLlectionView Delegate and Datasource==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _rightArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    YClassTwoModel *model = _rightArr[section];
    return model.array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YClassThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YClassThreeCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YClassThreeCell alloc]init];
    }
    YClassTwoModel *model = _rightArr[indexPath.section];
    YClassThreeModel *data = model.array[indexPath.row];
    cell.model = data;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((__kWidth*570/750-20)/3, (__kWidth*570/750-20)*22/(3*17));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV= nil;
    if (kind == UICollectionElementKindSectionHeader) {
        YClassSectionView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YClassSectionView" forIndexPath:indexPath];
        if (!headerV) {
            headerV = [[YClassSectionView alloc]init];
        }
        YClassTwoModel *model = _rightArr[indexPath.section];
        headerV.title = model.sectionName;
        reuseV = headerV;
    }
    return reuseV;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(__kWidth*570/750, 35);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YClassTwoModel *model = _rightArr[indexPath.section];
    YClassThreeModel *data = model.array[indexPath.row];
    NSLog(@"%@",data.classId);
    YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
    vc.classId = data.classId;
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
