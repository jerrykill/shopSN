//
//  YGoodDetailChooseCell.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailChooseCell.h"

@interface YGoodDetailChooseCell()

@property (strong,nonatomic) UILabel *titlelb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YGoodDetailChooseCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titlelb];
    [self addSubview:self.detailLb];
    [self addSubview:self.lineIV];
    [self addSubview:self.bottomIV];

}

-(void)setTitle:(NSString *)title{
    _titlelb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
}

#pragma mark ==懒加载==
-(UILabel *)titlelb{
    if (!_titlelb) {
        _titlelb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 45, 15)];
        _titlelb.textAlignment =NSTextAlignmentLeft;
        _titlelb.textColor = LH_RGBCOLOR(119, 119, 119);
        _titlelb.font = MFont(13);
    }
    return _titlelb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_titlelb)+5, 20, __kWidth-100, 16)];
        _detailLb.textColor = __DTextColor;
        _detailLb.textAlignment =NSTextAlignmentLeft;
        _detailLb.font = MFont(15);

    }
    return _detailLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-30, 21.5, 8, 13)];
        _lineIV.image = MImage(@"arrow");
        _lineIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lineIV;
}

-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}

@end
