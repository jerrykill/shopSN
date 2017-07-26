//
//  YSBrandDetailHeadView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandDetailHeadView.h"

static inline CGFloat AutoWidth(CGFloat width){
    return width*__kWidth/375;
}
@interface YSBrandDetailHeadView ()
/**广告图*/
@property (strong,nonatomic) UIImageView *backIV;
/**logo*/
@property (strong,nonatomic) UIImageView *logoIV;
/**标题*/
@property (strong,nonatomic) UILabel *nameLbl;
/**介绍文本*/
@property (strong,nonatomic) UILabel *introduceLbl;

@end

@implementation YSBrandDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.backIV];
    [self sendSubviewToBack:_backIV];
    [self addSubview:self.logoIV];
    [self addSubview:self.nameLbl];
    [self addSubview:self.introduceLbl];
}

- (UIImageView *)backIV {
    if (!_backIV) {
        _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, AutoWidth(100))];
        _backIV.layer.masksToBounds = YES;
        _backIV.contentMode = UIViewContentModeScaleToFill;

    }
    return _backIV;
}

- (UIImageView *)logoIV {
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectYH(_backIV)-AutoWidth(15), AutoWidth(70), AutoWidth(70))];
        _logoIV.layer.cornerRadius = AutoWidth(35);
        _logoIV.layer.borderWidth = 2;
        _logoIV.layer.borderColor = [UIColor whiteColor].CGColor;
        _logoIV.layer.masksToBounds = YES;
        _logoIV.contentMode = UIViewContentModeScaleAspectFit;
        _logoIV.backgroundColor = [UIColor whiteColor];
    }
    return _logoIV;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+8, CGRectYH(_logoIV)-AutoWidth(35)-15, __kWidth-95, 20)];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
        _nameLbl.textColor = __DTextColor;
        _nameLbl.font = BFont(14);
    }
    return _nameLbl;
}

- (UILabel *)introduceLbl {
    if (!_introduceLbl) {
        _introduceLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectX(_nameLbl), CGRectYH(_nameLbl)+5, CGRectW(_nameLbl), 15)];
        _introduceLbl.textAlignment = NSTextAlignmentLeft;
        _introduceLbl.textColor = __LightTextColor;
        _introduceLbl.font = MFont(12);
    }
    return _introduceLbl;
}

- (void)setModel:(YSBrandModel *)model {
    _model = model;
    [_backIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.imageName]] placeholderImage:MImage(ADPlachorName)];
    [_logoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.logo]]
        placeholderImage:MImage(goodPlachorName)];
    _nameLbl.text = model.detailName;
    _introduceLbl.text = model.info;
}


@end
