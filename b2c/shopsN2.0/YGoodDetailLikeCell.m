//
//  YGoodDetailLikeCell.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailLikeCell.h"

@interface YGoodDetailLikeCell()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *priceLb;


@end

@implementation YGoodDetailLikeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.priceLb];
}

-(void)setModel:(YGoodDetailModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.goodTitle;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodMoney]];
    [attr addAttribute:NSFontAttributeName value:MFont(10) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(1, attr.length-1)];
    _priceLb.attributedText = attr;
}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, (__kWidth-44)/3, (__kWidth-44)/3)];
        _goodIV.image = MImage(@"Home_list_pro_1");
        _goodIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_goodIV)+4, (__kWidth-44)/3, 30)];
        _titleLb.textAlignment =NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(114, 115, 116);
        _titleLb.font = MFont(11);
        _titleLb.numberOfLines =2;
    }
    return _titleLb;
}

-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectYH(_titleLb)+5, (__kWidth-44)/3-4, 15)];
        _priceLb.textAlignment = NSTextAlignmentLeft;
        _priceLb.textColor = LH_RGBCOLOR(224, 40, 40);
    }
    return _priceLb;
}

@end
