//
//  YGiftGoodCell.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftGoodCell.h"

@interface YGiftGoodCell ()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *integralLb;

@property (strong,nonatomic) UILabel *referenceLb;

@end

@implementation YGiftGoodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.integralLb];
    [self addSubview:self.referenceLb];


    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 123, __kWidth*270/375-30, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 105*__kWidth/375, 105)];
        _goodIV.backgroundColor =LH_RandomColor;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 15, __kWidth*270/375-40, 40)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.numberOfLines = 2;
        _titleLb.textColor = __TextColor;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UILabel *)integralLb{
    if (!_integralLb) {
        _integralLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+14, 200*__kWidth/375, 15)];
        _integralLb.textAlignment = NSTextAlignmentLeft;
    }
    return _integralLb;
}

-(UILabel *)referenceLb{
    if (!_referenceLb) {
        _referenceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_integralLb)+10, 200*__kWidth/375, 15)];
        _referenceLb.textAlignment = NSTextAlignmentLeft;
        _referenceLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _referenceLb.font = MFont(12);
    }
    return _referenceLb;
}

-(void)setModel:(YGiftGoodModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.goodTitle;
    if (IsNilString(_model.exchangeMoney)) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",_model.integral]];
        [attr addAttributes:@{NSFontAttributeName:MFont(15),NSForegroundColorAttributeName:LH_RGBCOLOR(242, 48, 48)} range:NSMakeRange(0, attr.length-2)];
        [attr addAttributes:@{NSFontAttributeName:MFont(12),NSForegroundColorAttributeName:LH_RGBCOLOR(102, 102, 102)} range:NSMakeRange(attr.length-2, 2)];
        _integralLb.attributedText = attr;
    }else{
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分 + %@ 元",_model.integral,_model.exchangeMoney]];
        [attr addAttributes:@{NSFontAttributeName:MFont(15),NSForegroundColorAttributeName:LH_RGBCOLOR(242, 48, 48)} range:NSMakeRange(0, _model.integral.length)];
        [attr addAttributes:@{NSFontAttributeName:MFont(12),NSForegroundColorAttributeName:LH_RGBCOLOR(102, 102, 102)} range:NSMakeRange(_model.integral.length, attr.length-_model.exchangeMoney.length-_model.integral.length-1)];
        [attr addAttributes:@{NSFontAttributeName:MFont(15),NSForegroundColorAttributeName:LH_RGBCOLOR(242, 48, 48)} range:NSMakeRange(attr.length-_model.exchangeMoney.length-2 , _model.exchangeMoney.length)];
        [attr addAttributes:@{NSFontAttributeName:MFont(12),NSForegroundColorAttributeName:LH_RGBCOLOR(102, 102, 102)} range:NSMakeRange(attr.length-1, 1)];
        _integralLb.attributedText = attr;
    }
    _referenceLb.text = [NSString stringWithFormat:@"市场参考价：%@元",_model.money];
}

@end
