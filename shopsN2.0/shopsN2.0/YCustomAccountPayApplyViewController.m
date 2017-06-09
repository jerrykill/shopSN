//
//  YCustomAccountPayApplyViewController.m
//  shopsN
//
//  Created by imac on 2017/3/30.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCustomAccountPayApplyViewController.h"
#import "YCustomPayDetailCell.h"
#import "YCustomInfoCell.h"
#import "YCustomChooseAddressCell.h"
#import "YCustomPurchaseMoneyCell.h"
#import "YInfodetailCell.h"
#import "ZChooseAreaView.h"
#import "YCustomApplyModel.h"
#import "YPlistAddressTool.h"
#import "YPlistChooseAreaView.h"

@interface YCustomAccountPayApplyViewController ()<UITableViewDelegate,UITableViewDataSource,YCustomPayDetailCellDelegate,YCustomPurchaseMoneyCellDelegate,YCustomChooseAddressCellDelegate,YInfodetailCellDelegate,YPlistChooseAreaViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) UIView *bottomV;

@property (strong,nonatomic) UIButton *putButton;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSArray *detailArr;

@property (strong,nonatomic) ZChooseAreaView *pickerV;

@property (strong,nonatomic) YPlistChooseAreaView *chooseV;

@property (strong,nonatomic) YCustomApplyModel *dataModel;

@end

@implementation YCustomAccountPayApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户账期支付申请表";
    self.rightBtn.hidden = YES;
    _titleArr = @[@"公司名称：",@"",@"详细地址：",@"申请人电话：",@"对账负责人电话：",@"预计每月采购办公用品金额："];
    _detailArr = @[@"请输入公司名称...",@"",@"请输入详细地址...",@"请输入办公电话...",@"请输入办公电话..."];
    _dataModel = [[YCustomApplyModel alloc]init];
    [self initView];
}

-(void)initView{
    [self.view addSubview:self.tableV];
    [self.view addSubview:self.bottomV];
    [_bottomV addSubview:self.putButton];
}

#pragma mark ==懒加载==
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-70)];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorColor = [UIColor clearColor];

    }
    return _tableV;
}

-(UIView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(_tableV), __kWidth, 70)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

-(UIButton *)putButton{
    if (!_putButton) {
        _putButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, __kWidth-20, 34)];
        _putButton.backgroundColor =__DefaultColor;
        _putButton.layer.cornerRadius =5;
        [_putButton setTitle:@"确认提交" forState:BtnNormal];
        _putButton.titleLabel.font = MFont(16);
        [_putButton setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_putButton addTarget:self action:@selector(surePut) forControlEvents:BtnTouchUpInside];
    }
    return _putButton;
}

- (void)surePut{
    NSLog(@"提交");
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if ([self checkNull]) {
        [JKHttpRequestService POST:@"Pcenter/changeSubmit" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"company_name":_dataModel.company,@"prov":_dataModel.province,@"city":_dataModel.city,@"dist":_dataModel.area,@"address":_dataModel.addressDetail,@"applytel":_dataModel.applyTel,@"respontel":_dataModel.payTel,@"estimate":_dataModel.type,@"remarks":_dataModel.info} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                [SXLoadingView showAlertHUD:@"申请成功！等待客服联系" duration:SXLoadingTime];
                [strongSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [SXLoadingView showAlertHUD:@"申请失败" duration:SXLoadingTime];
        } animated:YES];
    }
}

- (BOOL)checkNull{
    if (IsNilString(_dataModel.company)||IsNilString(_dataModel.province)||IsNilString(_dataModel.city)||IsNilString(_dataModel.addressDetail)||IsNilString(_dataModel.applyTel)||IsNilString(_dataModel.payTel)||IsNilString(_dataModel.type)) {
        [SXLoadingView showAlertHUD:@"数据不全" duration:SXLoadingTime];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells =nil;
    if (indexPath.row==1) {
        YCustomChooseAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCustomChooseAddressCell"];
        if (!cell) {
            cell = [[YCustomChooseAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCustomChooseAddressCell"];
        }
        cell.delegate = self;
        if (!IsNilString(_dataModel.province)) {
            cell.address = [NSString stringWithFormat:@"%@ %@ %@",_dataModel.province,_dataModel.city,_dataModel.area];
        }
        cells = cell;
    }else if (indexPath.row==5){
        YCustomPurchaseMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCustomPurchaseMoneyCell"];
        if (!cell) {
            cell = [[YCustomPurchaseMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCustomPurchaseMoneyCell"];
        }
        cell.title = _titleArr[indexPath.row];
        cell.dataArr = [NSMutableArray arrayWithArray:@[@"2000-5000元",@"5000-10000元",@"10000以上"]];
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.row==6){
        YInfodetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YInfodetailCell"];
        if (!cell) {
            cell = [[YInfodetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YInfodetailCell"];
        }
        cell.title = @"备注说明：";
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.row==7){
        YCustomInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCustomInfoCell"];
        if (!cell) {
            cell = [[YCustomInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCustomInfoCell"];
        }
        cells = cell;
    }else{
        YCustomPayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCustomPayDetailCell"];
        if (!cell) {
            cell = [[YCustomPayDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCustomPayDetailCell"];
        }
        cell.tag = indexPath.row;
        cell.title = _titleArr[indexPath.row];
        cell.detail = _detailArr[indexPath.row];
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        return 50;
    }else if (indexPath.row==5){
        return 120;
    }else if (indexPath.row==6){
        return 150;
    }else if (indexPath.row==7){
        return 90;
    }else{
        return 50;
    }
}
#pragma mark ==YCustomPayDetailCellDelegate==
-(void)getDetail:(NSString *)detail index:(NSInteger)index{
    NSLog(@"%@%@",_titleArr[index],detail);
    switch (index) {
        case 0:
        {
            _dataModel.company = detail;
        }
            break;
        case 2:
        {
            _dataModel.addressDetail = detail;
        }
            break;
        case 3:
        {
            _dataModel.applyTel = detail;
        }
            break;
        case 4:
        {
            _dataModel.payTel = detail;
        }
            break;
        default:
            break;
    }

}

#pragma mark ==懒加载==
- (YPlistChooseAreaView *)chooseV{
    if (!_chooseV) {
        _chooseV = [[YPlistChooseAreaView alloc]initWithAreaFrame:CGRectMake(0, __kHeight-230, __kWidth, 230)];
        _chooseV.delegate = self;
    }
    return _chooseV;
}
#pragma mark ==YPlistChooseAreaViewDelegate==
-(void)chooseAddressData:(YPlistAddressModel *)data{
    _dataModel.province = data.province;
    _dataModel.provinceId = data.provinceID;
    YPlistCityModel*city = data.list.firstObject;
    _dataModel.city = city.city;
    _dataModel.cityId = city.cityId;
    if (city.datas.count) {
        YPlistAreaModel *area = city.datas.firstObject;
        _dataModel.area = area.area;
        _dataModel.areaID = area.areaID;
    }else{
        _dataModel.area = @"";
        _dataModel.areaID = @"-1";
    }
    [_tableV reloadData];
}


#pragma mark ==YCustomChooseAddressCellDelegate==
-(void)chooseAddress{
    NSArray *data =[YPlistAddressTool getTheDataAddress];
    if (!data.count) {
        [SXLoadingView showAlertHUD:@"请等待10s后重试" duration:SXLoadingTime];
        return ;
    }
    [self.view endEditing:YES];
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[YPlistChooseAreaView class]]) {
            [obj removeFromSuperview];
        }
    }
    [self.view addSubview:self.chooseV];
    [self.view bringSubviewToFront:_chooseV];
}

#pragma mark ==YCustomPurchaseMoneyCellDelegate==
-(void)chooseType:(NSString *)type index:(NSInteger)tag{
    NSLog(@"%@",type);
    _dataModel.type = [NSString stringWithFormat:@"%ld",tag];
}

#pragma mark ==YInfodetailCellDelegate==
-(void)getinfo:(NSString *)info{
    _dataModel.info = info;
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
