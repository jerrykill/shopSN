//
//  YPromotionHotCell.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionHotCell.h"

@interface YPromotionHotCell()

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UIImageView *goodIV;



@end

@implementation YPromotionHotCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(9, 15, __kWidth*190/750, 16)];
    [self addSubview:_titleLb];
    _titleLb.font = BFont(15);
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(9, CGRectYH(_titleLb)+3, __kWidth*190/750, 13)];
    [self addSubview:_detailLb];
    _detailLb.font = MFont(10);
    _detailLb.textAlignment = NSTextAlignmentLeft;

    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-1)/2-10-150*__kWidth/750, 10, 150*__kWidth/750, 75)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleAspectFit;

    _moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+__kWidth/2-140, 15, 30, 30)];
    [self addSubview:_moneyBtn];
    _moneyBtn.titleLabel.font = MFont(11);
    _moneyBtn.layer.cornerRadius =15;
    _moneyBtn.backgroundColor = LH_RGBCOLOR(254, 86, 87);
    [_moneyBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    
}

-(void)setModel:(YGoodsModel *)model{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = model.goodTitle;
    _detailLb.text = model.goodDesc;
    NSInteger money =[model.goodMoney integerValue];
    [_moneyBtn setTitle:[NSString stringWithFormat:@"¥%ld",money] forState:BtnNormal];
}


@end
