//
//  YShopCartEditView.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopCartEditView.h"


@interface YShopCartEditView ()

@property (strong,nonatomic) UIButton *calcelBtn;

@property (strong,nonatomic) UIButton *shareBtn;

@property (strong,nonatomic) UIButton *collectBtn;

@end


@implementation YShopCartEditView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth*147/375, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    _calcelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 90, 22)];
    [self addSubview:_calcelBtn];
    _calcelBtn.titleLabel.font = MFont(14);
    [_calcelBtn setTitle:@"全选" forState:BtnNormal];
    [_calcelBtn setTitle:@"取消全选" forState:BtnStateSelected];
    [_calcelBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
    [_calcelBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnStateSelected];
    [_calcelBtn setImage:MImage(@"Cart_off") forState:BtnNormal];
    [_calcelBtn setImage:MImage(@"Cart_on") forState:BtnStateSelected];
    _calcelBtn.backgroundColor = [UIColor clearColor];
    _calcelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 70);
    _calcelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [_calcelBtn addTarget:self action:@selector(chooseCancel:) forControlEvents:BtnTouchUpInside];

    _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(lineIV), 0, 92*__kWidth/375, 50)];
    [self addSubview:_shareBtn];
    _shareBtn.backgroundColor =  LH_RGBCOLOR(255, 114, 0);
    _shareBtn.titleLabel.font = MFont(18);
    [_shareBtn setTitle:@"分享" forState:BtnNormal];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_shareBtn addTarget:self action:@selector(chooseShare) forControlEvents:BtnTouchUpInside];

    _collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_shareBtn), 0, 136*__kWidth/375, 50)];
    [self addSubview:_collectBtn];
    _collectBtn.titleLabel.font = MFont(18);
    _collectBtn.backgroundColor = __DefaultColor;
    [_collectBtn setTitle:@"移入收藏夹" forState:BtnNormal];
    [_collectBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_collectBtn addTarget:self action:@selector(chooseCollect) forControlEvents:BtnTouchUpInside];
}

-(void)chooseCancel:(UIButton*)sender{
    sender.selected = !sender.selected;
    [self.delegate SureCancel:sender.selected];
}


-(void)chooseShare{
    [self.delegate sureShare];
}

-(void)chooseCollect{
    [self.delegate sureCollect];
}

-(void)setAllChoose:(BOOL)allChoose{
    _calcelBtn.selected = allChoose;
}

@end
