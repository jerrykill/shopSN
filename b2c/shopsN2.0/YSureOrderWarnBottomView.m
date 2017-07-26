//
//  YSureOrderWarnBottomView.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderWarnBottomView.h"

@interface YSureOrderWarnBottomView ()

@property (strong,nonatomic) UIButton *titleBtn;

@end

@implementation YSureOrderWarnBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 44)];
    [self addSubview:_titleBtn];
    _titleBtn.backgroundColor =[UIColor clearColor];
    _titleBtn.titleLabel.font = MFont(12);
    [_titleBtn setTitleColor:__DefaultColor forState:BtnNormal];
    _titleBtn.userInteractionEnabled = NO;
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setTitle:(NSString *)title{
    [_titleBtn setTitle:title forState:BtnNormal];
}

@end
