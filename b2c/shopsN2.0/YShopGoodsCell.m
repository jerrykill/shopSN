//
//  YShopGoodsCell.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopGoodsCell.h"

@interface YShopGoodsCell()

@property (strong,nonatomic) UIButton *chooseBtn;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UIImageView *lineIV;
@end

@implementation YShopGoodsCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.chooseBtn];
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.detailLb];
    [self addSubview:self.priceLb];
    [self addSubview:self.countLb];
    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 40, 80)];
        [_chooseBtn setImage:MImage(@"Cart_off") forState:BtnNormal];
        [_chooseBtn setImage:MImage(@"Cart_on") forState:BtnStateSelected];
        _chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _chooseBtn.layer.cornerRadius = 10;
        [_chooseBtn addTarget:self action:@selector(choose:) forControlEvents:BtnTouchUpInside];
    }
    return _chooseBtn;
}

-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_chooseBtn), 10, 80, 80)];
//        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.layer.borderColor = __BackColor.CGColor;
        _goodIV.contentMode = UIViewContentModeScaleAspectFit;
        _goodIV.layer.borderWidth = 0.5;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+8, 15, __kWidth-140, 30)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.numberOfLines = 2;
        _titleLb.font = MFont(12);
        _titleLb.textColor = __DTextColor;
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+8, CGRectYH(_titleLb)+5, __kWidth-140, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _detailLb.font = MFont(12);
    }
    return _detailLb;
}

-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+8, CGRectYH(_detailLb)+10, __kWidth-180, 15)];
        _priceLb.textAlignment = NSTextAlignmentLeft;
        _priceLb.textColor = LH_RGBCOLOR(225, 53, 53);
    }
    return _priceLb;
}

-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_priceLb), CGRectYH(_detailLb)+10, 40, 15)];
        _countLb.textAlignment = NSTextAlignmentRight;
        _countLb.textColor = [UIColor blackColor];
        _countLb.font = MFont(15);
    }
    return _countLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 99, __kWidth, 1)];
        _lineIV.backgroundColor =__BackColor;
    }
    return _lineIV;
}

-(void)choose:(UIButton*)sender{
    sender.selected = !sender.selected;
    [self.delegate choose:sender.selected index:self.tag];
}

-(void)setModel:(YShopGoodModel *)model{
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.goodTitle;
    NSString *types = @"";
    for (YGoodTypeModel *dic in _model.goodTypeArr) {
        types = [types stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",dic.name,dic.size]];
    }
    _detailLb.text = types;

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.goodMoney]];
    [attr addAttribute:NSFontAttributeName value:MFont(12) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(1, _model.goodMoney.length-3)];
    [attr addAttribute:NSFontAttributeName value:MFont(12) range:NSMakeRange(_model.goodMoney.length-2, 3)];
    _priceLb.attributedText = attr;

    _countLb.text = [NSString stringWithFormat:@"×%@",_model.goodCount];
    
    _chooseBtn.selected = _model.isChoose;
}

@end
