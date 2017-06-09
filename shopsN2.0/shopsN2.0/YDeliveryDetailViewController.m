//
//  YDeliveryDetailViewController.m
//  shopsN
//
//  Created by imac on 2017/1/18.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YDeliveryDetailViewController.h"
#import "YBillSearchNaviView.h"
#import "YDeliveryDetailOneCell.h"

@interface YDeliveryDetailViewController ()<UITableViewDelegate,UITableViewDataSource,YPopViewDelegate,YBillSearchNaviViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YPopView *popV;

@property (strong,nonatomic) YBillSearchNaviView *naviV;

@end

@implementation YDeliveryDetailViewController

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
#pragma mark ==YBillSearchNaviViewDelegate==
-(void)rightAction{
    NSArray *list = @[@"首页",@"消息"];
    NSArray *images =@[@"home",@"news"];

    _popV = [[YPopView alloc]initWithFrame:CGRectMake(__kWidth-45, 8, __kWidth, __kHeight-60) title:list image:images];
    [self.view addSubview:_popV];
    _popV.delegate = self;
    _popV.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:_popV];
}

-(void)chooseBack{
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
-(void)searchDid:(NSString *)text{
    NSLog(@"%@",text);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self getnaivView];
}

-(void)getnaivView{
    _naviV =[[YBillSearchNaviView alloc]initWithFrame:CGRectMake( 0, 0, __kWidth, 64)];
    [self.view addSubview:_naviV];
    NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"搜索发货单..."];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
    _naviV.searchTF.attributedPlaceholder =attr;
    _naviV.delegate = self;

}

-(void)initView{
    _tableV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor= __BackColor;
    _tableV.separatorColor =[UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDeliveryDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDeliveryDetailOneCell"];
    if (!cell) {
        cell = [[YDeliveryDetailOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YDeliveryDetailOneCell"];
    }
    YDeliveryModel *model = [[YDeliveryModel alloc]init];
    model.orderNo = @"4653324";
    model.payId = @"12345641561";
    model.billDate = @"2017/01/01 00:00";
    model.saleName = @"shopsN有限公司";
    model.creatDate = @"2017/01/01 00:00";
    model.money = @"83.26";
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
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
