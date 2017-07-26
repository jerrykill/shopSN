//
//  YShopNullView.m
//  shopsN
//
//  Created by imac on 2017/1/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YShopNullView.h"

@interface YShopNullView ()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIImageView *cartIV;

@end

@implementation YShopNullView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _frame = frame;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = _frame.size.width;
    CGFloat height = _frame.size.height;
    _cartIV = [[UIImageView alloc]initWithFrame:CGRectMake( (width-153)/2, 120, 153, 137)];
    [self addSubview:_cartIV];
    _cartIV.image = MImage(@"cart_air");

    UIButton *gouBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_cartIV)+30, width, 30)];
    [self addSubview:gouBtn];
    gouBtn.titleLabel.font = MFont(16);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"您的购物车还没有宝贝哦，去选购看看"];
    [attr addAttributes:@{NSForegroundColorAttributeName:LH_RGBCOLOR(78, 78, 78)} range:NSMakeRange(0, attr.length-5)];
    [attr addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:__DefaultColor} range:NSMakeRange(attr.length-5, 5)];
    [gouBtn setAttributedTitle:attr forState:BtnNormal];
    [gouBtn addTarget:self action:@selector(chooseBuy) forControlEvents:BtnTouchUpInside];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, height-50, width, 50)];
    [self addSubview:bottomV];
    bottomV.backgroundColor = [UIColor whiteColor];

    UILabel *freightLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 80, 15)];
    [bottomV addSubview:freightLb];
    freightLb.textAlignment = NSTextAlignmentLeft;
    freightLb.font = MFont(12);
    freightLb.textColor = LH_RGBCOLOR(176, 176, 176);
    freightLb.text = @"不含运费";

    UILabel *totalLb = [[UILabel alloc]initWithFrame:CGRectMake(width-250, 15, 115, 20)];
    [bottomV addSubview:totalLb];
    totalLb.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *attr1 = [[NSMutableAttributedString alloc]initWithString:@"总计：¥0.00"];
    [attr1 addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(117, 117, 117) range:NSMakeRange(0, 3)];
    [attr1 addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(255, 101, 101) range:NSMakeRange(3, attr1.length-3)];
    [attr1 addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 4)];
    [attr1 addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(4, 1)];
    [attr1 addAttribute:NSFontAttributeName value:MFont(12) range:NSMakeRange(5, 3)];
    totalLb.attributedText = attr1;

    UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-125, 0, 125, 50)];
    [bottomV addSubview:clearBtn];
    clearBtn.backgroundColor = __DefaultColor;
    clearBtn.titleLabel.font = MFont(18);
    [clearBtn setTitle:@"去结算（0）" forState:BtnNormal];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];

}


- (void)chooseBuy{
    [self.delegate goBuying];
}


@end
