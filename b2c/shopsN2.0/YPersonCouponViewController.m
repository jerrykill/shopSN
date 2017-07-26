//
//  YPersonCouponViewController.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonCouponViewController.h"
#import "YCuponViewCell.h"
#import "YCuponTypeChooseView.h"

@interface YPersonCouponViewController ()<UITableViewDelegate,UITableViewDataSource,YCuponTypeChooseViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YCuponTypeChooseView *typeChooseV;

@property (strong,nonatomic) NSMutableArray *dataList;

@property (strong,nonatomic) NSString *status;

@property (assign,nonatomic) NSInteger color;

@end

@implementation YPersonCouponViewController

-(void)getData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/myCoupon" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"status":_status} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.dataList = [YSParseTool getParseCouponArray:data];
            [strongSelf.tableV reloadData];
        }else{
            [strongSelf.dataList removeAllObjects];
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    self.rightBtn.hidden = YES;

    [self initView];
    _color = 0;
    _status = @"3";
    [self getData];

}

-(void)initView{
    _typeChooseV = [[YCuponTypeChooseView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 45)];
    [self.view addSubview:_typeChooseV];
    _typeChooseV.delegate = self;

    _tableV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 109, __kWidth, __kHeight-109)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor= __BackColor;
    _tableV.separatorColor =[UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YCuponViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCuponViewCell"];
    if (!cell) {
        cell = [[YCuponViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCuponViewCell"];
    }
    cell.tag = indexPath.row;
    YScouponModel *model =_dataList[indexPath.row];
//    cell.color = indexPath.row%5;
//    cell.title = @"订单满2000使用";
//    cell.time = @"2016.11.30 -- 2016.12.31";
//    cell.money = @"100.00";
    cell.model = model;
    cell.color = _color;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark ==YCuponTypeChooseView==
-(void)chooseCuponType:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            NSLog(@"未使用");
            _status = @"3";
            int x = arc4random() % 2;
            _color = x;
            [self getData];
        }
            break;
        case 1:
        {
            NSLog(@"已使用");
            _status = @"1";
            _color= 3;
            [self getData];
        }
            break;
        case 2:
        {
            NSLog(@"已过期");
            _status = @"2";
            _color= 4;
            [self getData];
        }
            break;
        default:
            break;
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
