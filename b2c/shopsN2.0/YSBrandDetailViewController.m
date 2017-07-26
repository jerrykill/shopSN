//
//  YSBrandDetailViewController.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandDetailViewController.h"
#import "YGoodsFilterView.h"
#import "YSBrandDetailHeadView.h"
#import "YSBrandGoodCell.h"
#import "YSGoodDetailViewController.h"

@interface YSBrandDetailViewController ()<YGoodsFilterViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) YSBrandDetailHeadView *brandV;

@property (strong,nonatomic) YGoodsFilterView *checkV;

@property (strong,nonatomic) UITableView *mainV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *type;

@property (strong,nonatomic) YSBrandModel *dataModel;

@property (assign,nonatomic) NSInteger page;

@end

@implementation YSBrandDetailViewController

- (void)getdata {
    [JKHttpRequestService POST:@"Brand/brandDetail" withParameters:@{@"id":_brandId,@"sort":_type} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            _dataModel = [YSParseTool getParseBrandDetail:data[@"brand"]];
            _dataArr = [YSParseTool getparseBrandDetailGoods:data[@"goods"]];
            if (!_brandV.model) {
                _brandV.model = _dataModel;
                self.title = _dataModel.detailName;
            }
            _mainV.contentOffset = CGPointMake(0, 0);
            [_mainV reloadData];
            if (_dataArr.count<10) {
                [_mainV reloadData];
            }

        }else{
            [_mainV.footer setState:MJRefreshFooterStateNoMoreData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _brandName;
    _page=1;
    _type = @"";
    [self getdata];

    [self initView];
}

- (void)initView {
    [self.view addSubview:self.brandV];
    [self.view addSubview:self.checkV];
    [self.view addSubview:self.mainV];


}

- (YSBrandDetailHeadView *)brandV {
    if (!_brandV) {
        _brandV = [[YSBrandDetailHeadView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, AutoWidth(160))];

    }
    return _brandV;
}

- (YGoodsFilterView *)checkV {
    if (!_checkV) {
        _checkV = [[YGoodsFilterView alloc]initWithFrame:CGRectMake(0, CGRectYH(_brandV), __kWidth, 40)];
        _checkV.delegate = self;
    }
    return _checkV;
}

- (UITableView *)mainV {
    if (!_mainV) {
        _mainV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_checkV), __kWidth, __kHeight-64-AutoWidth(160)-40)];
        _mainV.delegate = self;
        _mainV.dataSource = self;
        _mainV.backgroundColor = __BackColor;
        _mainV.separatorColor = [UIColor clearColor];
        [_mainV addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }
    return _mainV;
}

#pragma mark ==YGoodsFilterViewDelegate==
- (void)chooseType:(NSInteger)sender {
    _page = 1;
    switch (sender) {
        case 0:
        {
            _type = @"1";
        }
            break;
        case 1:
        {
            _type = @"3";

        }
            break;
        case 2:
        {
            _type = @"4";
        }
            break;
        case 3:
        {
            _type = @"5";
        }
            break;
        default:
            break;
    }
    [self getdata];
}


#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSBrandGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSBrandGoodCell"];
    if (!cell) {
        cell = [[YSBrandGoodCell alloc]init];
    }
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoWidth(130);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YGoodsModel *model = _dataArr[indexPath.row];
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    vc.goodsId = model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)loadMore {
    _page++;
    [JKHttpRequestService POST:@"Brand/brandDetail" withParameters:@{@"id":_brandId,@"sort":_type,@"page":[NSString stringWithFormat:@"%ld",_page]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
           NSMutableArray *list = [YSParseTool getparseBrandDetailGoods:data[@"goods"]];
            for (YGoodsModel *model in list) {
                [_dataArr addObject:model];
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
