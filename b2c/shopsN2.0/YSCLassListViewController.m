//
//  YSCLassListViewController.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSCLassListViewController.h"
#import "YGoodLikeCell.h"
#import "YSGoodDetailViewController.h"

@interface YSCLassListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *mainV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *postKey;

@property (assign,nonatomic) NSInteger page;

@end

@implementation YSCLassListViewController

- (void)setClassName:(NSString *)className {
    _className = className;
    if ([_className isEqualToString:@"家用电器"]) {
        _postKey = @"Index/appliances";
        [self getdata:@"Index/appliances"];
    }else if ([_className isEqualToString:@"手机数码"]) {
        _postKey = @"Index/phone_digital";
        [self getdata:@"Index/phone_digital"];
    }else{
        _postKey = @"Index/computerOffice";
        [self getdata:@"Index/computerOffice"];
    }
}

- (void)getdata:(NSString*)key {
    [JKHttpRequestService POST:key withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            _dataArr = [YSParseTool getParseGoodLoves:data];
            [_mainV reloadData];
            if (_dataArr.count<10) {
                [_mainV.footer setState:MJRefreshFooterStateNoMoreData];
            }
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _className;
    _page = 1;
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.mainV];

    [_mainV registerClass:[YGoodLikeCell class] forCellWithReuseIdentifier:@"YGoodLikeCell"];


    [_mainV addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

}

- (UICollectionView *)mainV {
    if (!_mainV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _mainV = [[UICollectionView alloc]
                  initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)
                  collectionViewLayout:flowLayout];
        _mainV.backgroundColor = __BackColor;
        _mainV.delegate = self;
        _mainV.dataSource = self;
    }
    return _mainV;
}

- (void)loadMore {
    _page++;
    [JKHttpRequestService POST:_postKey withParameters:@{@"page":[NSString stringWithFormat:@"%ld",_page]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            NSMutableArray *list = [YSParseTool getParseGoodLoves:data];
            if (list.count) {
                for (YGoodsModel*model in list) {
                    [_dataArr addObject:model];
                }
            }
            [_mainV reloadData];
            [_mainV.footer endRefreshing];
            if (list.count<10) {
                [_mainV.footer setState:MJRefreshFooterStateNoMoreData];
            }
        }else{
            _page--;
            [_mainV.footer setState:MJRefreshFooterStateNoMoreData];
        }
    } failure:^(NSError *error) {

    } animated:NO];
}


#pragma mark ==UICollectionViewDelegate==
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YGoodLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YGoodLikeCell"
                                                                    forIndexPath:indexPath];
    if (!cell) {
        cell = [[YGoodLikeCell alloc]init];
    }
    YGoodsModel *model = _dataArr[indexPath.row];
    cell.dataModel = model;
    return cell;
}

//内容距离屏幕边缘的距离 参数顺序是top,left,bottom,right
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  return CGSizeMake((__kWidth-4)/2, 248);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YGoodsModel *model = _dataArr[indexPath.row];
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    vc.goodsId = model.goodId;
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
