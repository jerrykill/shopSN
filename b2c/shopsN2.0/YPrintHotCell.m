//
//  YPrintHotCell.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPrintHotCell.h"

@interface YPrintHotCell()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *priceLb;

@end

@implementation YPrintHotCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width =(__kWidth-4)/2;
    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, width-30, 150)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleToFill;
    _goodIV.clipsToBounds = YES;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectYH(_goodIV)+20, width-30, 20)];
    [self addSubview:_titleLb];
    _titleLb.font = MFont(15);
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.textColor = __DTextColor;

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectYH(_titleLb)+10, width-30, 15)];
    [self addSubview:_priceLb];
    _priceLb.textColor = __MoneyColor;
    _priceLb.textAlignment = NSTextAlignmentLeft;
    

}

-(void)setModel:(YGoodsModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.goodTitle;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodMoney]];
    [attri addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(0, 1)];
    [attri addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(1, attri.length-3)];
    [attri addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(attri.length-3, 3)];
    [attri addAttribute:NSForegroundColorAttributeName value:__MoneyColor range:NSMakeRange(0, attri.length)];
    _priceLb.attributedText = attri;

}


@end
