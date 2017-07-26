//
//  YSBrandListViewController.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandListViewController.h"
#import "YBillSearchNaviView.h"
#import "YSBrandClassCell.h"
#import "YSBrandSectionHeadView.h"

#import "YSBrandDetailViewController.h"

@interface YSBrandListViewController ()<YBillSearchNaviViewDelegate,YPopViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) YBillSearchNaviView *naviView;

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) UITableView *mainV;

@property (strong,nonatomic) NSMutableArray *sectionArr;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YSBrandListViewController

- (void)getdata {
    [JKHttpRequestService POST:@"brand/brandList" withParameters:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *dic =jsonDic[@"data"];
            _dataArr = [YSParseTool getParseBrandList:dic];
            for (YSBrandListModel *model in _dataArr) {
                [self.sectionArr addObject:model.sectionName];
            }
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
    [self.view addSubview:self.naviView];
    [self getdata];
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.mainV];
}

- (YBillSearchNaviView *)naviView {
    if (!_naviView) {
        _naviView = [[YBillSearchNaviView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 64)];
        _naviView.delegate = self;
        NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"搜索品牌"];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
        _naviView.searchTF.attributedPlaceholder = attr;
    }
    return _naviView;
}

- (UITableView *)mainV {
    if (!_mainV) {
        _mainV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
        _mainV.delegate = self;
        _mainV.dataSource = self;
        _mainV.backgroundColor = __BackColor;
        _mainV.sectionIndexColor = LH_RGBCOLOR(92, 200, 100);
        _mainV.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _mainV;
}

- (NSMutableArray *)sectionArr {
    if (!_sectionArr) {
        _sectionArr = [NSMutableArray array];
//        _sectionArr = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"]];
    }
    return _sectionArr;
}



#pragma mark ==YBillSearchNaviViewDelegate==
-(void)chooseBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    NSArray *list = @[@"首页",@"消息"];
    NSArray *images =@[@"home",@"news"];

    _popV = [[YPopView alloc]initWithFrame:CGRectMake(__kWidth-45, 8, __kWidth, __kHeight-60) title:list image:images];
    [self.view addSubview:_popV];
    _popV.delegate = self;
    _popV.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:_popV];
}

-(void)searchDid:(NSString *)text{
    NSLog(@"%@",text);
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
        YSystemNewsViewController *vc = [[YSystemNewsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark ==UITableViewDelegate==
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YSBrandListModel *model =_dataArr[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSBrandClassCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSBrandClassCell"];
    if (!cell) {
        cell = [[YSBrandClassCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"YSBrandClassCell"];
    }
    YSBrandListModel *data = _dataArr[indexPath.section];
    cell.model = data.list[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YSBrandSectionHeadView *headerV = [[YSBrandSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 25)];
    headerV.name= self.sectionArr[section];
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionArr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YSBrandListModel *data = _dataArr[indexPath.section];
    YSBrandModel *model = data.list[indexPath.row];
    YSBrandDetailViewController *vc = [[YSBrandDetailViewController alloc]init];
    vc.brandName = model.name;
    vc.brandId = model.brandId;
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
