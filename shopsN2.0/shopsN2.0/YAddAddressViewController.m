//
//  YAddAddressViewController.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddAddressViewController.h"
#import "YAddAddressCell.h"
#import "ZChooseAreaView.h"
#import "YAddressModel.h"
#import "YPlistAddressTool.h"
#import "YPlistChooseAreaView.h"

@interface YAddAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YPlistChooseAreaViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *titleArr;

@property (nonatomic) BOOL isDefault;


@property (strong,nonatomic) YPlistChooseAreaView *chooseV;

@property (strong,nonatomic) YAddressModel *model;


@end

@implementation YAddAddressViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增地址管理";
    _titleArr = @[@"收货人：",@"手机号码：",@"所在地区：",@"详细地址：",@"设为默认地址"];
    _model =  [[YAddressModel alloc]init];
    self.rightBtn.hidden = YES;
    [self initView];

}

-(void)initView{
    _tableV =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
    [self.view addSubview:_tableV];
    _tableV.delegate = self;
    _tableV.dataSource =self;
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, __kHeight-50, __kWidth, 50)];
    [self.view addSubview:bottomV];
    bottomV.backgroundColor =[UIColor whiteColor];

    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake( 10, 3, __kWidth-20, 44)];
    [bottomV addSubview:saveBtn];
    saveBtn.backgroundColor = LH_RGBCOLOR(224, 40, 40);
    saveBtn.layer.cornerRadius = 4;
    saveBtn.titleLabel.font = MFont(16);
    [saveBtn setTitle:@"保存" forState:BtnNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:BtnTouchUpInside];

}

-(void)save{
    NSLog(@"保存地址");
    WK(weakSelf)
    [JKHttpRequestService POST:@"Pcenter/addressadd" withParameters:@{@"realname":_model.name,@"mobile":_model.phone,@"prov":_model.provinceID,@"city":_model.cityID,@"dist":_model.areaID,@"address":_model.Address,@"default":_isDefault?@"1":@"0",@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
             __typeof(&*weakSelf) strongSelf = weakSelf;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YAddAddressCell"];
    if (!cell) {
        cell = [[YAddAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YAddAddressCell"];
    }
    cell.titleLb.text = _titleArr[indexPath.row];
    cell.detailTF.tag = indexPath.row;
    cell.detailTF.delegate = self;
    if (indexPath.row==2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (!IsNilString(_model.province)) {
            cell.detailTF.text = [NSString stringWithFormat:@"%@ %@ %@",_model.province,_model.city,_model.area];
        }
    }
    if (indexPath.row==4) {
        cell.detailTF.hidden = YES;
        cell.chooseIV.hidden = NO;
        if (_isDefault) {
            cell.chooseIV.image = MImage(@"Cart_on");
        }else{
            cell.chooseIV.image = MImage(@"Cart_off");
        }

    }else{
        switch (indexPath.row) {
            case 0:
            {
                cell.detailTF.text = _model.name;
            }
                break;
            case 1:
            {
                cell.detailTF.text = _model.phone;
            }
                break;
            case 3:
            {
                cell.detailTF.text = _model.Address;
            }
                break;

            default:
                break;
        }    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        _isDefault = !_isDefault;
        _model.isDefault = &(_isDefault);
        [_tableV reloadData];
    }
}
#pragma mark ==UITextfiledDelegate==
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag ==2) {
        [self.view endEditing:YES];
        [self choosePicker];
        return NO;
    }else{
        return YES;
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
        {
            _model.name = textField.text;
        }
            break;
        case 1:
        {
            _model.phone = textField.text;
        }
            break;
        case 3:
        {
            _model.Address = textField.text;
        }
            break;
        default:
            break;
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ==选择地区==
-(void)choosePicker{
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

#pragma mark ==懒加载=
-(YPlistChooseAreaView *)chooseV{
    if (!_chooseV) {
        _chooseV = [[YPlistChooseAreaView alloc]initWithAreaFrame:CGRectMake(0, __kHeight-230, __kWidth, 230)];
        _chooseV.delegate = self;
    }
    return _chooseV;
}
#pragma mark ==YPlistChooseAreaViewDelegate==
-(void)chooseAddressData:(YPlistAddressModel *)data{
    _model.province = data.province;
    _model.provinceID = data.provinceID;
    YPlistCityModel*city = data.list.firstObject;
    _model.city = city.city;
    _model.cityID = city.cityId;
    if (city.datas.count) {
        YPlistAreaModel *area = city.datas.firstObject;
        _model.area = area.area;
        _model.areaID = area.areaID;
    }else{
        _model.area = @"";
        _model.areaID = @"-1";
    }
    [_tableV reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
