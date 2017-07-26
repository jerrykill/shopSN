//
//  YPromotionGoodView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionGoodView.h"

@interface YPromotionGoodView()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *shopBtn;

@end

@implementation YPromotionGoodView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self .backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 63, 90)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleAspectFill;
    _goodIV.clipsToBounds = YES;
    [self sendSubviewToBack:_goodIV];

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 63, 12)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = [UIColor whiteColor];
    _titleLb.font =MFont(10);

    _shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, CGRectYH(_titleLb)+4, 43, 12)];
    [self addSubview:_shopBtn];
    _shopBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _shopBtn.layer.borderWidth = 1;
    _shopBtn.titleLabel.font = MFont(6);
    [_shopBtn setTitle:@"SHOP NOW" forState:BtnNormal];
    [_shopBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    _shopBtn.userInteractionEnabled = NO;


}

-(void)setModel:(YGoodsModel *)model{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = model.goodTitle;
}

@end
