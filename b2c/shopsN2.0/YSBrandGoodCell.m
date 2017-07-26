//
//  YSBrandGoodCell.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandGoodCell.h"


@interface YSBrandGoodCell ()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLbl;

@property (strong,nonatomic) UILabel *priceLbl;

@property (strong,nonatomic) UILabel *evaluateLbl;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YSBrandGoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLbl];
    [self addSubview:self.priceLbl];
    [self addSubview:self.evaluateLbl];
    [self addSubview:self.bottomIV];
    
}

- (UIImageView *)goodIV {
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(AutoWidth(10), AutoWidth(13), AutoWidth(110), AutoWidth(110))];
        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.contentMode = UIViewContentModeScaleToFill;
        _goodIV.layer.masksToBounds = YES;
    }
    return _goodIV;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+AutoWidth(10), AutoWidth(18), AutoWidth(230), AutoWidth(40))];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.numberOfLines = 2;
        _titleLbl.textColor = __DTextColor;
        _titleLbl.font = MFont(AutoWidth(15));
    }
    return _titleLbl;
}

- (UILabel *)priceLbl {
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+AutoWidth(10), CGRectYH(_titleLbl)+AutoWidth(16), AutoWidth(230), AutoWidth(20))];
        _priceLbl.textAlignment = NSTextAlignmentLeft;
        _priceLbl.textColor = __MoneyColor;

    }
    return _priceLbl;
}

- (UILabel *)evaluateLbl {
    if (!_evaluateLbl) {
        _evaluateLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+AutoWidth(10), CGRectYH(_priceLbl)+AutoWidth(10), AutoWidth(200), AutoWidth(15))];
        _evaluateLbl.textAlignment = NSTextAlignmentLeft;
        _evaluateLbl.textColor = __LightTextColor;
        _evaluateLbl.font =MFont(AutoWidth(13));

    }
    return _evaluateLbl;
}

- (UIImageView *)bottomIV {
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+AutoWidth(8), AutoWidth(129), AutoWidth(235), AutoWidth(1))];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}

- (void)setModel:(YGoodsModel *)model {
    _titleLbl.text = model.goodTitle;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _evaluateLbl.text = [NSString stringWithFormat:@"已有%@条评论",model.goodeValuateCount];

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.goodMoney]];
    [attr addAttribute:NSFontAttributeName value:MFont(AutoWidth(12)) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:MFont(AutoWidth(17)) range:NSMakeRange(1, attr.length-4)];
    [attr addAttribute:NSFontAttributeName value:MFont(AutoWidth(14)) range:NSMakeRange(attr.length-3, 3)];
    _priceLbl.attributedText = attr;
}


@end
