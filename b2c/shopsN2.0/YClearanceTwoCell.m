//
//  YClearanceTwoCell.m
//  shopsN
//
//  Created by imac on 2016/12/9.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClearanceTwoCell.h"

@interface YClearanceTwoCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UIButton *discountBtn;

@end

@implementation YClearanceTwoCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, __kWidth/4-10, 16)];
    [self addSubview:_titleLb];
    _titleLb.textColor = __DTextColor;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = BFont(15);

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(9, CGRectYH(_titleLb)+3, __kWidth/4-10, 14)];
    [self addSubview:_detailLb];
    _detailLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.font = MFont(13);

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(12, CGRectYH(_detailLb)+2, __kWidth/4-24, 70)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor =LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleAspectFit;

    _discountBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectYH(_detailLb)+62, 30, 14)];
    [self addSubview:_discountBtn];
    [self bringSubviewToFront:_discountBtn];
    [_discountBtn setBackgroundImage:MImage(@"discount") forState:BtnNormal];
    _discountBtn.titleLabel.font = MFont(8);
    [_discountBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    _discountBtn.hidden = YES;

}

-(void)setModel:(YGoodsModel *)model{
    _titleLb.text =model.goodTitle;
    _detailLb.text = model.goodDesc;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    if (!(self.tag%2)) {
        _discountBtn.hidden = NO;
    }
}

-(void)setDisCount:(NSString *)disCount{
    [_discountBtn setTitle:disCount forState:BtnNormal];
}

@end
