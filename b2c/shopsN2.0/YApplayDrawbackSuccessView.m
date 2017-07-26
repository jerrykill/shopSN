//
//  YApplayDrawbackSuccessView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplayDrawbackSuccessView.h"
#import "YOrderSuccessHeadView.h"

@interface YApplayDrawbackSuccessView ()

@property (strong,nonatomic) YOrderSuccessHeadView *headV;

@property (strong,nonatomic) UIButton *continueBtn;

@end

@implementation YApplayDrawbackSuccessView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

- (void)initView{
    _headV = [[YOrderSuccessHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 200)];
    [self addSubview:_headV];
    _headV.title = @"申请退款成功";
    _headV.detail = @"我们将于1-3个工作日内，退至您的付款账户";

    _continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(47, CGRectYH(_headV)+33, __kWidth-94, 42)];
    [self addSubview:_continueBtn];
    _continueBtn.layer.cornerRadius = 5;
    _continueBtn.backgroundColor = __DefaultColor;
    _continueBtn.titleLabel.font = MFont(18);
    [_continueBtn setTitle:@"继续逛逛" forState:BtnNormal];
    [_continueBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_continueBtn addTarget:self action:@selector(lookcon) forControlEvents:BtnTouchUpInside];
}

-(void)lookcon{
    [self.delegate continueBuy];
}

@end
