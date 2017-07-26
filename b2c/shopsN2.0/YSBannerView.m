//
//  YSBannerView.m
//  shopsN
//  推送banner图
//  Created by imac on 2017/2/8.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBannerView.h"

@interface YSBannerView ()

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *cancelBtn;

@end

@implementation YSBannerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 40)];
    [self addSubview:_backV];
    _backV.backgroundColor = [UIColor blackColor];
    _backV.alpha = 0.5;
    [self sendSubviewToBack:_backV];

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, __kWidth-70, 20)];
    [self addSubview:_titleLb];
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.font= MFont(15);
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = [UIColor whiteColor];

    _cancelBtn= [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-40, 8, 24, 24)];
    [self addSubview:_cancelBtn];
    _cancelBtn.layer.cornerRadius = 12;
    _cancelBtn.backgroundColor = [UIColor clearColor];
    _cancelBtn.titleLabel.font = MFont(15);
    [_cancelBtn setImage:MImage(@"cancelNo") forState:BtnNormal];
    [_cancelBtn addTarget:self action:@selector(chooseCancel) forControlEvents:BtnTouchUpInside];
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)chooseCancel{
    [self removeFromSuperview];
}


@end
