//
//  YGoodFilterViewController.m
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodFilterViewController.h"
#import "YFilterHeadView.h"
#import "YGoodsFilterView.h"
#import "YGoodCell.h"
#import "YGoodSearchViewController.h"
#import "YGoodShareView.h"
#import "JKHistory.h"
#import "YSGoodDetailViewController.h"

@interface YGoodFilterViewController ()<YGoodsFilterViewDelegate,YFilterHeadViewDelegate,UITableViewDelegate,UITableViewDataSource,YGoodCellDelegate,YPopViewDelegate,YGoodShareViewDelegate>

@property (strong,nonatomic) YGoodsFilterView *ygoodFilterV;

@property (strong,nonatomic) YFilterHeadView *headV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) YGoodShareView *shareV;

@property (strong,nonatomic) YGoodsModel *shareModel;

@property (assign,nonatomic) NSInteger page;

@property (strong,nonatomic) NSString *type;


@end

@implementation YGoodFilterViewController

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



- (void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if (!IsNilString(_classId)) {
        [JKHttpRequestService GET:@"goods/listByclass" withParameters:@{@"class_id":_classId,@"page":@"1",@"sort":_type} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSDictionary *dic = jsonDic[@"data"];
                strongSelf.dataArr = [YSParseTool getParseFilterGood:dic[@"goods"]];

                [strongSelf.tableV reloadData];
                [strongSelf.tableV.footer endRefreshing];
                if (strongSelf.dataArr.count<10) {
                    strongSelf.tableV.footer.state=MJRefreshFooterStateNoMoreData;
                }
            }else{
                _page--;
                [strongSelf.tableV.footer endRefreshing];
                [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
            }

        } failure:^(NSError *error) {
        } animated:YES];
    }else if (!IsNilString(_likeID)){
        [JKHttpRequestService GET:@"Pcenter/brother" withParameters:@{@"goods_id":_likeID,@"sort":_type} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSDictionary *dic = jsonDic[@"data"];
                strongSelf.dataArr = [YSParseTool getParseFilterGood:dic];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV.footer endRefreshing];
                if (strongSelf.dataArr.count<10) {
                    strongSelf.tableV.footer.state=MJRefreshFooterStateNoMoreData;
                }
            }else{
                [strongSelf.tableV.footer endRefreshing];
                [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    }else if(!IsNilString(_search)){
        [JKHttpRequestService GET:@"Index/keyWordSearch" withParameters:@{@"keyword":_search,@"p":@"1",@"sort":_type} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSDictionary *dic = jsonDic[@"data"];
                strongSelf.dataArr = [YSParseTool getParseFilterGoodSearch:dic];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV.footer endRefreshing];
                if (strongSelf.dataArr.count<10) {
                    strongSelf.tableV.footer.state=MJRefreshFooterStateNoMoreData;
                }

            }else{
                [strongSelf.tableV.footer endRefreshing];
                [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
            }
        } failure:^(NSError *error) {

        } animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _type = @"";
    _page =1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });
    [self clearNavi];
    [self getNavi];
}

- (void)clearNavi{//清理navi便于跳转逻辑
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    NSInteger vcCount = vcs.count;
    if ([vcs[vcCount-2] isKindOfClass:[YGoodSearchViewController class]]) {
        [vcs removeObjectAtIndex:vcCount-2];
        self.navigationController.viewControllers = vcs;
    }

}

-(void)getNavi{
    _headV = [[YFilterHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
    [self.view addSubview:_headV];
    _headV.title = _search;
    _headV.isEdit = NO;
    _headV.delegate = self;
}

-(void)initView{

     
    _ygoodFilterV = [[YGoodsFilterView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 44)];
    [self.view addSubview:_ygoodFilterV];
    _ygoodFilterV.delegate = self;

    _tableV = [[BaseTableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_ygoodFilterV), __kWidth, __kHeight-64-44)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;

    [_tableV addFooterWithTarget:self action:@selector(reloadMoreData)];
}

#pragma mark ==加载更多数据==
-(void)reloadMoreData{
    if ((_dataArr.count-_page*10)<10) {
        [SXLoadingView showAlertHUD:@"没有更多数据了" duration:1];
        [_tableV footerEndRefreshing];
        [_tableV setFooterHidden:YES];
        [_tableV setFooterHidden:NO];
    }else{
        WK(weakSelf)
        __typeof(&*weakSelf) strongSelf = weakSelf;
        _page++;
        if (!IsNilString(_classId)) {
            [JKHttpRequestService GET:@"goods/listByclass" withParameters:@{@"class_id":_classId,@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"sort":_type} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
                if (succe) {
                    NSArray *dic = jsonDic[@"data"];
                    NSMutableArray *list = [YSParseTool getParseFilterGood:dic];
                    if (list.count==0) {
                        [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
                    }else{
                        for (YGoodsModel *model in list) {
                            [strongSelf.dataArr addObject:model];
                         }
                        [strongSelf.tableV reloadData];
                        [strongSelf.tableV footerEndRefreshing];
                        [strongSelf.tableV setFooterHidden:YES];
                        if (strongSelf.dataArr.count>=10) {
                             [strongSelf.tableV setFooterHidden:NO];
                         }
                    }
                }else{
                    [strongSelf.tableV.footer endRefreshing];
                    strongSelf.tableV.footer.state=MJRefreshFooterStateNoMoreData;
                    strongSelf.page--;
                }
            } failure:^(NSError *error) {
                
            } animated:YES];
        }else if (!IsNilString(_search)){
            [JKHttpRequestService GET:@"Index/keyWordSearch" withParameters:@{@"keyword":_search,@"p":[NSString stringWithFormat:@"%ld",_page],@"sort":_type} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
                if (succe) {
                    NSArray *dic = jsonDic[@"data"];
                    NSMutableArray *list = [YSParseTool getParseFilterGoodSearch:dic];
                    if (list.count==0) {
                        [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
                    }else{
                        for (YGoodsModel *model in list) {
                            [strongSelf.dataArr addObject:model];
                        }
                        [strongSelf.tableV reloadData];
                        [strongSelf.tableV footerEndRefreshing];
                        [strongSelf.tableV setFooterHidden:YES];
                        if (strongSelf.dataArr.count>10) {
                            [strongSelf.tableV setFooterHidden:NO];
                        }
                    }
                }else{
                    [strongSelf.tableV.footer endRefreshing];
                    [strongSelf.tableV.footer setState:MJRefreshFooterStateNoMoreData];
                    strongSelf.page--;
                }
            } failure:^(NSError *error) {
                
            } animated:YES];
        }
    }

}

#pragma mark ==YGoodsFilterViewDelegate==
-(void)chooseType:(NSInteger)sender{
    NSLog(@"筛选:%ld",sender);
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
    _page=1;
    _tableV.contentOffset= CGPointMake(0, 0);
    [self getdata];

}

#pragma mark ==YFilterHeadViewDelegate==
-(void)lookMore{
    NSArray *list = @[@"首页",@"消息"];
    NSArray *images =@[@"home",@"news"];
    _popV = [[YPopView alloc]initWithFrame:CGRectMake(__kWidth-40, 8, __kWidth, __kHeight-60) title:list image:images];
    [self.view addSubview:_popV];
    _popV.delegate = self;
    _popV.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:_popV];
    
}

-(void)makeBack{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark ==YPopViewDelegate==
-(void)chooseIndex:(NSInteger)index{
    if (index==0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
            tab.selectIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else{
        NSLog(@"查看消息");
        YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)searchBegin{
       YGoodSearchViewController *vc = [[YGoodSearchViewController alloc]init];
       vc.isList = YES;
        vc.search = _headV.searchTF.text;
       [self.navigationController pushViewController:vc animated:NO];

}


#pragma mark ==UITableViewDelegate and Datasource==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGoodCell"];
    if (!cell) {
        cell = [[YGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGoodCell"];
    }
    cell.tag = indexPath.row;
    YGoodsModel *model = _dataArr[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    YSGoodDetailViewController *vc = [[YSGoodDetailViewController alloc]init];
    YGoodsModel *model = _dataArr[indexPath.row];
    vc.goodsId = model.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==YGoodCellDelegate==
-(void)GoodListAction:(NSInteger)sender index:(NSInteger)tag{
    YGoodsModel *model = _dataArr[tag];
    _shareModel =model;
    switch (sender) {
        case 0:
        {
            _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
            [self.view addSubview:_shareV];
            _shareV.delegate = self;
            _shareV.goodID = model.goodId;
        }
            break;
        case 1:
        {
            if (IsNilString([UdStorage getObjectforKey:Userid])) {
                YSLoginViewController *vc = [[YSLoginViewController alloc]init];
                BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
                [self presentViewController:navi animated:YES completion:nil];
                return;
            }
            NSLog(@"加入购物车");
            [YGoodCollectAndCartService MakeGoodShopCart:@{@"goods_id":_shareModel.goodId,@"goods_num":@"1",@"price_new":_shareModel.goodMoney,@"app_user_id":[UdStorage getObjectforKey:Userid]}];
        }
            break;
        case 2:
        {
            NSLog(@"找相似");
            YGoodFilterViewController *vc = [[YGoodFilterViewController alloc]init];
//            vc.search = [NSString stringWithFormat:@"%@%ld",_shareModel.goodTitle,tag];
            vc.likeID = _shareModel.goodId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark ==YGoodShareViewDelegate==
-(void)shareType:(NSInteger)sender Url:(NSString *)goodID{
    NSLog(@"分享%ld",sender);
    [YShareTool shareMessage:@"商品信息" title:@"测试" Url:[NSString stringWithFormat:@"%@%@.html",ShareGoodRoot,goodID] type:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_popV removeFromSuperview];
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
