//
//  YBillDetailViewController.m
//  shopsN
//
//  Created by imac on 2017/1/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBillDetailViewController.h"
#import "YBillSearchNaviView.h"
#import "YBillDetailCell.h"

@interface YBillDetailViewController ()<YBillSearchNaviViewDelegate,UITableViewDelegate,UITableViewDataSource,YPopViewDelegate>

@property (strong,nonatomic) YBillSearchNaviView *naviV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YPopView *popV;

@end

@implementation YBillDetailViewController
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
    [self initView];
    [self getnaivView];
}

-(void)getnaivView{
    _naviV =[[YBillSearchNaviView alloc]initWithFrame:CGRectMake( 0, 0, __kWidth, 64)];
    [self.view addSubview:_naviV];
    NSMutableAttributedString *attr =[[NSMutableAttributedString alloc]initWithString:@"搜索商品编号..."];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(230, 155, 159) range:NSMakeRange(0, attr.length)];
    _naviV.searchTF.attributedPlaceholder = attr;
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

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBillDetailCell"];
    if (!cell) {
        cell = [[YBillDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBillDetailCell"];
    }
    YBillGoodModel *model = [[YBillGoodModel alloc]init];
    model.goodId = @"111007638";
    model.name = @"齐心 B#715 速干印油 50ML 蓝";
    model.size = @"B3715";
    model.units = @"PCS";
    model.num = @"12";
    model.price = @"4.90";
    model.total = @"58.24";
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185;
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
