//
//  YShopCartClearView.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YShopCartClearView.h"

@interface YShopCartClearView()
////是否参加活动
//@property (strong,nonatomic) UIButton *eventBtn;
//支付价格
@property (strong,nonatomic) UILabel *tureLb;
//总价格
@property (strong,nonatomic) UILabel *totalLb;
//结算
@property (strong,nonatomic) UIButton *clearBtn;

@end

@implementation YShopCartClearView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth*500/750, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

//    _eventBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 100, 22)];
//    [self addSubview:_eventBtn];
//    _eventBtn.titleLabel.font = MFont(12);
//    [_eventBtn setTitle:@"是否参加活动" forState:BtnNormal];
//    [_eventBtn setTitleColor:LH_RGBCOLOR(170, 170, 170) forState:BtnNormal];
//    [_eventBtn setImage:MImage(@"activity_off") forState:BtnNormal];
//    [_eventBtn setImage:MImage(@"activity_on") forState:BtnStateSelected];
//    _eventBtn.backgroundColor = [UIColor clearColor];
//    _eventBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
//    _eventBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 80);
//    [_eventBtn addTarget:self action:@selector(attend:) forControlEvents:BtnTouchUpInside];

    _tureLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, __kWidth*2/3-10, 19)];
    [self addSubview:_tureLb];
    _tureLb.backgroundColor = [UIColor clearColor];
    _tureLb.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"总计：¥0.00"];
    [attri addAttribute:NSForegroundColorAttributeName value:__TextColor range:NSMakeRange(0, 3)];
    [attri addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(254, 90, 0) range:NSMakeRange(3, 5)];
    [attri addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 4)];
    [attri addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(4, 1)];
    [attri addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(5, 3)];
    _tureLb.attributedText = attri;

    _totalLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_tureLb), __kWidth*2/3-10, 15)];
    [self addSubview:_totalLb];
    _totalLb.backgroundColor = [UIColor clearColor];
    _totalLb.textColor = LH_RGBCOLOR(170, 170, 170);
    _totalLb.font = MFont(10);
    _totalLb.textAlignment = NSTextAlignmentRight;
    _totalLb.text = @"总额:¥0.00 优惠:¥0.00";

    _clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth*500/750, 0, __kWidth*250/750, self.frame.size.height)];
    [self addSubview:_clearBtn];
    _clearBtn.backgroundColor = __DefaultColor;
    _clearBtn.titleLabel.font = MFont(20);
    [_clearBtn setTitle:@"去结算" forState:BtnNormal];
    [_clearBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_clearBtn addTarget:self action:@selector(choose) forControlEvents:BtnTouchUpInside];
}

-(void)choose{
    if (_model.chooseCount.length<1) {
        [SXLoadingView showAlertHUD:@"请选择结算商品" duration:SXLoadingTime];
        return;
    }
    [self.delegate clear];
}

//-(void)attend:(UIButton*)sender{
//    sender.selected = !sender.selected;
//    [self.delegate chooseAttend:sender.selected];
//}

-(void)setModel:(YShopCartTotalModel *)model{
    _model = model;
    NSString *price = [NSString stringWithFormat:@"%.2f",[_model.totalMoney floatValue]-[_model.CouponMoney floatValue]];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总计：¥%@",price]];
    [attri addAttribute:NSForegroundColorAttributeName value:__TextColor range:NSMakeRange(0, 3)];
    [attri addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(254, 90, 0) range:NSMakeRange(3, price.length+1)];
    [attri addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 4)];
    [attri addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(4, attri.length-7)];
    [attri addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(attri.length-3, 3)];
    _tureLb.attributedText = attri;
    _totalLb.text = [NSString stringWithFormat:@"总额:¥%@ 优惠:¥%@",_model.totalMoney,_model.CouponMoney];
    if ([_model.chooseCount isEqualToString:@"0"]) {
         [_clearBtn setTitle:@"去结算" forState:BtnNormal];
    }else{
        [_clearBtn setTitle:[NSString stringWithFormat:@"去结算(%@)",_model.chooseCount] forState:BtnNormal];
    }

}


@end
