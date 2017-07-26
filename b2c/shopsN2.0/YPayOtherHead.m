//
//  YPayOtherHead.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayOtherHead.h"

@interface YPayOtherHead ()

@property (strong,nonatomic) UIButton *payBtn;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YPayOtherHead

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, __kWidth-20, 45)];
    [self addSubview:_payBtn];
    _payBtn.backgroundColor = __DefaultColor;
    _payBtn.layer.cornerRadius = 5;
    _payBtn.titleLabel.font = MFont(16);
    [_payBtn setTitle:@"立即支付" forState:BtnNormal];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_payBtn addTarget:self action:@selector(choosePays) forControlEvents:BtnTouchUpInside];

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_payBtn)+25, 100, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.backgroundColor = [UIColor whiteColor];
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(15);
    _titleLb.text = @"其他支付方式";

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 109, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)choosePays{
    [self.delegate choosePay];
}
-(void)setTitle:(NSString *)title{
    [_payBtn setTitle:title forState:BtnNormal];
}



@end
