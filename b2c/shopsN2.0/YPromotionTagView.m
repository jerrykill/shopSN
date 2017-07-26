//
//  YPromotionTagView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionTagView.h"

@interface YPromotionTagView()

@property (strong,nonatomic) UIImageView *backIV;

@property (strong,nonatomic) UIButton *titleBtn;

@end

@implementation YPromotionTagView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)initView{
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [self addSubview:_backIV];
    _backIV.contentMode =  UIViewContentModeScaleAspectFit;
    _backIV.image = MImage(@"lb_bg");

    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [self addSubview:_titleBtn];
    _titleBtn.backgroundColor = [UIColor clearColor];
    _titleBtn.userInteractionEnabled = NO;
    _titleBtn.titleLabel.font = MFont(11);
    [_titleBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
}

-(void)setTitle:(NSString *)title{
    [_titleBtn setTitle:title forState:BtnNormal];
}


@end
