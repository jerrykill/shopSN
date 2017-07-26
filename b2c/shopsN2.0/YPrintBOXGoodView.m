//
//  YPrintBOXGoodView.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPrintBOXGoodView.h"

@interface YPrintBOXGoodView()
{
    CGFloat width;
    CGFloat height;
}
@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *priceLb;

@end

@implementation YPrintBOXGoodView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        width = frame.size.width;
        height = frame.size.height;
        [self initView];
    }
    return self;
}

-(void)initView{
    _backV = [[UIView alloc]initWithFrame:CGRectMake(9, 5, width, 164)];
    [self addSubview:_backV];
    _backV.layer.borderColor = __BackColor.CGColor;
    _backV.layer.borderWidth = 1;
    [self sendSubviewToBack:_backV];

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, width-20, 100)];
    [_backV addSubview:_goodIV];
    _goodIV.contentMode = UIViewContentModeScaleToFill;
    _goodIV.clipsToBounds = YES;
    _goodIV.backgroundColor = LH_RandomColor;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_goodIV)+10, width-20, 15)];
    [_backV addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(14);
    _titleLb.textColor = [UIColor blackColor];
    _titleLb.backgroundColor = [UIColor clearColor];

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+6, width-20, 14)];
    [_backV addSubview:_priceLb];
    _priceLb.textAlignment = NSTextAlignmentLeft;
    _priceLb.backgroundColor = [UIColor clearColor];
    

    _pinIV= [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 35, 34)];
    [self addSubview:_pinIV];
    [self bringSubviewToFront:_pinIV];



}

-(void)setModel:(YGoodsModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.goodTitle;
    NSMutableAttributedString *atrri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@/¥%@",_model.goodMoney,_model.goodOldMoney]];
    [atrri addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(224, 40, 40) range:NSMakeRange(0, _model.goodMoney.length+1)];
    [atrri addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(168, 168, 168) range:NSMakeRange(_model.goodMoney.length+1, atrri.length-_model.goodMoney.length-1)];
    [atrri addAttribute:NSFontAttributeName value:MFont(12) range:NSMakeRange(1, _model.goodMoney.length-3)];
    [atrri addAttribute:NSFontAttributeName value:MFont(9) range:NSMakeRange(0, 1)];
    [atrri addAttribute:NSFontAttributeName value:MFont(9) range:NSMakeRange(_model.goodMoney.length-1, _model.goodOldMoney.length+4)];
    [atrri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(_model.goodMoney.length+3, _model.goodOldMoney.length)];
    _priceLb.attributedText = atrri;
    _pinIV.image = MImage(model.activeName);
}

@end
