//
//  YProgressDetailCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YProgressDetailCell.h"

@interface YProgressDetailCell ()

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UIImageView *backV;

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *dateLb;

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UILabel *detailLb;
@end

@implementation YProgressDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.backV];
    [self addSubview:self.lineIV];
    [self addSubview:self.logoIV];
    [_backV addSubview:self.dateLb];
    [_backV addSubview:self.detailLb];
    [_backV addSubview:self.nameLb];
}

#pragma mark ==懒加载==
-(UIImageView *)backV{
    if (!_backV) {
        _backV = [[UIImageView alloc]initWithFrame:CGRectMake(34, 10, __kWidth-45, 74)];
        UIImage *image = MImage(@"wuliu");
        CGFloat scale = [UIScreen mainScreen].scale;
        UIImage *dot = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20/scale, 15/scale, 10/scale, 15/scale) resizingMode:UIImageResizingModeStretch];
        _backV.image = dot;
    }
    return _backV;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(18, 0, 1, 85)];
        _lineIV.backgroundColor = LH_RGBCOLOR(228, 228, 228);
    }
    return _lineIV;
}

-(UIImageView *)logoIV{
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 22, 18, 18)];
        _logoIV.backgroundColor = [UIColor whiteColor];
        _logoIV.layer.cornerRadius = 9;
        _logoIV.layer.borderColor = LH_RGBCOLOR(224, 40, 40).CGColor;
        _logoIV.layer.borderWidth = 3;
    }
    return _logoIV;
}

-(UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(14, 14, 180, 15)];
        _dateLb.textAlignment =NSTextAlignmentLeft;
        _dateLb.textColor = LH_RGBCOLOR(224, 40, 40);
        _dateLb.font = MFont(13);
    }
    return _dateLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(14, CGRectYH(_dateLb)+7, __kWidth-70, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(224, 40, 40);
        _detailLb.font = MFont(15);
    }
    return _detailLb;
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(14, CGRectYH(_detailLb)+5, __kWidth-70, 15)];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.textColor = LH_RGBCOLOR(224, 40, 40);
        _nameLb.font = MFont(14);
    }
    return _nameLb;
}

-(void)setModel:(YReturnsSpeedInfoModel *)model{
    _model = model;
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[_model.auditTime integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    _dateLb.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:times]];;
    _detailLb.text =_model.auditMessage;
    _nameLb.text = [NSString stringWithFormat:@"经办：%@",_model.auditor];
}

@end
