//
//  YAddAddressCell.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddAddressCell.h"

@implementation YAddAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailTF];
    [self addSubview:self.chooseIV];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 17, 90, 16)];
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.backgroundColor = [UIColor whiteColor];
        _titleLb.font = MFont(15);
        _titleLb.textAlignment =NSTextAlignmentLeft;
    }
    return _titleLb;
}

-(UITextField *)detailTF{
    if (!_detailTF) {
        _detailTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+2, 16, __kWidth-120, 17)];
        _detailTF.textColor = LH_RGBCOLOR(40, 40, 40);
        _detailTF.backgroundColor = [UIColor whiteColor];
        _detailTF.font = MFont(16);
        _detailTF.textAlignment = NSTextAlignmentLeft;
    }
    return _detailTF;
}

-(UIImageView *)chooseIV{
    if (!_chooseIV) {
        _chooseIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-36, 11, 25, 25)];
        _chooseIV.layer.cornerRadius = 12.5;
        _chooseIV.hidden = YES;
    }
    return _chooseIV;
}

@end
