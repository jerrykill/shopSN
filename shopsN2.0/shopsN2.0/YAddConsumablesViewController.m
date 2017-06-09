//
//  YAddConsumablesViewController.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddConsumablesViewController.h"
#import "YChooseConsCell.h"
#import "YAddconsSureView.h"
#import "YConsDetailPutView.h"

#import "YAddConsModel.h"

@interface YAddConsumablesViewController ()<YConsDetailPutViewDelegate,YAddconsSureViewDelegate,UITableViewDelegate,UITableViewDataSource,YChooseConsCellDelegate>


@property (strong,nonatomic) YAddconsSureView *sureV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) YConsDetailPutView *putV;

@property (strong,nonatomic) YAddConsModel *model;

@end

@implementation YAddConsumablesViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补充耗材需求";
    _model = [[YAddConsModel alloc]init];
    _model.list = [[NSMutableArray alloc]init];
    [self initView];
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_tableV];
    _tableV.backgroundColor = __BackColor;
    _tableV.separatorColor = __BackColor;
    _tableV.delegate = self;
    _tableV.dataSource = self;

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 460)];
    bottomV.backgroundColor = __BackColor;
    _tableV.tableFooterView =bottomV;
    
    _sureV = [[YAddconsSureView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 171)];
    [bottomV addSubview:_sureV];
    _sureV.delegate = self;

    _putV = [[YConsDetailPutView alloc]initWithFrame:CGRectMake(0, CGRectYH(_sureV), __kWidth, 221)];
    [bottomV addSubview:_putV];
    _putV.delegate = self;

    UIButton *surePutBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectYH(_putV)+20, __kWidth-20, 45)];
    [bottomV addSubview:surePutBtn];
    surePutBtn.backgroundColor = __DefaultColor;
    surePutBtn.titleLabel.font = MFont(16);
    [surePutBtn setTitle:@"确认提交" forState:BtnNormal];
    [surePutBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [surePutBtn addTarget:self action:@selector(surePut) forControlEvents:BtnTouchUpInside];


}


#pragma mark ==提交==
- (void)surePut{
    NSLog(@"确认提交");
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_model.list.count<1) {
        return 1;
    }else{
    return _model.list.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YChooseConsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YChooseConsCell"];
    if (!cell) {
        cell = [[YChooseConsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YChooseConsCell"];
    }
    if (_model.list.count>=1) {
        cell.tag = indexPath.row;
        cell.delegate = self;
        cell.model = _model.list[indexPath.row];
    }else{
        cell = [[YChooseConsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YChooseConsCell"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_model.list.count<1) {
        return 40;
    }
    YConsModel *model = _model.list[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@,%@",model.title,model.num];
    CGSize size  =[str boundingRectWithSize:CGSizeMake(__kWidth-155, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(14)} context:nil].size;
    if (size.height>20) {
        return 40+size.height-10;
    }else{
        return 40;
    }
}
#pragma mark ==YAddconsSureViewDelegate==
-(void)putCons:(YConsModel *)model{
    [_model.list addObject:model];
    [_tableV reloadData];
}

#pragma mark ==YConsDetailPutViewDelegate==
-(void)getConsInfo:(NSString *)detail{
    _model.info = detail;
}

#pragma mark ==YChooseConsCellDelegate==
-(void)consCellCancel:(NSInteger)tag{
    if (_model.list.count<=1) {
        [_model.list removeAllObjects];
    }else{
        [_model.list removeObjectAtIndex:tag];
    }
    [_tableV reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
