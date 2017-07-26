//
//  YOrderSuccessHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderSuccessHeadView.h"

@interface YOrderSuccessHeadView ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YOrderSuccessHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *successIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-95)/2, 33, 95, 95)];
    [self addSubview:successIV];
    successIV.layer.cornerRadius = 47.5;
    successIV.backgroundColor = [UIColor clearColor];
    successIV.image = MImage(@"complete");

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(successIV)+17, __kWidth, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(19);

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb)+10, __kWidth, 15)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.textColor = LH_RGBCOLOR(170, 170, 170);
    _detailLb.font = MFont(14);
    
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
}

@end
