//
//  YGoodLikeCell.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodLikeCell.h"

@interface YGoodLikeCell(){
    CGFloat _width;
    CGFloat _height;
}


@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *priceLb;

@end

@implementation YGoodLikeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        _height = frame.size.height;

        [self addSubview:self.goodIV];
        [self addSubview:self.titleLb];
        [self addSubview:self.priceLb];
    }
    return self;
}

-(void)setDataModel:(YGoodsModel *)dataModel{
    _dataModel = dataModel;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_dataModel.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _dataModel.goodTitle;
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_dataModel.goodMoney]];
    [price setAttributes:@{NSFontAttributeName:MFont(10)} range:NSMakeRange(0, 1)];
    [price setAttributes:@{NSFontAttributeName:MFont(15)} range:NSMakeRange(1, (price.length-3))];
    [price setAttributes:@{NSFontAttributeName:MFont(10)} range:NSMakeRange((price.length-2), 2)];
    _priceLb.attributedText = price;

}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, _width-30, _height-70)];
        _goodIV.contentMode = UIViewContentModeScaleToFill;
        _goodIV.layer.masksToBounds = YES;
        _goodIV.backgroundColor = LH_RandomColor;
    }
    return _goodIV;
}


-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectYH(_goodIV)+10, _width-30, 15)];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectYH(_titleLb)+10, _width-30, 15)];
        _priceLb.textColor = LH_RGBCOLOR(224, 40, 40);

    }
    return _priceLb;
}

@end
