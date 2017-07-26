//
//  YOrdersDetailAddressCell.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailAddressCell.h"

@interface YOrdersDetailAddressCell()

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UILabel *phoneLb;

@property (strong,nonatomic) UILabel *addressLb;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YOrdersDetailAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *userIV = [[UIImageView alloc]initWithFrame:CGRectMake(9, 13, 15, 22)];
    [self addSubview:userIV];
    userIV.image = MImage(@"address_people");

    [self addSubview:self.nameLb];
    [self addSubview:self.phoneLb];
    [self addSubview:self.addressLb];

    UIImageView *jianIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-20, 43, 9, 16)];
    [self addSubview:jianIV];
    jianIV.image = MImage(@"arrow");
    jianIV.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(35+7, 12, 70, 20)];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.textColor =  __TextColor;
        _nameLb.font = MFont(16);
    }
    return _nameLb;
}

-(UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_nameLb)+5, 16, 120, 15)];
        _phoneLb.textAlignment = NSTextAlignmentLeft;
        _phoneLb.textColor = __TextColor;
        _phoneLb.font = MFont(13);
    }
    return _phoneLb;
}

-(UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc]initWithFrame:CGRectMake(9, CGRectYH(_nameLb)+10, __kWidth-60, 15)];
        _addressLb.textAlignment = NSTextAlignmentLeft;
        _addressLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _addressLb.font = MFont(13);
    }
    return _addressLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectYH(_addressLb)+10, __kWidth, 3)];
        _lineIV.image = MImage(@"address_line");
    }
    return _lineIV;
}


-(void)setModel:(YAddressModel *)model{
    _model = model;
    _nameLb.text = _model.name;
    _phoneLb.text = _model.phone;
    _addressLb.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.area,_model.Address];
}

@end
