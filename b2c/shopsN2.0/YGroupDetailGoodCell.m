//
//  YGroupDetailGoodCell.m
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGroupDetailGoodCell.h"

@interface YGroupDetailGoodCell()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UIButton *evaluateBtn;

@end


@implementation YGroupDetailGoodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.detailLb];
    [self addSubview:self.priceLb];
    [self addSubview:self.countLb];
    [self addSubview:self.evaluateBtn];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 99, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor =__BackColor;
}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.layer.borderColor = __BackColor.CGColor;
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
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+8, CGRectYH(_titleLb)+5, __kWidth-180, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _detailLb.font = MFont(12);
    }
    return _detailLb;
}

-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+8, CGRectYH(_detailLb)+10, __kWidth-180, 15)];
        _priceLb.textAlignment = NSTextAlignmentLeft;
        _priceLb.textColor = __DTextColor;
    }
    return _priceLb;
}

-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-70, CGRectYH(_detailLb)+10, 60, 15)];
        _countLb.textAlignment = NSTextAlignmentRight;
        _countLb.textColor = __DefaultColor;
        _countLb.font = MFont(15);
    }
    return _countLb;
}

- (UIButton *)evaluateBtn {
    if (!_evaluateBtn) {
        _evaluateBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-90, CGRectYH(_detailLb)+10, 85, 20)];
        _evaluateBtn.layer.cornerRadius = 10;
        _evaluateBtn.layer.borderColor = LH_RGBCOLOR(80, 80, 80).CGColor;
        _evaluateBtn.layer.borderWidth = 1;
        [_evaluateBtn setTitle:@"评价商品" forState:BtnNormal];
        [_evaluateBtn setTitleColor:__DefaultColor forState:BtnNormal];
        _evaluateBtn.titleLabel.font = MFont(14);
        [_evaluateBtn addTarget:self action:@selector(chooseEvalue) forControlEvents:BtnTouchUpInside];
        _evaluateBtn.hidden = YES;
    }
    return _evaluateBtn;
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
    _priceLb.text = [NSString stringWithFormat:@"¥%@",_model.goodMoney];
    _countLb.text = [NSString stringWithFormat:@"×%@",_model.goodCount];

}

- (void)setStatus:(NSString *)status {
    _countLb.frame = CGRectMake(__kWidth-70, CGRectYH(_titleLb)+5, 60, 15);
    _evaluateBtn.hidden = NO;
}

- (void)chooseEvalue {
    [self.delegate chooseEvaluate:_model];
}

@end
