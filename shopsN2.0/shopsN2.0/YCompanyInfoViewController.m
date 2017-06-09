//
//  YCompanyInfoViewController.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCompanyInfoViewController.h"
#import "YCompanyInfoCell.h"

@interface YCompanyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,YPopViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSArray *titleArr;


@end

@implementation YCompanyInfoViewController

//- (void)getdata{
//    [JKHttpRequestService POST:@"Pcenter/enterpriseData" withParameters:{@"app_user_id":[UdStorage getObjectforKey:Userid]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//        if (succe) {
//            
//        }
//    } failure:^(NSError *error) {
//
//    } animated:YES];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"企业资料";
    _titleArr = @[@"企业名称",@"成立时间",@"注册资本",@"账户余额",@"手机号码",@"固定电话",@"联系邮箱",@"省/市/县",@"注册地",@"详细地址",@"联系人",@"传真",@"邮编",@"主页",@"法人",@"税务登记"];
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor clearColor];
    _tableV.separatorColor = [UIColor clearColor];

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YCompanyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCompanyInfoCell"];
    if (!cell) {
        cell = [[YCompanyInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCompanyInfoCell"];
    }
    cell.title = _titleArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            cell.deatil = _model.name;
        }
            break;
        case 1:
        {
            cell.deatil = _model.creatTime;
        }
            break;
        case 2:
        {
            cell.deatil = _model.registerCapital;
        }
            break;
        case 3:
        {
            cell.deatil = _model.accountBalance;
        }
            break;
        case 4:
        {
            cell.deatil = _model.telephone;
        }
            break;
        case 5:
        {
            cell.deatil = _model.mobile;
        }
            break;
        case 6:
        {
            cell.deatil = _model.email;
        }
            break;
        case 7:
        {
            cell.deatil = _model.registerAddress;
        }
            break;
        case 8:
        {
            cell.deatil = _model.placeAddress;
        }
            break;
        case 9:
        {
            cell.deatil = _model.address;
        }
            break;
        case 10:
        {
            cell.deatil = _model.fax;
        }
            break;
        case 11:
        {
            cell.deatil = _model.zipCode;
        }
            break;
        case 12:
        {
            cell.deatil = _model.legalPerson;
        }
            break;
        case 13:
        {
            cell.deatil = _model.taxRegister;
        }
            break;
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
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
