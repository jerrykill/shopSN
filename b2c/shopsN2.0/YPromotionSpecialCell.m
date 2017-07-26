//
//  YPromotionSpecialCell.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionSpecialCell.h"

@interface YPromotionSpecialCell()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UILabel *oldPriceLb;

@property (strong,nonatomic) UIButton *shopBtn;

@end

@implementation YPromotionSpecialCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        self.layer.cornerRadius =4;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = (__kWidth-30)/2;

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, width-20, 150)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleToFill;
    _goodIV.clipsToBounds = YES;

    _titleLb= [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_goodIV)+10, width-20, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(12);
    _titleLb.textColor = LH_RGBCOLOR(86, 86, 86);

    UIImageView *logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+7, 30, 18)];
    [self addSubview:logoIV];
    logoIV.image = MImage(@"cu");

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(logoIV)+4, CGRectYH(_titleLb)+7, 60, 16)];
    [self addSubview:_priceLb];
    _priceLb.textColor = LH_RGBCOLOR(224, 40, 40);
    _priceLb.textAlignment = NSTextAlignmentLeft;

    _oldPriceLb = [[UILabel alloc]initWithFrame:CGRectMake(width-60, CGRectYH(_titleLb)+7, 50, 16)];
    [self addSubview:_oldPriceLb];
    _oldPriceLb.textColor = LH_RGBCOLOR(187, 187, 187);
    _oldPriceLb.font = MFont(10);
    _oldPriceLb.textAlignment = NSTextAlignmentRight;

    _shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectYH(_priceLb)+8, width-20, 32)];
    [self addSubview:_shopBtn];
    _shopBtn.backgroundColor = LH_RGBCOLOR(222, 15, 44);
    _shopBtn.titleLabel.font = MFont(15);
    [_shopBtn setTitle:@"加入购物车 >" forState:BtnNormal];
    [_shopBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_shopBtn addTarget:self action:@selector(shopGood) forControlEvents:BtnTouchUpInside];


}

- (void)shopGood{
    [self.delegate chooseSpecialGood:self.tag];
}

-(void)setModel:(YGoodsModel *)model{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = model.goodTitle;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.goodMoney]];
    [attr addAttribute:NSFontAttributeName value:MFont(10) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(1, attr.length-4)];
    [attr addAttribute:NSFontAttributeName value:MFont(10) range:NSMakeRange(attr.length-3, 3)];
    _priceLb.attributedText = attr;
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.goodOldMoney]];
    [attr2 addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attr2.length)];
    _oldPriceLb.attributedText =attr2;
}

@end
