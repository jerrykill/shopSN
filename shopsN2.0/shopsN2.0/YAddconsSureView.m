//
//  YAddconsSureView.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddconsSureView.h"
#import "YApplicationDetailCell.h"


@interface YAddconsSureView ()<UITableViewDelegate,UITableViewDataSource,YApplicationDetailCellDelegate>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) UIButton *sureBtn;

@property (strong,nonatomic) YConsModel *model;

@end

@implementation YAddconsSureView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _model = [[YConsModel alloc]init];
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 100)];
    [self addSubview:_tableV];
    _tableV.separatorColor = __BackColor;
    _tableV.delegate = self;
    _tableV.dataSource = self;

    UILabel *warnLb = [[UILabel alloc]initWithFrame:CGRectMake(16,CGRectYH(_tableV)+20, __kWidth-135, 30)];
    [self addSubview:warnLb];
    warnLb.backgroundColor = __BackColor;
    warnLb.textAlignment = NSTextAlignmentLeft;
    warnLb.numberOfLines = 2;
    warnLb.textColor =  LH_RGBCOLOR(153, 153, 153);
    warnLb.font = MFont(11);
    warnLb.text = @"提示：\n可填写多个所需耗材，点击确认提交所填耗材";

    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-125, CGRectYH(_tableV)+17, 115, 40)];
    [self addSubview:_sureBtn];
    _sureBtn.backgroundColor = LH_RGBCOLOR(143, 143, 143);
    _sureBtn.layer.cornerRadius = 2;
    _sureBtn.titleLabel.font = MFont(16);
    [_sureBtn setTitle:@"确认" forState:BtnNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_sureBtn addTarget:self action:@selector(chooseSure) forControlEvents:BtnTouchUpInside];
    _sureBtn.userInteractionEnabled = NO;
}
#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YApplicationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YApplicationDetailCell"];
    if (!cell) {
        cell = [[YApplicationDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YApplicationDetailCell"];
    }
    if (indexPath.row==0) {
      cell.title = @"所需耗材：";
        if (IsNilString(_model.title)) {
            cell.detail =@"";
        }
    }else{
        cell.title = @"所需数量：";
        if (IsNilString(_model.num)) {
            cell.detail =@"";
        }
    }
    cell.font = 16;
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark ==YApplicationDetailCellDelegate==
-(void)getApplyDetail:(NSString *)text Index:(NSInteger)tag{
    switch (tag) {
        case 0:
        {
            _model.title = text;
        }
            break;
        case 1:
        {
            _model.num = text;
        }
            break;
        default:
            break;
    }
    if (IsNilString(_model.title)||IsNilString(_model.num)) {
       _sureBtn.userInteractionEnabled = NO;
        _sureBtn.backgroundColor  =LH_RGBCOLOR(143, 143, 143);
    }else{
        _sureBtn.userInteractionEnabled = YES;
        _sureBtn.backgroundColor = __DefaultColor;
    }
}



#pragma mark ==确认==
-(void)chooseSure{
    [self.delegate putCons:_model];
    [_tableV reloadData];
    _model= [[YConsModel alloc]init];
    _sureBtn.userInteractionEnabled = NO;
    _sureBtn.backgroundColor  =LH_RGBCOLOR(143, 143, 143);
}

@end
