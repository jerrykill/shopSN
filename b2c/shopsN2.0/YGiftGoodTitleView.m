
//
//  YGiftGoodTitleView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftGoodTitleView.h"

@interface YGiftGoodTitleView ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *integralLb;

@property (strong,nonatomic) UILabel *referenceLb;

@property (strong,nonatomic) UIImageView *logoIV;

@end

@implementation YGiftGoodTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.logoIV];

    [self addSubview:self.integralLb];

    [self addSubview:self.referenceLb];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, __kWidth-20, 45)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(18);
        _titleLb.numberOfLines =2;
    }
    return _titleLb;
}

-(UIImageView *)logoIV{
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+14, 20, 20)];
        _logoIV.layer.cornerRadius = 10;
        _logoIV.image = MImage(@"integral_ico");
    }
    return _logoIV;
}



-(UILabel *)integralLb{
    if (!_integralLb) {
        _integralLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+8, CGRectYH(_titleLb)+14, __kWidth-100, 20)];
        _integralLb.textAlignment = NSTextAlignmentLeft;
    }
    return _integralLb;
}

-(UILabel *)referenceLb{
    if (!_referenceLb) {
        _referenceLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_integralLb)+9, __kWidth-20, 15)];
        _referenceLb.textAlignment = NSTextAlignmentLeft;
        _referenceLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _referenceLb.font = MFont(13);
    }
    return _referenceLb;
}

-(void)setModel:(YGiftGoodModel *)model{
    _model = model;
    _titleLb.text = model.goodTitle;
    if (IsNilString(model.exchangeMoney)) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",_model.integral]];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(224, 40, 40),NSFontAttributeName:MFont(19)} range:NSMakeRange(0, attr.length-2)];
        [attr addAttributes:@{NSForegroundColorAttributeName:__TextColor,NSFontAttributeName:MFont(14)} range:NSMakeRange(attr.length-2, 2)];
        _integralLb.attributedText = attr;
    }else{
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分 + %@ 元",_model.integral,_model.exchangeMoney]];
        [attr addAttributes:@{NSFontAttributeName:MFont(19),NSForegroundColorAttributeName:LH_RGBCOLOR(224, 40, 40)} range:NSMakeRange(0, _model.integral.length)];
        [attr addAttributes:@{NSFontAttributeName:MFont(14),NSForegroundColorAttributeName:__TextColor} range:NSMakeRange(_model.integral.length, attr.length-_model.exchangeMoney.length-_model.integral.length-1)];
        [attr addAttributes:@{NSFontAttributeName:MFont(19),NSForegroundColorAttributeName:LH_RGBCOLOR(224, 40, 40)} range:NSMakeRange(attr.length-_model.exchangeMoney.length-2 , _model.exchangeMoney.length)];
        [attr addAttributes:@{NSFontAttributeName:MFont(14),NSForegroundColorAttributeName:__TextColor} range:NSMakeRange(attr.length-1, 1)];
        _integralLb.attributedText = attr;
    }

    _referenceLb.text = [NSString stringWithFormat:@"市场参考价：%@元",_model.money];

}

@end
