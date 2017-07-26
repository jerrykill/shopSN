//
//  YSPromotionGoodView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSPromotionGoodView.h"

@interface YSPromotionGoodView ()
{
    CGFloat _width;
    CGFloat _height;
}

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *nameLbl;

@property (strong,nonatomic) UILabel *priceLbl;

@property (strong,nonatomic) UILabel *oldLbl;

@property (strong,nonatomic) UIImageView *logoIV;

@end

@implementation YSPromotionGoodView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (void)initView {
    [self addSubview:self.goodIV];
    [self addSubview:self.nameLbl];
    [self addSubview:self.priceLbl];
    [self addSubview:self.oldLbl];
    [self addSubview:self.logoIV];
}

- (UIImageView *)goodIV {
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
        _goodIV.contentMode = UIViewContentModeScaleToFill;
        _goodIV.layer.masksToBounds = YES;
        _goodIV.backgroundColor = LH_RandomColor;
    }
    return _goodIV;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectYH(_goodIV)+10, 100, 32)];
        _nameLbl.numberOfLines =2;
        _nameLbl.textColor = __TextColor;
        _nameLbl.font = MFont(12);

    }
    return _nameLbl;
}

- (UILabel *)priceLbl {
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectYH(_nameLbl)+4, 65, 15)];
        _priceLbl.textColor = __MoneyColor;
        _priceLbl.font = MFont(11);
    }
    return _priceLbl;
}

- (UILabel *)oldLbl {
    if (!_oldLbl) {
        _oldLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectYH(_priceLbl), 65, 10)];
        _oldLbl.textColor = LH_RGBCOLOR(168, 168, 168);
        _oldLbl.font = MFont(8);

    }
    return _oldLbl;
}

- (UIImageView *)logoIV {
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_priceLbl)+5, CGRectYH(_nameLbl)+7, 22, 22)];
        _logoIV.image =  MImage(@"促");

    }
    return _logoIV;
}

- (void)setModel:(YGoodsModel *)model {
    _model =  model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _nameLbl.text = _model.goodTitle;
    _priceLbl.text = [NSString stringWithFormat:@"¥%@",_model.goodMoney];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodOldMoney]];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attr.length)];
    _oldLbl.attributedText = attr;
}

@end
