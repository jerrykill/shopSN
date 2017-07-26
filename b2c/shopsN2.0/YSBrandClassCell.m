//
//  YSBrandClassCell.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandClassCell.h"

@interface YSBrandClassCell ()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *nameLbl;

@end

@implementation YSBrandClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.logoIV];
    [self addSubview:self.nameLbl];
}

- (UIImageView *)logoIV {
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 35, 20)];
        _logoIV.backgroundColor = LH_RandomColor;
    }
    return _logoIV;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+15, 15, __kWidth-80, 20)];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
        _nameLbl.font = MFont(13);
        _nameLbl.textColor = __DTextColor;
        
    }
    return _nameLbl;
}

- (void)setModel:(YSBrandModel *)model {
    [_logoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.logo]]];
    _nameLbl.text = model.name;
}

@end
