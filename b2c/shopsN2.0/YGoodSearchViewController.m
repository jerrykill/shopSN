//
//  YGoodSearchViewController.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodSearchViewController.h"
#import "YSearchPushView.h"
#import "YHotSearchHeadView.h"
#import "YHistoryClearView.h"
#import "YSearchPushCell.h"
#import "JKHistory.h"
#import "YGoodFilterViewController.h"

@interface YGoodSearchViewController ()<YSearchPushViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YHistoryClearViewDelegate>

@property (strong,nonatomic) YSearchPushView *headV;

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) NSMutableArray *hotArr;

@property (strong,nonatomic) NSMutableArray *historyArr;

@end

@implementation YGoodSearchViewController

-(void)getdata{
    _historyArr = [JKHistory getHistory];
    [JKHttpRequestService POST:@"Index/hot_search" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _hotArr = [YSParseTool getParseSearchKeys:data];
            [_mainV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
    [self getdata];
    [_headV.searchTF becomeFirstResponder];
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
    [_headV.searchTF becomeFirstResponder];
}

-(void)getNavi{
    _headV = [[YSearchPushView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:_headV];
    if (!IsNilString(_search)) {
        _headV.searchTF.text = _search;
    }
    _headV.delegate = self;
}

-(void)initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64) collectionViewLayout:flowLayout];
    [self.view addSubview:_mainV];
    _mainV.backgroundColor = __BackColor;
    _mainV.delegate = self;
    _mainV.dataSource = self;

    [_mainV registerClass:[YSearchPushCell class] forCellWithReuseIdentifier:@"YSearchPushCell"];
    [_mainV registerClass:[YHotSearchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YHotSearchHeadView"];
    [_mainV registerClass:[YHistoryClearView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YHistoryClearView"];

}

-(void)setSearch:(NSString *)search{
  _search = search;
}

#pragma mark ==YSearchPushViewDelegate==
-(void)chooseBack{
    if (_isList) {
        NSMutableArray *vcArr = [NSMutableArray array];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[YGoodFilterViewController class]]) {
                YGoodFilterViewController *VC = (YGoodFilterViewController*)vc;
                [vcArr addObject:VC];
            }
        }
        if (vcArr.count>0) {
            YGoodFilterViewController *VC = vcArr.lastObject;
            [self.navigationController popToViewController:VC animated:NO];
            return;
        }
        YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
        vc.search = [JKHistory getHistory].lastObject;
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}



-(void)searchDid:(NSString *)text{
    [JKHistory Savetext:text];
    NSLog(@"%@",text);
    YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
    vc.search = text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==UICollectionViewDelegate==
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _hotArr.count;
    }else{
        return _historyArr.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSearchPushCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YSearchPushCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YSearchPushCell alloc]init];
    }
    if (indexPath.section ==0) {
        YSSearchKeyModel *model =_hotArr[indexPath.row];
        cell.title = model.name;
    }else{
    NSInteger index = _historyArr.count-indexPath.row-1;
     cell.title = _historyArr[index];
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseV = nil;
    if (indexPath.section == 0) {
        if (kind == UICollectionElementKindSectionHeader) {
            YHotSearchHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YHotSearchHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YHotSearchHeadView alloc]init];
            }
            header.image = @"search_hot";
            header.title = @"热门搜索";
            reuseV = header;
        }
    }else if(indexPath.section == 1){
        if (kind == UICollectionElementKindSectionHeader) {
            YHotSearchHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YHotSearchHeadView" forIndexPath:indexPath];
            if (!header) {
                header = [[YHotSearchHeadView alloc]init];
            }
            header.image = @"";
            header.title = @"历史搜索";
            reuseV = header;
        }
        if (kind == UICollectionElementKindSectionFooter){
            YHistoryClearView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YHistoryClearView" forIndexPath:indexPath];
            if (!footer) {
                footer = [[YHistoryClearView alloc]init];
            }
            footer.delegate = self;
            reuseV = footer;
        }
    }
    return reuseV;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
  }

//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((__kWidth-40)/3, 40);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(__kWidth, 50);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return CGSizeMake(__kWidth, 50);
    }else{
        return CGSizeZero;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        YSSearchKeyModel *model = _hotArr[indexPath.row];
        YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
        vc.classId = model.classId;
        [self.navigationController pushViewController:vc animated:NO];
    }
    if (indexPath.section ==1) {
        NSLog(@"%@",_historyArr[indexPath.row]);
        YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
        NSInteger index = _historyArr.count-indexPath.row-1;
        vc.search = _historyArr[index];
        [JKHistory Savetext:_historyArr[index]];
        _headV.searchTF.text =_historyArr[index];
        [self.navigationController pushViewController:vc animated:NO];
    }
   }

#pragma mark ==YHistoryClearViewDelegate==
-(void)clear{
    [JKHistory clearHistory];
    _historyArr = [JKHistory getHistory];
    [_mainV reloadData];
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
