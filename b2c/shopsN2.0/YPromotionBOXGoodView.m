//
//  YPromotionBOXGoodView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionBOXGoodView.h"

@interface YPromotionBOXGoodView()

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *priceLb;

@end

@implementation YPromotionBOXGoodView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = (__kWidth-40)/3.5;
    _backV = [[UIView alloc]initWithFrame:CGRectMake(10, 7, width, 135)];
    [self addSubview:_backV];
    _backV.backgroundColor = [UIColor whiteColor];
    _backV.layer.cornerRadius = 5;

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(7, 10, width-14, 75)];
    [_backV addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleToFill;
    _goodIV.clipsToBounds = YES;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(7, CGRectYH(_goodIV)+10, width-14, 13)];
    [_backV addSubview:_titleLb];
    _titleLb.textColor = __TextColor;
    _titleLb.font = MFont(12);
    _titleLb.textAlignment =NSTextAlignmentCenter;

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(7, CGRectYH(_titleLb)+5, width-14, 10)];
    [_backV addSubview:_priceLb];
    _priceLb.textAlignment = NSTextAlignmentCenter;


}

-(void)setModel:(YGoodsModel *)model{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = model.goodTitle;
    NSInteger money = [model.goodMoney integerValue];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"特卖价¥%ld",(long)money]];
    [attr addAttribute:NSFontAttributeName value:MFont(8) range:NSMakeRange(0, 4)];
    [attr addAttribute:NSFontAttributeName value:MFont(10) range:NSMakeRange(4, attr.length-4)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(179, 179, 179) range:NSMakeRange(0, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(3, attr.length-3)];
    _priceLb.attributedText = attr;
}

@end
