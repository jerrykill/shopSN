//
//  YApplicationJoinViewController.m
//  shopsN
//
//  Created by imac on 2016/12/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YApplicationJoinViewController.h"
#import "YApplicationDetailCell.h"
#import "YBuyingGoodInfoCell.h"
#import "YApplicationModel.h"
#import "ZChooseAreaView.h"

@interface YApplicationJoinViewController ()<YApplicationDetailCellDelegate,YBuyingGoodInfoCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) YApplicationModel *model;

@property (strong,nonatomic) ZChooseAreaView *pickerV;
@end

@implementation YApplicationJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加盟申请";
    _model = [[YApplicationModel alloc]init];
//    self.rightBtn.hidden = YES;

    _titleArr = @[@"申请人：",@"联系方式：",@"联系邮箱：",@"所在地区：",@"详细地址：",@"年龄：",@"QQ：",@"传真："];
    _model.userName = @"测试";
    _model.phone = @"18855584908";
    _model.eamil = @"1084356436@qq.com";
    _model.province = @"浙江省";
    _model.city = @"湖州市";
    _model.area = @"德清县";
    _model.address = @"测试详情";
    _model.age = @"23";
    _model.QQ = @"1084356436";
    _model.fax = @"暂无";
    _model.remarks = @"测试备注";
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view sendSubviewToBack:_tableV];

    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV)+3, __kWidth-20, 45)];
    [self.view addSubview:saveBtn];
    saveBtn.backgroundColor = __DefaultColor;
    saveBtn.titleLabel.font = MFont(16);
    saveBtn.layer.cornerRadius = 5;
    [saveBtn setTitle:@"申请" forState:BtnNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [saveBtn addTarget:self action:@selector(chooseSave) forControlEvents:BtnTouchUpInside];
}

#pragma mark ==保存==
-(void)chooseSave{
    NSLog(@"申请加盟");
    [self checkNUll];
   [JKHttpRequestService POST:@"Pcenter/applayJoin" withParameters:@{@"applicant":_model.userName,@"tel":_model.phone,@"email":_model.eamil,@"age":_model.age,@"province":_model.province,@"city":_model.city,@"county":_model.area,@"address":_model.address,@"fax":_model.fax,@"qq":_model.QQ,@"remark":_model.remarks,@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           [SXLoadingView showAlertHUD:@"申请成功，待审核" duration:SXLoadingTime];
           [self.navigationController popViewControllerAnimated:YES];
       }
   } failure:^(NSError *error) {

   } animated:YES];
}

-(void)checkNUll{
    if (IsNilString(_model.userName)||IsNilString(_model.phone)||IsNilString(_model.eamil)||IsNilString(_model.age)||IsNilString(_model.province)||IsNilString(_model.city)||IsNilString(_model.area)||IsNilString(_model.address)||IsNilString(_model.fax)||IsNilString(_model.QQ)) {
        [SXLoadingView showAlertHUD:@"资料不全，麻烦填写完整" duration:SXLoadingTime];
        return;
    }else if (IsNilString(_model.remarks)){
       _model.remarks = @"";
    }
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.row!=8) {
        YApplicationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplicationDetailCell"];
        if (!cell) {
            cell = [[YApplicationDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplicationDetailCell"];
        }
        cell.title = _titleArr[indexPath.row];
        cell.tag = indexPath.row;
        switch (indexPath.row) {
            case 0:
            {
                cell.detail =_model.userName;
            }
                break;
            case 1:
                cell.detail =_model.phone;
                break;
            case 2:
                cell.detail = _model.eamil;
                break;
            case 3:{
                NSString *str = [NSString stringWithFormat:@"%@ %@ %@",_model.province,_model.city,_model.area];
                if ([str containsString:@"市"]||[str containsString:@"区"]||[str containsString:@"县"]||[str containsString:@"澳门"]||[str containsString:@"香港"]||[str containsString:@"省"]) {
                    cell.detail = str;
                }
               }
                break;
            case 4:
                cell.detail = _model.address;
                break;
            case 5:
                cell.detail = _model.age;
                break;
            case 6:
                cell.detail =_model.QQ;
                break;
            case 7:
                cell.detail = _model.fax;
                break;
            default:
                break;
        }
        cell.delegate = self;
        cells = cell;
    }else{
        YBuyingGoodInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBuyingGoodInfoCell"];
        if (!cell) {
            cell = [[YBuyingGoodInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBuyingGoodInfoCell"];
        }
        cell.title = @"备注说明：";
        cell.warn = @"请输入备注说明..";
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==8) {
        return 134;
    }else{
        return 50;
    }
}

#pragma mark ==YApplicationDetailCellDelegate==
-(void)getApplyDetail:(NSString *)text Index:(NSInteger)tag{
    switch (tag) {
        case 0:
            _model.userName =text;
            break;
        case 1:
            _model.phone =text;
            break;
        case 2:
            _model.eamil = text;
            break;
       // case 3:
         //   _model.area = text;
           // break;
        case 4:
            _model.address = text;
            break;
        case 5:
            _model.age = text;
            break;
        case 6:
            _model.QQ = text;
            break;
        case 7:
            _model.fax = text;
            break;
        default:
            break;
    }
}

-(void)chooseArea{
    [self.view endEditing:YES];
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[ZChooseAreaView class]]) {
            [obj removeFromSuperview];
        }
    }
    [self.view addSubview:self.pickerV];
    [self.view bringSubviewToFront:_pickerV];

}
#pragma mark ==懒加载==
-(ZChooseAreaView *)pickerV{
        if (!_pickerV) {
            _pickerV  = [[ZChooseAreaView alloc]initWithAreaFrame:CGRectMake(0, __kHeight-230, __kWidth, 230)];
            WK(weakSelf)
            _pickerV.returntextfileBlock =^(NSString *data){
                NSArray *list = [data componentsSeparatedByString:@","];
                weakSelf.model.province = list[0];
                weakSelf.model.city = list[1];
                weakSelf.model.area = list[2];
                [weakSelf.tableV reloadData];
            };
        }
        return _pickerV;
}



#pragma mark ==YBuyingGoodInfoCellDelegate==
-(void)getInfoDetail:(NSString *)sender{
    _model.remarks =sender;
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
