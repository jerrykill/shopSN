//
//  YSureOrderCouponViewController.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderCouponViewController.h"
#import "YCuponViewCell.h"
#import "YSureOrderViewController.h"

@interface YSureOrderCouponViewController ()<UITableViewDelegate,UITableViewDataSource,YCuponViewCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *dataList;

@end

@implementation YSureOrderCouponViewController


- (void)getData {
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/myCoupon" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"status":@"3"} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSArray *data = jsonDic[@"data"];
            strongSelf.dataList = [YSParseTool getParseCouponArray:data];
            [strongSelf.tableV reloadData];
        }else{
            [SXLoadingView showAlertHUD:@"无优惠券" duration:SXLoadingTime];
        }
    } failure:^(NSError *error) {

    } animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"使用优惠券";
    self.rightBtn.hidden = YES;
    [self initView];
    [self getData];
}

- (void)initView{
    _tableV  =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
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
    cell.delegate = self;
    YScouponModel *model = _dataList[indexPath.row];
    cell.model = model;
    if ([model.condition floatValue]>[_totalPay floatValue]) {
        cell.color = 5;
    }else{
       cell.color = indexPath.row%3;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark ==YCuponViewCell==
-(void)chooseUseTag:(NSInteger)index{
    NSLog(@"选择优惠券%ld",index);
    YScouponModel *model = _dataList[index];
    NSArray *vcs = self.navigationController.viewControllers;
    NSInteger vcCount = vcs.count;

    if ([vcs[vcCount-2] isKindOfClass:[YSureOrderViewController class]]) {
    NSMutableArray *data = [NSMutableArray array];
    [data addObject:model];
    [[NSNotificationCenter defaultCenter] postNotificationName:YSCuponChoose object:data userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
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
