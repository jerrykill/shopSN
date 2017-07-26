//
//  YPersonWalletCell.m
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonWalletCell.h"

@interface YPersonWalletCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YPersonWalletCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor =  __BackColor;
    
    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth/3-45)/2, 15, 45, 20)];
    [self addSubview:_detailLb];
    _detailLb.textColor = [UIColor blackColor];
    _detailLb.adjustsFontSizeToFitWidth = YES;
    _detailLb.textAlignment = NSTextAlignmentCenter;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_detailLb)+10, __kWidth/3, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = MFont(12);
    _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
    UIFont *i =MFont(15);
    if (_detailLb.font>i) {
        _detailLb.font = MFont(15);
    }
}
@end
