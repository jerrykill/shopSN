//
//  YBuyingLeadsCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingLeadsCell.h"

@interface YBuyingLeadsCell ()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *timeLb;

@property (strong,nonatomic) UILabel *typeLb;

@end

@implementation YBuyingLeadsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 5)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;

    [self addSubview:self.logoIV];
    [_logoIV addSubview:self.typeLb];

    [self addSubview:self.titleLb];

    [self addSubview:self.timeLb];
}

#pragma mark ==懒加载==
-(UIImageView *)logoIV{
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 35, 39)];
    }
    return _logoIV;
}

-(UILabel *)typeLb{
    if (!_typeLb) {
        _typeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, 35, 10)];
        _typeLb.textAlignment = NSTextAlignmentCenter;
        _typeLb.font = MFont(10);
        _typeLb.textColor = [UIColor whiteColor];
    }
    return _typeLb;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+15, 16, __kWidth-100, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(14);
    }
    return _titleLb;
}

-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(56, CGRectYH(_titleLb)+7, __kWidth-100, 15)];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _timeLb.font = MFont(11);
    }
    return _timeLb;
}

-(void)setTime:(NSString *)time{
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:times]];
    _timeLb.text = [NSString stringWithFormat:@"创建时间：%@",str];
}

-(void)setTitle:(NSString *)title{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"标题：%@",title]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(3, attr.length-3)];
    _titleLb.attributedText = attr;

}

-(void)setImageName:(NSString *)imageName{
    _logoIV.image = MImage(imageName);
}


-(void)setType:(NSString *)type{
    _typeLb.text = type;
}

@end
