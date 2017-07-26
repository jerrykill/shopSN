//
//  YPayTitleHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayTitleHeadView.h"

@interface YPayTitleHeadView ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *moneyLb;

@end

@implementation YPayTitleHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 90, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
    _titleLb.font = MFont(15);
    _titleLb.text = @"订单金额";

    _moneyLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth/2, 15, __kWidth/2-10, 17)];
    [self addSubview:_moneyLb];
    _moneyLb.textAlignment = NSTextAlignmentRight;
    _moneyLb.textColor = __DefaultColor;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setMoney:(NSString *)money{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",money]];
    [attr addAttribute:NSFontAttributeName value:MFont(17) range:NSMakeRange(0, attr.length-4)];
    [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(attr.length-4, 4)];
    _moneyLb.attributedText = attr;
}

@end
