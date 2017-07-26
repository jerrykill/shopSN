//
//  YPayCardCheckView.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayCardCheckView.h"
#import "YAddNewCardCell.h"
#import "YCheckCardCell.h"

@interface YPayCardCheckView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UIButton *titleBtn;

@property (strong,nonatomic) UIButton *cancelBtn;

@property (strong,nonatomic) UITableView *tableV;

@end

@implementation YPayCardCheckView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCancel)];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor blackColor];
    headV.alpha = 0.2;
    [headV addGestureRecognizer:tap];

}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(0, __kHeight-48*(_dataArr.count+2), __kWidth, 48*(_dataArr.count+2))];
    [self addSubview:mainV];
    mainV.backgroundColor = [UIColor whiteColor];

    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth-150)/2, 0, 150, 48)];
    [mainV addSubview:_titleBtn];
    _titleBtn.backgroundColor = [UIColor whiteColor];
    _titleBtn.titleLabel.font = MFont(15);
    [_titleBtn setTitle:@"选择银行卡" forState:BtnNormal];
    [_titleBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    _titleBtn.userInteractionEnabled = NO;

    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 0, 35, 35)];
    [mainV addSubview:_cancelBtn];
    _cancelBtn.titleLabel.font = MFont(32);
    [_cancelBtn setTitle:@"×" forState:BtnNormal];
    [_cancelBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [_cancelBtn addTarget:self action:@selector(chooseCancel) forControlEvents:BtnTouchUpInside];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 47, __kWidth, 1)];
    [mainV addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(lineIV), __kWidth, 48*(_dataArr.count+1))];
    [mainV addSubview:_tableV];
    _tableV.backgroundColor = [UIColor whiteColor];
    _tableV.separatorColor = [UIColor clearColor];
    _tableV.delegate = self;
    _tableV.dataSource = self;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = nil;
    if (indexPath.row<_dataArr.count) {
        YCheckCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCheckCardCell"];
        if (!cell) {
            cell = [[YCheckCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YCheckCardCell"];
        }
        cell.title = _dataArr[indexPath.row];
        cells = cell;
    }else{
        YAddNewCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YAddNewCardCell"];
        if (!cell) {
            cell= [[YAddNewCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YAddNewCardCell"];
        }
        cells = cell;
    }
    return cells;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<_dataArr.count) {
        [self.delegate chooseCheckAction:_dataArr[indexPath.row] index:indexPath.row];
    }else{
        [self.delegate chooseAddNew];
    }
}

#pragma mark ==取消按钮==
-(void)chooseCancel{
    [self removeFromSuperview];
}


@end
