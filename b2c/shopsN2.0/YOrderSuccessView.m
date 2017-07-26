//
//  YOrderSuccessView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderSuccessView.h"
#import "YOrderSuccessHeadView.h"

@interface YOrderSuccessView ()

@property (strong,nonatomic) YOrderSuccessHeadView *headV;

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UILabel *addressLb;

@property (strong,nonatomic) UILabel *moneyLb;

@property (strong,nonatomic) UIButton *lookBtn;

@end

@implementation YOrderSuccessView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    _headV = [[YOrderSuccessHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 200)];
    [self addSubview:_headV];
    _headV.title = @"订单成功";
    _headV.detail = @"我们将尽快为您安排发货!";

    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectYH(_headV)+20, __kWidth-10, 125)];
    [self addSubview:mainV];
    mainV.backgroundColor = [UIColor whiteColor];
    mainV.layer.cornerRadius = 5;

    _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, __kWidth-60, 18)];
    [mainV addSubview:_nameLb];
    _nameLb.textAlignment = NSTextAlignmentLeft;
    _nameLb.textColor = __DTextColor;
    _nameLb.font = MFont(16);

    UILabel *addNoLb = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectYH(_nameLb)+10, 70, 15)];
    [mainV addSubview:addNoLb];
    addNoLb.textAlignment = NSTextAlignmentLeft;
    addNoLb.textColor = __DTextColor;
    addNoLb.font = MFont(14);
    addNoLb.text = @"收货地址：";

    _addressLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(addNoLb), CGRectYH(_nameLb)+10, __kWidth-110, 35)];
    [mainV addSubview:_addressLb];
    _addressLb.textAlignment = NSTextAlignmentLeft;
    _addressLb.textColor =  __DTextColor;
    _addressLb.font = MFont(14);
    _addressLb.numberOfLines = 2;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectYH(_addressLb)+5, __kWidth-40, 1)];
    [mainV addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    _moneyLb = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectYH(lineIV)+15, __kWidth-60, 16)];
    [mainV addSubview:_moneyLb];
    _moneyLb.textAlignment = NSTextAlignmentLeft;


    _lookBtn =[[UIButton alloc]initWithFrame:CGRectMake(47, CGRectYH(mainV)+25, __kWidth-94, 42)];
    [self addSubview:_lookBtn];
    _lookBtn.layer.cornerRadius = 5;
    _lookBtn.backgroundColor = __DefaultColor;
    _lookBtn.titleLabel.font = MFont(18);
    [_lookBtn setTitle:@"查看订单" forState:BtnNormal];
    [_lookBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_lookBtn addTarget:self action:@selector(look) forControlEvents:BtnTouchUpInside];
}

-(void)look{
    [self.delegate makelookOrder];
}

-(void)setName:(NSString *)name{
    _nameLb.text = [NSString stringWithFormat:@"收件人：%@",name];
}

-(void)setAddress:(NSString *)address{
    _addressLb.text = address;
}

-(void)setMoney:(NSString *)money{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"实付款：¥%@",money]];
    [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(0, 4)];
    [attr addAttribute:NSFontAttributeName value:MFont(14) range:NSMakeRange(4, attr.length-4)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(0, 4)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(4, attr.length-4)];
    _moneyLb.attributedText = attr;
}

@end
