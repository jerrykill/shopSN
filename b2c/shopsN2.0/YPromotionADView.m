//
//  YPromotionADView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionADView.h"

@interface YPromotionADView()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UIButton *titleBtn;

@property (strong,nonatomic) UILabel *detailLb;


@end


@implementation YPromotionADView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(10, 14, 178*__kWidth/375, 225)];
    [self addSubview:backV];
    backV.layer.borderColor = LH_RGBCOLOR(251, 177, 179).CGColor;
    backV.layer.borderWidth = 2;

    CGFloat width = 178*__kWidth/375;

    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake((width-93)/2, 54, 93, 70)];
    [backV addSubview:_headIV];
    _headIV.backgroundColor = LH_RandomColor;
    _headIV.contentMode = UIViewContentModeScaleAspectFit;

    UIImageView *lineColorIV = [[UIImageView alloc]initWithFrame:CGRectMake((width-131)/2, CGRectYH(_headIV)+12, 131, 19)];
    [backV addSubview:lineColorIV];
    lineColorIV.backgroundColor = LH_RGBCOLOR(255, 245, 214);

    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake((width-93)/2, CGRectYH(_headIV)+7, 93, 19)];
    [backV addSubview:_titleBtn];
    _titleBtn.backgroundColor = __DefaultColor;
    _titleBtn.titleLabel.font = MFont(12);
    [_titleBtn setTitle:@"最新促销来袭" forState:BtnNormal];
    [_titleBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    _titleBtn.userInteractionEnabled = NO;

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake((width-94)/2, CGRectYH(_titleBtn)+14, 94, 10)];
    [backV addSubview:_detailLb];
    _detailLb.textColor = LH_RGBCOLOR(201, 145, 85);
    _detailLb.font = MFont(9);
    _detailLb.text = @"疯狂折扣购 商用进行时";

    UIImageView *blueIV = [[UIImageView alloc]initWithFrame:CGRectMake((width-93)/2-2+10, 222, 23, 28)];
    [self addSubview:blueIV];
    blueIV.backgroundColor = LH_RandomColor;
    
}


@end
