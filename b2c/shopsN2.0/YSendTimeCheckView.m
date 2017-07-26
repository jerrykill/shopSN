//
//  YSendTimeCheckView.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSendTimeCheckView.h"
#import "YSendTimeAreaChooseView.h"
#import "YSendTimeCell.h"

@interface YSendTimeCheckView ()<UITableViewDelegate,UITableViewDataSource,YSendTimeAreaChooseViewDelegate>

@property (strong,nonatomic) UIButton *titleBtn;

@property (strong,nonatomic) UIButton *cancelBtn;

@property (strong,nonatomic) UITableView *dataV;

@property (strong,nonatomic) YSendTimeAreaChooseView *areaV;

@property (nonatomic) NSInteger chooseIndex;

@property (strong,nonatomic) NSString *chooseTime;

@end

@implementation YSendTimeCheckView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor= [UIColor clearColor];
        _chooseIndex = 999;
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCancel)];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight/2)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor blackColor];
    headV.alpha = 0.2;
    [headV addGestureRecognizer:tap];

    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(headV), __kWidth, __kHeight/2)];
    [self addSubview:mainV];
    mainV.backgroundColor = [UIColor whiteColor];

    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth-150)/2, 0, 150, 48)];
    [mainV addSubview:_titleBtn];
    _titleBtn.backgroundColor = [UIColor whiteColor];
    _titleBtn.titleLabel.font = MFont(15);
    [_titleBtn setTitle:@"送货时间" forState:BtnNormal];
    [_titleBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    _titleBtn.userInteractionEnabled = NO;

    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 0, 35, 35)];
    [mainV addSubview:_cancelBtn];
    _cancelBtn.titleLabel.font = MFont(32);
    [_cancelBtn setTitle:@"×" forState:BtnNormal];
    [_cancelBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [_cancelBtn addTarget:self action:@selector(chooseCancel) forControlEvents:BtnTouchUpInside];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 48, __kWidth, 1)];
    [mainV addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
    

    _dataV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(lineIV), 120, __kHeight/2-45)];
    [mainV addSubview:_dataV];
    _dataV.backgroundColor = [UIColor whiteColor];
    _dataV.separatorColor = __BackColor;
    _dataV.delegate = self;
    _dataV.dataSource = self;

    _areaV = [[YSendTimeAreaChooseView alloc]initWithFrame:CGRectMake(CGRectXW(_dataV), CGRectYH(lineIV), __kWidth-120, __kHeight/2-45)];
    [mainV addSubview:_areaV];
    _areaV.delegate=self;

}

#pragma mark ==UITableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSendTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSendTimeCell"];
    if (!cell) {
        cell= [[YSendTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YSendTimeCell"];
    }
    cell.title = _dataArr[indexPath.row];
    if (indexPath.row ==_chooseIndex) {
        cell.choose = YES;
    }else{
        cell.choose = NO;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _chooseIndex =indexPath.row;
    if (!IsNilString(_chooseTime)) {
        [self.delegate chooseTime:_chooseTime day:_dataArr[_chooseIndex]];
        [self chooseCancel];
    }
    [_dataV reloadData];
}

#pragma mark ==YSendTimeAreaChooseViewDelegate==
-(void)chooseSendTime:(NSString *)str{
    _chooseTime = str;
    if (_chooseIndex!=999) {
        [self.delegate chooseTime:str day:_dataArr[_chooseIndex]];
         [self chooseCancel];
    }else{
        [SXLoadingView showAlertHUD:@"请选择日期" duration:1.5];
    }

}


- (void)chooseCancel{
    [self removeFromSuperview];
}

@end
