//
//  YSureOrderAddressCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderAddressCell.h"

@interface YSureOrderAddressCell()

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UILabel *phoneLb;

@property (strong,nonatomic) UILabel *addressLb;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YSureOrderAddressCell

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

    _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(userIV)+7, 12, 70, 20)];
    [self addSubview:_nameLb];
    _nameLb.textAlignment = NSTextAlignmentLeft;
    _nameLb.textColor =  __DTextColor;
    _nameLb.font = MFont(16);

    UIImageView *phoneIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-170, 16, 13, 17)];
    [self addSubview:phoneIV];
    phoneIV.image = MImage(@"address_phone");

    _phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(phoneIV)+5, 16, 120, 15)];
    [self addSubview:_phoneLb];
    _phoneLb.textAlignment = NSTextAlignmentLeft;
    _phoneLb.textColor = __DTextColor;
    _phoneLb.font = MFont(13);

    _addressLb = [[UILabel alloc]initWithFrame:CGRectMake(9, CGRectYH(_nameLb)+15, __kWidth-60, 15)];
    [self addSubview:_addressLb];
    _addressLb.textAlignment = NSTextAlignmentLeft;
    _addressLb.textColor = LH_RGBCOLOR(153, 153, 153);
    _addressLb.font = MFont(13);

    UIImageView *jianIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-20, 43, 9, 16)];
    [self addSubview:jianIV];
    jianIV.image = MImage(@"arrow");

    _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 82, __kWidth, 3)];
    [self addSubview:_lineIV];
    _lineIV.image = MImage(@"address_line");
}

-(void)setModel:(YAddressModel *)model{
    _model = model;
    _nameLb.text = _model.name;
    _phoneLb.text = _model.phone;
    _addressLb.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.area,_model.Address];
}

@end
