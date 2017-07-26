//
//  YSOrderGoodsView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSOrderGoodsView.h"

@interface YSOrderGoodsView ()

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UILabel *moneyLb;

@property (strong,nonatomic) UIButton *deleteButton;

@end

@implementation YSOrderGoodsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.countLb];
    [self addSubview:self.moneyLb];
    [self addSubview:self.deleteButton];
}

#pragma mark ==懒加载==
-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 98, 100, 20)];

        _countLb.textColor = LH_RGBCOLOR(50, 50, 50);
        _countLb.font = MFont(15);
        _countLb.textAlignment = NSTextAlignmentLeft;
    }
    return _countLb;
}

-(UILabel *)moneyLb{
    if (!_moneyLb) {
        _moneyLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_countLb)+10, 98, __kWidth-120, 20)];
        _moneyLb.textAlignment = NSTextAlignmentLeft;
        _moneyLb.font = MFont(15);
    }
    return _moneyLb;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-40, 98, 25, 25)];
        [_deleteButton setImage:MImage(@"list_delete") forState:BtnNormal];
        [_deleteButton addTarget:self action:@selector(chooseDelete) forControlEvents:BtnTouchUpInside];
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (void)setModel:(YSOrderModel *)model{
    _model = model;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    for ( int i=0; i<model.imageArr.count; i++) {
        if (i<3) {
            UIImageView *goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10+83*i, 7, 74, 73)];
            goodIV.backgroundColor = LH_RandomColor;
            [goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.imageArr[i]]] placeholderImage:MImage(goodPlachorName)];
            goodIV.layer.borderColor = __BackColor.CGColor;
            goodIV.layer.borderWidth = 1;
            goodIV.contentMode = UIViewContentModeScaleToFill;
            goodIV.clipsToBounds = YES;
            [self addSubview:goodIV];
        }
        if (i==3) {
            UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+83*3+10, 7, 74, 73)];
            [self addSubview:moreBtn];
            moreBtn.titleLabel.font = BFont(50);
            [moreBtn setTitle:@"···" forState:BtnNormal];
            [moreBtn setTitleColor:__BackColor forState:BtnNormal];
            moreBtn.userInteractionEnabled = NO;
        }
    }
    _countLb.text = [NSString stringWithFormat:@"共%@件商品",model.goodCount];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"实付款：%.2f",[model.payMoney floatValue]]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(50, 50, 50) range:NSMakeRange(0, 4)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(255, 136, 30) range:NSMakeRange(4, attr.length-4)];
    _moneyLb.attributedText = attr;
    if ([model.orderStatus integerValue]>3||[model.orderStatus integerValue]<0) {
        _deleteButton.hidden = NO;
    }else{
        _deleteButton.hidden = YES;
    }

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 87, __kWidth-20, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    UIImageView *linesIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 131, __kWidth, 1)];
    [self addSubview:linesIV];
    linesIV.backgroundColor = __BackColor;
}

- (void)chooseDelete{
    [self.delegate makeOrdersRemove:[_model.orderId integerValue]];
}

@end
