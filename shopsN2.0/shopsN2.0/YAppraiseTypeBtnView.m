//
//  YAppraiseTypeBtnView.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YAppraiseTypeBtnView.h"

@interface YAppraiseTypeBtnView ()
{
    CGRect _frame;
}
@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UILabel *typeLb;

@property (strong,nonatomic) UIImageView *colorIV;

@end

@implementation YAppraiseTypeBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.countLb];
    [self addSubview:self.typeLb];
    [self addSubview:self.colorIV];



}

#pragma mark ==懒加载==
-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, _frame.size.width, 20)];
        _countLb.textAlignment = NSTextAlignmentCenter;
        _countLb.textColor = __DTextColor;
        _countLb.font = BFont(19);
        _countLb.text = @"0";
    }
    return _countLb;
}

-(UILabel *)typeLb{
    if (!_typeLb) {
        _typeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_countLb)+4, _frame.size.width, 15)];
        _typeLb.textAlignment= NSTextAlignmentCenter;
        _typeLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _typeLb.font = MFont(12);
    }
    return _typeLb;
}

-(UIImageView *)colorIV{
    if (!_colorIV) {
        _colorIV = [[UIImageView alloc]initWithFrame:CGRectMake(_frame.size.width/4, 59, _frame.size.width/2, 1)];
        _colorIV.backgroundColor = __DefaultColor;
    }
    return _colorIV;
}

-(void)setCount:(NSString *)count{
    _countLb.text = count;
}

-(void)setType:(NSString *)type{
    _typeLb.text = type;
}

-(void)setIsHidden:(BOOL)isHidden{
    if (isHidden) {
        _colorIV.hidden = YES;
    }else{
        _colorIV.hidden = NO;
    }
}

@end
