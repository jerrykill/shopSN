//
//  YAddressMangerViewController.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddressMangerViewController.h"
#import "YAddressCell.h"
#import "YAddressModel.h"
#import "YAddAddressViewController.h"
#import "YEditAddressViewController.h"
#import "YSureOrderViewController.h"
#import "YPersonalCenterViewController.h"
#import "YGiftSureOrderViewController.h"


@interface YAddressMangerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataArr;

@end

@implementation YAddressMangerViewController



-(void)getdata{
    WK(weakSelf)
    [JKHttpRequestService POST:@"Pcenter/addresslist" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            __typeof(&*weakSelf) strongSelf = weakSelf;
            strongSelf.dataArr = [YSParseTool getParseAddress:jsonDic[@"data"]];
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    YSTabbarViewController *tab = (YSTabbarViewController*)self.tabBarController;
    tab.tabBarV.hidden = YES;
    [self getdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    self.rightBtn.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });
 
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.delegate = self;
    _tableV.dataSource =self;
    _tableV.separatorColor = [UIColor clearColor];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, __kHeight-50, __kWidth, 50)];
    [self.view addSubview:bottomV];
    bottomV.backgroundColor = [UIColor whiteColor];

    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, __kWidth-20, 44)];
    [bottomV addSubview:addBtn];
    addBtn.layer.cornerRadius = 4;
    addBtn.backgroundColor = LH_RGBCOLOR(224, 40, 40);
    addBtn.titleLabel.font = MFont(16);
    [addBtn setTitle:@"新建收货地址" forState:BtnNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:BtnTouchUpInside];

}

-(void)addAddress{
    NSLog(@"新建收货地址");
    YAddAddressViewController *vc = [[YAddAddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YAddressCell"];
    if (!cell) {
        cell = [[YAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YAddressCell"];
    }
    YAddressModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YAddressModel *model = _dataArr[indexPath.row];
    NSArray *vcs = self.navigationController.viewControllers;
    NSInteger vcCount = vcs.count;

    if ([vcs[vcCount-2] isKindOfClass:[YSureOrderViewController class]]||[vcs[vcCount-2] isKindOfClass:[YGiftSureOrderViewController class]]) {
        NSLog(@"回去是结算");
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

        NSMutableArray *backArr = [@[] mutableCopy];

        [backArr addObject:model];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backToAddress" object:backArr userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];

    }
    if ([vcs[vcCount-2] isKindOfClass:[YPersonalCenterViewController class]]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        YEditAddressViewController*vc = [[YEditAddressViewController alloc]init];
        vc.addressId = model.addressId;
        [self.navigationController pushViewController:vc animated:YES];
    }


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
