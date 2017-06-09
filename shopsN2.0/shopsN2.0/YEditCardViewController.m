//
//  YEditCardViewController.m
//  shopsN
//
//  Created by imac on 2017/1/12.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YEditCardViewController.h"
#import "YBankCardDetailCell.h"
#import "YBankCardChooseView.h"
#import "YBankCheckCell.h"

@interface YEditCardViewController ()<UITableViewDelegate,UITableViewDataSource,YBankCardDetailCellDelegate,YBankCardChooseViewDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YBankCardChooseView *chooseV;



@end

@implementation YEditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑银行卡";
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 69, __kWidth, __kHeight-70-55)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.scrollEnabled = NO;

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_tableV)+6, __kWidth-20, 44)];
    [self.view addSubview:sureBtn];
    sureBtn.backgroundColor = __DefaultColor;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn setTitle:@"保存" forState:BtnNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:BtnTouchUpInside];
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.row!=2) {
        YBankCardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBankCardDetailCell"];
        if (!cell) {
            cell =[[YBankCardDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBankCardDetailCell"];
        }
        cell.tag = indexPath.row;
        cell.delegate = self;
        if (!indexPath.row) {
            cell.title = @"持卡人";
            cell.plachorText = @"请输入持卡人姓名";
            if (!IsNilString(_userName)) {
                cell.detail = _userName;
            }
        }else{
            cell.title = @"卡号";
            cell.plachorText = @"请输入卡号";
            if (!IsNilString(_cardNum)) {
                cell.detail = _cardNum;
            }
        }
        cells = cell;
    }else{
        YBankCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YBankCheckCell"];
        if (!cell) {
            cell = [[YBankCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBankCheckCell"];
        }
        if (!IsNilString(_cardName)) {
            cell.detail = _cardName;
        }
        cells = cell;
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        [_chooseV removeFromSuperview];
        _chooseV = [[YBankCardChooseView alloc]initWithFrame:CGRectMake(0, __kHeight-230, __kWidth, 230)];
        [self.view addSubview:_chooseV];
        _chooseV.bankArr = [NSMutableArray arrayWithObjects:@"中国银行",@"建设银行",@"招商银行",@"农业银行",@"浦发银行", nil];
        _chooseV.delegate = self;
    }
}
#pragma mark ==YBankCardDetailCell==
-(void)getInputTFdetail:(NSString *)text index:(NSInteger)tag{
    if (tag) {
        _cardNum = text;
    }else{
        _userName = text;
    }
}

#pragma mark ==YBankCardChooseView==
-(void)chooseBank:(NSString *)bank{
    _cardName = bank;
    [_tableV reloadData];
}

#pragma mark ==确定保存==
-(void)sureAction{
    NSLog(@"%@的%@银行卡%@修改成功",_userName,_cardName,_cardNum);

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
