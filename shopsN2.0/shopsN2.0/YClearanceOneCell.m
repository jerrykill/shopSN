//
//  YClearanceOneCell.m
//  shopsN
//
//  Created by imac on 2016/12/9.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClearanceOneCell.h"

@interface YClearanceOneCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) GradientLablel *detailLb;



@property (strong,nonatomic) UIImageView *goodIV;

@end

@implementation YClearanceOneCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(9, 15, __kWidth*150/750, 16)];
    [self addSubview:_titleLb];
    _titleLb.font = BFont(16);
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;

    _detailLb = [[GradientLablel alloc]initWithFrame:CGRectMake(9, CGRectYH(_titleLb)+3, __kWidth*150/750, 13)];
    [self addSubview:_detailLb];
    _detailLb.font = MFont(12);
    _detailLb.textAlignment = NSTextAlignmentLeft;

    _logoBtn = [[UIButton alloc]initWithFrame:CGRectMake(9,CGRectYH(_detailLb)+5, 48, 17)];
    [self addSubview:_logoBtn];
    [_logoBtn setBackgroundImage:MImage(@"buyNow") forState:BtnNormal];
    _logoBtn.titleLabel.font = MFont(12);
    [_logoBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_logoBtn setTitle:@"马上购买" forState:BtnNormal];

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+10, 10, (__kWidth-1)/2-30-__kWidth*150/750, 89)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)setModel:(YGoodsModel *)model{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]]];
    _titleLb.text = model.goodTitle;
    _detailLb.text = model.goodDesc;
}




@end
