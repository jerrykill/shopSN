//
//  YPayViewController.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayViewController.h"
#import "YPayTitleHeadView.h"
#import "YPayTypeChooseCell.h"
#import "YPayCardCell.h"
#import "YPayOtherHead.h"
#import "YPayThreeCell.h"
#import "YPayCardAddCell.h"

#import "YAllOrderViewController.h"
#import "YPayCardCheckView.h"

#import "YOrderSuccessView.h"

#import "YOrdersDetailViewController.h"

@interface YPayViewController ()<UITableViewDelegate,UITableViewDataSource,YPayOtherHeadDelegate,YOrderSuccessViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (nonatomic) NSInteger chooseIndex;


@property (strong,nonatomic) YOrderSuccessView *successV;

@property (strong,nonatomic) NSArray *imageArr;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSArray *detailArr;

@end

@implementation YPayViewController

-(void)getData{
    _imageArr = @[@"Payment_zfb",@"Payment_wx"];
    _titleArr = @[@"支付宝支付",@"微信支付"];
    _detailArr = @[@"支付宝安全支付",@"微信安全支付"];
    if (IsNilString(_payMoney)||_payMoney.floatValue ==0) {
        _payMoney = @"0.00";
         [self getSuceessView];
         return;
    }
    [_tableV reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPayStatus:) name:YSOrderPayStatus object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = [NSString stringWithFormat:@"%@收银台",ShortTitle];
    _chooseIndex = 1;
    self.rightBtn.frame = CGRectMake(__kWidth-70, 35, 58, 15);
    self.rightBtn.titleLabel.font = MFont(14);
    self.rightBtn.backgroundColor = [UIColor clearColor];
    [self.rightBtn setImage:MImage(@"") forState:BtnNormal];
    [self.rightBtn setTitle:@"订单中心" forState:BtnNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [self initView];
    [self getData];


}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor =  [UIColor whiteColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    
}

- (void)chooseRight{
    YAllOrderViewController *vc = [[YAllOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}



#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPayThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPayThreeCell"];
    if (!cell) {
        cell = [[YPayThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPayThreeCell"];
    }
    cell.title = _titleArr[indexPath.row];
    cell.detail = _detailArr[indexPath.row];
    cell.imageName = _imageArr[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YPayTitleHeadView *header = [[YPayTitleHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 50)];
    header.money = _payMoney;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_payMoney.floatValue>0) {
        if (indexPath.row==0) {
            [JKPayTool payOrderWithOrderId:_orderId title:_orderName price:_payMoney complete:^{
                NSLog(@"测试");
            }];
        }else if(indexPath.row==1){
            [JKPayTool payOrderWxOrderId:_orderId title:_orderName price:_payMoney complete:^{
                 NSLog(@"微信");
            }];
        }
    }else{
        [SXLoadingView showAlertHUD:@"已支付成功" duration:SXLoadingTime];
    }
}



-(void)getSuceessView{
    [self.view addSubview:self.successV];
    [self.view bringSubviewToFront:self.successV];

}

#pragma mark ==YOrderSuccessViewDelegate==
-(void)makelookOrder{
    [_successV removeFromSuperview];
    YOrdersDetailViewController *vc = [[YOrdersDetailViewController alloc]init];
    vc.status = @"待处理";
    vc.orderId = _orderId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ==懒加载==
-(YOrderSuccessView *)successV{
    if (!_successV) {
        _successV = [[YOrderSuccessView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
        _successV.name = _addressModel.name;
        _successV.address = [NSString stringWithFormat:@"%@%@%@%@",_addressModel.province,_addressModel.city,_addressModel.area,_addressModel.Address];
        _successV.money = _payMoney;
        _successV.delegate = self;
    }
    return _successV;
}

- (void)getPayStatus:(NSNotification *)info {
    [self getSuceessView];
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
