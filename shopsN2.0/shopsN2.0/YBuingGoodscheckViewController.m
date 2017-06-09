//
//  YBuingGoodscheckViewController.m
//  shopsN
//
//  Created by imac on 2017/3/9.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBuingGoodscheckViewController.h"
#import "YSGoodSearchView.h"

@interface YBuingGoodscheckViewController ()<YSGoodSearchViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) YSGoodSearchView *searchV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (assign,nonatomic) NSInteger page;

@property (strong,nonatomic) NSString *searchs;

@end

@implementation YBuingGoodscheckViewController

#pragma mark ==翻页==
-(void)loadMore{
    _page++;
    WK(weakSelf)
    [JKHttpRequestService GET:@"Pcenter/searchGoods" withParameters:@{@"word":_searchs,@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            NSMutableArray *list = [YSParseTool getParseGoodsChoose:data];
            if (list.count<1) {
                [SXLoadingView showAlertHUD:@"暂无更多数据" duration:SXLoadingTime];
                strongSelf.page--;
            }
            [strongSelf.dataArr addObjectsFromArray:list];
            [strongSelf.tableV reloadData];
            [strongSelf.tableV footerEndRefreshing];
        }else{
            strongSelf.page--;
        }
    } failure:^(NSError *error) {

    } animated:NO];
}

#pragma mark ==搜索==
- (void)getSearchdata:(NSString*)sender{
    _searchs = sender;
    _page=1;
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService GET:@"Pcenter/searchGoods" withParameters:@{@"word":sender,@"p":[NSString stringWithFormat:@"%ld",_page],@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.dataArr = [YSParseTool getParseGoodsChoose:data];
            [strongSelf.tableV reloadData];
            if (strongSelf.dataArr.count<10) {
                [strongSelf.tableV setFooterHidden:YES];
            }else{
                [strongSelf.tableV setFooterHidden:NO];
            }
        }
    } failure:^(NSError *error) {
        [strongSelf.tableV setFooterHidden:YES];
    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _page =1;
    self.rightBtn.hidden=YES;
    self.title = @"商品筛选";
    [self initView];
}

-(void)initView{
    [self.view addSubview:self.searchV];
    [self.view addSubview:self.tableV];
}

#pragma mark ==懒加载==
-(YSGoodSearchView *)searchV{
    if (!_searchV) {
        _searchV = [[YSGoodSearchView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 60)];
        _searchV.delegate = self;
    }
    return _searchV;
}

-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 124, __kWidth, __kHeight-124)];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.backgroundColor = __BackColor;
        [_tableV addFooterWithTarget:self action:@selector(loadMore)];
        [_tableV setFooterHidden:YES];
    }
    return _tableV;
}

#pragma mark ==YSGoodSearchViewDelegate==
-(void)goodSearch:(NSString *)text{
    NSLog(@"%@",text);
    [self getSearchdata:text];
}

#pragma mark ==UItableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    YBuyingGoodModel *model =_dataArr[indexPath.row];
    cell.textLabel.font = MFont(16);
    cell.textLabel.textColor = LH_RGBCOLOR(150, 150, 150);
    cell.textLabel.text = model.goodName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YBuyingGoodModel *model =_dataArr[indexPath.row];
    [self.delegate chooseGood:model];
    [self.navigationController popViewControllerAnimated:YES];
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
