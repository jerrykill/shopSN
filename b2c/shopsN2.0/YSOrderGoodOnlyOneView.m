//
//  YSOrderGoodOnlyOneView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSOrderGoodOnlyOneView.h"

@interface YSOrderGoodOnlyOneView ()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UILabel *moneyLb;

@property (strong,nonatomic) UIButton *deleteButton;

@end

@implementation YSOrderGoodOnlyOneView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.goodIV];

    [self addSubview:self.titleLb];

    [self addSubview:self.detailLb];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectYH(_goodIV)+7, __kWidth-20, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    [self addSubview:self.countLb];
    _countLb.text = @"共1件商品";

    [self addSubview:self.moneyLb];

    [self addSubview:self.deleteButton];

    UIImageView *linesIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 131, __kWidth, 1)];
    [self addSubview:linesIV];
    linesIV.backgroundColor = __BackColor;
}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 74, 73)];
        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.layer.borderColor = __BackColor.CGColor;
        _goodIV.layer.borderWidth = 1;
        _goodIV.contentMode = UIViewContentModeScaleToFill;
        _goodIV.clipsToBounds = YES;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 12, __kWidth-120, 40)];
        _titleLb.textColor = LH_RGBCOLOR(50, 50, 50);
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.numberOfLines = 2;
        _titleLb.font = MFont(16);
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+11, __kWidth-120, 12)];
        _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _detailLb.font = MFont(11);
        _detailLb.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLb;
}

-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_goodIV)+18, 90, 20)];
        _countLb.textColor = LH_RGBCOLOR(50, 50, 50);
        _countLb.font = MFont(15);
        _countLb.textAlignment = NSTextAlignmentLeft;
    }
    return _countLb;
}

-(UILabel *)moneyLb{
    if (!_moneyLb) {
        _moneyLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_countLb)+10, CGRectYH(_goodIV)+18, __kWidth-120, 20)];
        _moneyLb.textAlignment = NSTextAlignmentLeft;
        _moneyLb.font = MFont(15);
    }
    return _moneyLb;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-40, CGRectYH(_goodIV)+18, 25, 25)];
        [_deleteButton setImage:MImage(@"list_delete") forState:BtnNormal];
        [_deleteButton addTarget:self action:@selector(chooseDelete) forControlEvents:BtnTouchUpInside];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

-(void)setModel:(YSOrderModel *)model{
    _model = model;

    if (model.imageArr.count) {
        [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.imageArr[0]]] placeholderImage:MImage(goodPlachorName)];
    }
    if (!IsNull(model.title)) {
        _titleLb.text = model.title;
    }
    if (_model.typeArr.count) {
        NSString *types = @"";
        for (YGoodTypeModel *dic in _model.typeArr) {
            types = [types stringByAppendingString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@:%@ ",dic.name,dic.size]]];
        }
        _detailLb.text = types;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"实付款：¥%@",model.payMoney]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(50, 50, 50) range:NSMakeRange(0, 4)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(255, 136, 30) range:NSMakeRange(4, attr.length-4)];
    _moneyLb.attributedText = attr;
    if ([model.orderStatus integerValue]>3||[model.orderStatus integerValue]<0) {
        _deleteButton.hidden = NO;
    }else{
        _deleteButton.hidden = YES;
    }
}

- (void)chooseDelete{
    [self.delegate makeOrderDelete:[_model.orderId integerValue]];
}


@end
