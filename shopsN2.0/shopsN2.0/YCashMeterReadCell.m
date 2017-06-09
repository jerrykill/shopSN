
//
//  YCashMeterReadCell.m
//  shopsN
//
//  Created by imac on 2016/12/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCashMeterReadCell.h"

@interface YCashMeterReadCell ()

@property (strong,nonatomic) UILabel *dateLb;

@property (strong,nonatomic) UILabel *totalLb;

@property (strong,nonatomic) UILabel *colorLb;

@property (strong,nonatomic) UILabel *blackLb;

@property (strong,nonatomic)  UIImageView *lineIV;

@end


@implementation YCashMeterReadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.dateLb];
    [self addSubview:self.totalLb];
    [self addSubview:self.colorLb];
    [self addSubview:self.blackLb];
    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, (__kWidth-20)*2/7, 15)];
        _dateLb.textAlignment = NSTextAlignmentCenter;
        _dateLb.font = MFont(13);
        _dateLb.textColor = __DTextColor;
    }
    return _dateLb;
}
-(UILabel *)totalLb{
    if (!_totalLb) {
        _totalLb = [[UILabel alloc]initWithFrame:CGRectMake(10+(__kWidth-20)*2/7, 20, (__kWidth-20)*2/7, 15)];
        _totalLb.textAlignment = NSTextAlignmentCenter;
        _totalLb.textColor = __DTextColor;
        _totalLb.font = MFont(13);
    }
    return _totalLb;
}

-(UILabel *)colorLb{
    if (!_colorLb) {
        _colorLb = [[UILabel alloc]initWithFrame:CGRectMake(10+(__kWidth-20)*4/7, 20, (__kWidth-20)*3/14, 15)];
        _colorLb.textAlignment = NSTextAlignmentCenter;
        _colorLb.textColor = __DTextColor;
        _colorLb.font = MFont(13);
    }
    return _colorLb;
}

-(UILabel *)blackLb{
    if (!_blackLb) {
        _blackLb = [[UILabel alloc]initWithFrame:CGRectMake(10+(__kWidth-20)*11/14, 20, (__kWidth-20)*3/14, 15)];
        _blackLb.textAlignment = NSTextAlignmentCenter;
        _blackLb.textColor = __DTextColor;
        _blackLb.font = MFont(13);
    }
    return _blackLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 55, __kWidth-20, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(void)setDate:(NSString *)date{
    _dateLb.text = date;
}

-(void)setTotal:(NSString *)total{
    _totalLb.text = total;
}

-(void)setColor:(NSString *)color{
    _colorLb.text = color;
}

-(void)setBlack:(NSString *)black{
    _blackLb.text = black;
}

@end
