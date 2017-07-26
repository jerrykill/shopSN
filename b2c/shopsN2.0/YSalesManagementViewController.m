//
//  YSalesManagementViewController.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSalesManagementViewController.h"
#import "YManageHeadView.h"
#import "YSalesManageCell.h"
#import "YManageSaleDetailViewController.h"

@interface YSalesManagementViewController ()<UITableViewDelegate,UITableViewDataSource,YManageHeadViewDelegate>


@property (strong,nonatomic) YManageHeadView *manageHeadV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YSalesManagementViewController

-(void)getData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/customerService" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.dataArr = [YSParseTool getParseAfterSaleManageList:data];
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.dataArr removeAllObjects];
            [strongSelf.tableV reloadData];
            [SXLoadingView showAlertHUD:@"暂无数据" duration:SXLoadingTime];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"售后管理";
    [self getData];
    [self initView];
}

-(void)initView{
    _manageHeadV = [[YManageHeadView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 54)];
    [self.view addSubview:_manageHeadV];
    _manageHeadV.delegate= self;

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_manageHeadV), __kWidth, __kHeight-64-54)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;



}
#pragma mark ==YManageHeadViewDelegate==
-(void)searchDid:(NSString *)text{
    NSLog(@"%@",text);
    [self getsearchData:text];
}


#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSalesManageCell *cell =[tableView dequeueReusableCellWithIdentifier:@"YSalesManageCell"];
    if (!cell) {
        cell = [[YSalesManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSalesManageCell"];
    }
    YSalesManageModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       YSalesManageModel *model = _dataArr[indexPath.row];
    NSString *str = model.info;
    CGSize size =[str boundingRectWithSize:CGSizeMake(__kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
    return 140+size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    YSalesManageModel *model = _dataArr[indexPath.row];
    YManageSaleDetailViewController *vc = [[YManageSaleDetailViewController alloc]init];
    vc.salesId = model.salesId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getsearchData:(NSString*)text {
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/customerServiceSearch" withParameters:@{@"keyword":text,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.dataArr = [YSParseTool getParseAfterSaleManageList:data];
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.dataArr removeAllObjects];
            [strongSelf.tableV reloadData];
            [SXLoadingView showAlertHUD:@"暂无数据" duration:SXLoadingTime];

        }
    } failure:^(NSError *error) {

    } animated:YES];
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
