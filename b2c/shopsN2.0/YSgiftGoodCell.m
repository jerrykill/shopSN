//
//  YSgiftGoodCell.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSgiftGoodCell.h"

@interface YSgiftGoodCell ()
{
    CGFloat width;
    CGFloat height;
}

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *nameLbl;

@end

@implementation YSgiftGoodCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        height = frame.size.height;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.goodIV];
    [self addSubview:self.nameLbl];
}

- (UIImageView *)goodIV {
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake((width-55)/2, 15, 55, 55)];
        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodIV;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake((width-90)/2, CGRectYH(_goodIV)+8, 90, 20)];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
        _nameLbl.font = MFont(14);
        _nameLbl.textColor = __TextColor;

    }
    return _nameLbl;
}

- (void)setModel:(YGoodsModel *)model {
    _model = model;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _nameLbl.text = _model.goodTitle;

}

@end
