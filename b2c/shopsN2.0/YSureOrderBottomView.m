//
//  YSureOrderBottomView.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderBottomView.h"

@interface YSureOrderBottomView ()

@property (strong,nonatomic) UILabel *totalLb;

@property (strong,nonatomic) UIButton *putBtn;

@end

@implementation YSureOrderBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    _totalLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, __kWidth-160, 20)];
    [self addSubview:_totalLb];
    _totalLb.textAlignment = NSTextAlignmentRight;

    _putBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-125, 0, 125, 50)];
    [self addSubview:_putBtn];
    _putBtn.backgroundColor = __DefaultColor;
    _putBtn.titleLabel.font = MFont(18);
    [_putBtn setTitle:@"提交订单" forState:BtnNormal];
    [_putBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_putBtn addTarget:self action:@selector(put) forControlEvents:BtnTouchUpInside];
}

-(void)put{
    [self.delegate putOrder];
}

-(void)setTotal:(NSString *)total{
    if ([total containsString:@"积分"]) {
        NSInteger loc =[total rangeOfString:@"+"].location;
        NSString *money = [total substringWithRange:NSMakeRange(0, loc)];
        NSString *integral = [total substringWithRange:NSMakeRange(loc+1, total.length-loc-1-2)];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总计：¥%@",total]];
        [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 4)];
        [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(4, money.length-3)];
        [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange (money.length+1, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(117, 117, 117) range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(255, 114, 0) range:NSMakeRange(3, money.length+1)];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(117, 117, 117),NSFontAttributeName:MFont(15)} range:NSMakeRange(money.length+4, 1)];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(255, 114, 0),NSFontAttributeName:MFont(18)} range:NSMakeRange(money.length+5, integral.length)];
        [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(117, 117, 117),NSFontAttributeName:MFont(15)} range:NSMakeRange(attr.length-2, 2)];
        _totalLb.attributedText = attr;
    }else{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总计：¥%@",total]];
    [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 4)];
    [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(4, total.length-3)];
    [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(attr.length-3, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(117, 117, 117) range:NSMakeRange(0, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(255, 114, 0) range:NSMakeRange(3, attr.length-3)];
        _totalLb.attributedText = attr;

    }
}


@end
