//
//  YAddressCell.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddressCell.h"

@interface YAddressCell()

@property (strong,nonatomic) UIImageView *userIV;

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UIImageView *phoneIV;

@property (strong,nonatomic) UILabel *phoneLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.userIV];
    [self addSubview:self.nameLb];
    [self addSubview:self.phoneIV];
    [self addSubview:self.phoneLb];
    [self addSubview:self.detailLb];
    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UIImageView *)userIV{
    if (!_userIV) {
        _userIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 21, 15, 21)];
        _userIV.image = MImage(@"address_people");
    }
    return _userIV;
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_userIV)+7, 22, 80, 18)];
        _nameLb.textColor = LH_RGBCOLOR(40, 40, 40);
        _nameLb.font = MFont(17);
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.backgroundColor = [UIColor whiteColor];
    }
    return _nameLb;
}

-(UIImageView *)phoneIV{
    if (!_phoneIV) {
        _phoneIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-185, 22, 13, 18)];
        _phoneIV.image = MImage(@"address_phone");
    }
    return _phoneIV;
}

-(UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_phoneIV)+6, 22, 120, 15)];
        _phoneLb.textColor = LH_RGBCOLOR(40, 40, 40);
        _phoneLb.font = MFont(15);
        _phoneLb.textAlignment = NSTextAlignmentLeft;
        _phoneLb.backgroundColor = [UIColor whiteColor];
    }
    return _phoneLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_nameLb)+17, __kWidth-60, 40)];
        _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _detailLb.backgroundColor = [UIColor whiteColor];
        _detailLb.font = MFont(14);
        _detailLb.numberOfLines = 2;
        _detailLb.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 114, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(void)setModel:(YAddressModel *)model{
    _model = model;
    _nameLb.text = _model.name;
    _phoneLb.text = _model.phone;
    _detailLb.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.area,_model.Address];
}


@end
