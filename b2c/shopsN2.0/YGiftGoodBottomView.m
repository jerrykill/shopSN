//
//  YGiftGoodBottomView.m
//  shopsN
//
//  Created by imac on 2017/1/9.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftGoodBottomView.h"

@interface YGiftGoodBottomView ()

@property (strong,nonatomic) UILabel *integralLb;

@property (strong,nonatomic) UIButton *exchangeBtn;

@end

@implementation YGiftGoodBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.integralLb];

    [self addSubview:self.exchangeBtn];

}

#pragma mark ==懒加载==
-(UILabel *)integralLb{
    if (!_integralLb) {
        _integralLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, __kWidth-170, 15)];
        _integralLb.textAlignment = NSTextAlignmentLeft;
    }
    return _integralLb;
}

-(UIButton *)exchangeBtn{
    if (!_exchangeBtn) {
        _exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-150, 0, 150, 50)];
        _exchangeBtn.backgroundColor = LH_RGBCOLOR(255, 114, 0);
        _exchangeBtn.titleLabel.font = MFont(16);
        _exchangeBtn.userInteractionEnabled = YES;
        [_exchangeBtn setTitle:@"我要兑换" forState:BtnNormal];
        [_exchangeBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_exchangeBtn addTarget:self action:@selector(exchange) forControlEvents:BtnTouchUpInside];
    }
    return _exchangeBtn;
}

-(void)exchange{
    [self.delegate makeExchange];
}

-(void)setModel:(YGiftGoodModel *)model{
    _model = model;
    if (IsNilString(_model.exchangeMoney)) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"单价：%@ 积分",_model.integral]];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(153, 153, 153),NSFontAttributeName:MFont(10)} range:NSMakeRange(0, 3)];
        [attr addAttributes:@{NSForegroundColorAttributeName:__DefaultColor,NSFontAttributeName:MFont(12)} range:NSMakeRange(3, attr.length-5)];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(153, 153, 153),NSFontAttributeName:MFont(10)} range:NSMakeRange(attr.length-2, 2)];
        _integralLb.attributedText = attr;
    }else{
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"单价：%@ 积分 + %@ 元",_model.integral,_model.exchangeMoney]];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(153, 153, 153),NSFontAttributeName:MFont(10)} range:NSMakeRange(0, 3)];
        [attr addAttributes:@{NSForegroundColorAttributeName:__DefaultColor,NSFontAttributeName:MFont(12)} range:NSMakeRange(3, _model.integral.length)];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(153, 153, 153),NSFontAttributeName:MFont(10)} range:NSMakeRange(_model.integral.length+3, 6)];
         [attr addAttributes:@{NSForegroundColorAttributeName:__DefaultColor,NSFontAttributeName:MFont(12)} range:NSMakeRange(_model.integral.length+9, _model.exchangeMoney.length)];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(153, 153, 153),NSFontAttributeName:MFont(10)} range:NSMakeRange( attr.length-1, 1)];
        _integralLb.attributedText = attr;
    }
}

@end
