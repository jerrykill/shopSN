//
//  YEditAddressViewController.m
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YEditAddressViewController.h"
#import "YAddAddressCell.h"
#import "ZChooseAreaView.h"
#import "YPlistChooseAreaView.h"
#import "YPlistAddressTool.h"

@interface YEditAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YPlistChooseAreaViewDelegate>

@property (strong,nonatomic) UITableView *tableV;
@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSArray *detailArr;

@property (nonatomic) BOOL isDefault;

@property (strong,nonatomic) YAddressModel *model;

@property (strong,nonatomic) ZChooseAreaView *pickerV;

@property (strong,nonatomic) YPlistChooseAreaView *chooseV;

@end

@implementation YEditAddressViewController


-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/addinfo" withParameters:@{@"id":_addressId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic= jsonDic[@"data"];
            strongSelf.model = [[YAddressModel alloc]init];
            strongSelf.model.name = dic[@"realname"];
            strongSelf.model.phone = dic[@"mobile"];
            strongSelf.model.province = dic[@"prov"][@"name"];
            strongSelf.model.provinceID = dic[@"prov"][@"id"];
            strongSelf.model.city = dic[@"city"][@"name"];
            strongSelf.model.cityID = dic[@"city"][@"id"];
            strongSelf.model.area = dic[@"dist"][@"name"];
            strongSelf.model.areaID = dic[@"dist"][@"id"];
            strongSelf.model.Address = dic[@"address"];
            strongSelf.model.isDefault = [dic[@"status"] integerValue]==1?YES:NO;
            strongSelf.model.addressId = dic[@"id"];
            strongSelf.isDefault = weakSelf.model.isDefault;
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址管理";
    _titleArr = @[@"收货人：",@"手机号码：",@"所在地区：",@"详细地址：",@"设为默认地址"];
    [self.rightBtn setImage:MImage(@"head_delete") forState:BtnNormal];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getdata];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    });


}

- (void)chooseRight{
    NSLog(@"删除");
    [JKHttpRequestService POST:@"Pcenter/addressde" withParameters:@{@"id":_addressId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"删除成功" duration:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

-(void)initView{
    _tableV =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
    [self.view addSubview:_tableV];
    _tableV.delegate = self;
    _tableV.dataSource =self;
    _tableV.backgroundColor = [UIColor clearColor];
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
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/addressadd" withParameters:@{@"realname":_model.name,@"mobile":_model.phone,@"prov":_model.provinceID,@"city":_model.cityID,@"dist":_model.areaID,@"address":_model.Address,@"default":_isDefault?@"1":@"0",@"id":_model.addressId,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [SXLoadingView showAlertHUD:@"修改地址成功" duration:1.5];
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
        cell.detailTF.text = [NSString stringWithFormat:@"%@ %@ %@",_model.province,_model.city,_model.area];
    }
    if (indexPath.row==4) {
        cell.detailTF.hidden = YES;
        cell.chooseIV.hidden = NO;
        if (_model.isDefault) {
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
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        _isDefault = !_isDefault;
        _model.isDefault = _isDefault;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
