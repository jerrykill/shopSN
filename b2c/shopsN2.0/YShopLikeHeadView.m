//
//  YShopLikeHeadView.m
//
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopLikeHeadView.h"

@interface YShopLikeHeadView()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YShopLikeHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-140)/2, 10, 140, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = __TextColor;
    _titleLb.font= MFont(15);
    _titleLb.text = @"您可能感兴趣的产品";

    for (int i=0; i<2; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(i*(__kWidth/2+70), 19, (__kWidth-140)/2, 1)];
        [self addSubview:lineIV];
        lineIV.backgroundColor = LH_RGBCOLOR(210, 210, 210);
    }
}

@end

