//
//  YPersonIntegralHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonIntegralHeadView.h"

@interface YPersonIntegralHeadView ()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *changeLb;

@property (strong,nonatomic) UILabel *totalLb;

@property (strong,nonatomic) UILabel *warnLb;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YPersonIntegralHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =__BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headIV];
    [self sendSubviewToBack:_headIV];

    [self addSubview:self.changeLb];

    [self addSubview:self.totalLb];

    [self addSubview:self.warnLb];

    [self addSubview:self.titleLb];
}

#pragma mark ==懒加载==
-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 130)];
        _headIV.image = MImage(@"integral_bg");
    }
    return _headIV;
}

-(UILabel *)changeLb{
    if (!_changeLb) {
        _changeLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth/2+10, 30, 100, 15)];
        _changeLb.textAlignment = NSTextAlignmentLeft;
        _changeLb.backgroundColor = [UIColor clearColor];
        _changeLb.textColor = __TextColor;
        _changeLb.font = MFont(14);
    }
    return _changeLb;
}

-(UILabel *)totalLb{
    if (!_totalLb) {
        _totalLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_changeLb)+10, __kWidth, 25)];
        _totalLb.textAlignment = NSTextAlignmentCenter;
        _totalLb.backgroundColor = [UIColor clearColor];
        _totalLb.textColor = [UIColor whiteColor];
        _totalLb.font = BFont(25);
    }
    return _totalLb;
}

-(UILabel *)warnLb{
    if (!_warnLb) {
        _warnLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_totalLb)+5, __kWidth, 15)];
        _warnLb.backgroundColor = [UIColor clearColor];
        _warnLb.textAlignment = NSTextAlignmentCenter;
        _warnLb.textColor = HEXCOLOR(0xffffa0);
        _warnLb.font = MFont(12);
        _warnLb.text = @"可用积分";
    }
    return _warnLb;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_headIV)+12, __kWidth-20, 20)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(void)setTotal:(NSString *)total{
    _total = total;
    _totalLb.text = total;
}

-(void)setChange:(NSString *)change{
    _change = change;
    _changeLb.text = change;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"今日赚取积分：%@",_change]];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(0, 7)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(7, attr.length-7)];
    _titleLb.attributedText = attr;

}

@end
