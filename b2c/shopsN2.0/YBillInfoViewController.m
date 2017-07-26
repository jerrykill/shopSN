//
//  YBillInfoViewController.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBillInfoViewController.h"
#import "YSettingCell.h"
#import "YBillHeadCell.h"
#import "YBillTypeCell.h"
#import "YGiftSureOrderViewController.h"
#import "YSureOrderViewController.h"

@interface YBillInfoViewController ()<UITableViewDelegate,UITableViewDataSource,YSettingCellDelegate,YBillHeadCellDelegate,YBillTypeCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (nonatomic) BOOL needBill;

@end

@implementation YBillInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发票信息";
//    self.rightBtn.frame = CGRectMake(__kWidth-70, 35, 58, 15);
//    self.rightBtn.titleLabel.font = MFont(14);
//    self.rightBtn.backgroundColor = [UIColor clearColor];
//    [self.rightBtn setImage:MImage(@"") forState:BtnNormal];
//    [self.rightBtn setTitle:@"发票须知" forState:BtnNormal];
//    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    self.rightBtn.hidden = YES;
    if (!_billModel) {
        _billModel = [[YOrderBillModel alloc]init];
    }else{
        _needBill = YES;
    }
    [self initView];

}

- (void)chooseRight{
    NSLog(@"发票须知");
}

- (void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-70)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorColor = [UIColor clearColor];

    UIButton *saveBtn =[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV), __kWidth-20, 45)];
    [self.view addSubview:saveBtn];
    saveBtn.backgroundColor = __DefaultColor;
    saveBtn.titleLabel.font = MFont(16);
    saveBtn.layer.cornerRadius =5;
    [saveBtn setTitle:@"确定" forState:BtnNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [saveBtn addTarget:self action:@selector(chooseSure) forControlEvents:BtnTouchUpInside];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_needBill) {
        return 1;
    }else{
         return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells =nil;
    if (indexPath.row==0) {
        YSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSettingCell"];
        if (!cell) {
            cell=[[YSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSettingCell"];
        }
        cell.title = @"是否开具发票";
        cell.tag = 33;
        cell.switChoose.on =_needBill;
        cell.delegate = self;
        cells = cell;
    }else if (indexPath.row==1||indexPath.row==3){
        YBillTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBillTypeCell"];
        if (!cell) {
            cell = [[YBillTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBillTypeCell"];
        }
        if (indexPath.row==1) {
            cell.head = @"发票类型";
            NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:@"普通发票", @"增值发票", nil];
            cell.dataArr = dataArr;
            if (!IsNilString(_billModel.type)) {
                cell.choose = _billModel.type;
            }
        }else{
            cell.head = @"发票内容";
            NSMutableArray *dataArr = [NSMutableArray arrayWithObjects:@"办公用品", @"耗材",@"电脑配件",@"明细", nil];
            cell.dataArr = dataArr;
            if (!IsNilString(_billModel.type)) {
                cell.choose = _billModel.info;
            }
        }
        cell.tag = indexPath.row;
        cell.delegate = self;
        cells = cell;
    }else{
        YBillHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBillHeadCell"];
        if (!cell) {
            cell = [[YBillHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBillHeadCell"];
        }
        cell.tag = indexPath.row;
        if (!IsNilString(_billModel.headType)) {
            cell.headType = _billModel.headType;
        }
        if (!IsNilString(_billModel.header)) {
            cell.header = _billModel.header;
        }
        cell.delegate = self;
        cells = cell;
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            return 47;
        }
            break;
        case 1:
        {
            return 80;
        }
            break;
        case 2:
        {
            return 125;
        }
            break;
        case 3:
        {
            return 125;
        }
            break;
        default:
            return 0;
            break;
    }
}


#pragma mark ==YSettingCellDelegate==
-(void)chooseSwitch:(BOOL)sender index:(NSInteger)tag{
    _needBill=sender;
    if (!_needBill) {
        _billModel = [[YOrderBillModel alloc]init];
    }
    [_tableV reloadData];
}
#pragma mark ==YBillHeadCellDelegate==
-(void)chooseHeadType:(NSString *)type head:(NSString *)head{
    NSLog(@"%@%@",type,head);
    _billModel.header = head;
    _billModel.headType = type;
}

#pragma mark ==YBillTypeCellDelegate==
-(void)chooseType:(NSString *)type index:(NSInteger)tag{
    if (tag==1) {
        NSLog(@"类型%@",type);
        _billModel.type = type;
    }else{
        NSLog(@"内容%@",type);
        _billModel.info = type;
    }
}


#pragma mark ==确定==
-(void)chooseSure{
    if (IsNilString(_billModel.headType)||IsNilString(_billModel.type)||IsNilString(_billModel.info)) {
        [SXLoadingView showAlertHUD:@"发票信息不全" duration:SXLoadingTime];
        return;
    }
    [self.delegate getInfo:_billModel];
    [self.navigationController popViewControllerAnimated:YES];
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
