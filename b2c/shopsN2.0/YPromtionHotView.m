//
//  YPromtionHotView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromtionHotView.h"

@interface YPromtionHotView ()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UIImageView *HotIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *shopBtn;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YPromtionHotView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LH_RGBCOLOR(241, 241, 241);
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = 171*__kWidth/375;
    _goodIV= [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, width-80, 90)];
    [self addSubview:_goodIV];

    _goodIV.contentMode = UIViewContentModeScaleToFill;
    _goodIV.clipsToBounds = YES;

    _HotIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+5, 26, 49, 15)];
    [self addSubview:_HotIV];
    _HotIV.image =  MImage(@"HOT");
    _HotIV.contentMode = UIViewContentModeScaleAspectFit;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+5, CGRectYH(_HotIV)+5, 60, 10)];
    [self addSubview:_titleLb];
    _titleLb.textColor = __DefaultColor;
    _titleLb.font = MFont(9);
    _titleLb.textAlignment = NSTextAlignmentLeft;

    _shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+5, CGRectYH(_titleLb)+9, 44, 12)];
    [self addSubview:_shopBtn];
    _shopBtn.titleLabel.font = BFont(5);
    _shopBtn.layer.borderColor = LH_RGBCOLOR(151, 149, 152).CGColor;
    _shopBtn.layer.borderWidth = 1;
    [_shopBtn setTitle:@"SHOP NOW" forState:BtnNormal];
    [_shopBtn setTitleColor:LH_RGBCOLOR(47, 47, 47) forState:BtnNormal];
    _shopBtn.userInteractionEnabled = NO;

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+5, CGRectYH(_shopBtn)+15, 60, 8)];
    [self addSubview:_detailLb];
    _detailLb.textColor = LH_RGBCOLOR(121, 121, 121);
    _detailLb.font = MFont(8);
    _detailLb.adjustsFontSizeToFitWidth = YES;
    _detailLb.textAlignment = NSTextAlignmentLeft;
}

-(void)setModel:(YGoodsModel *)model {
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = model.goodTitle;
    _detailLb.text = model.goodDesc;
}

@end
