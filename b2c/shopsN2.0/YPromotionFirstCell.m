//
//  YPromotionFirstCell.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionFirstCell.h"
#import "YPromotionADView.h"
#import "YPromtionHotView.h"
#import "YPromotionWarnView.h"
#import "YPromotionGoodView.h"

@interface YPromotionFirstCell()

@property (strong,nonatomic)  YPromtionHotView *hotV;

@property (strong,nonatomic) YPromotionGoodView *goodV;

@property (strong,nonatomic) UIImageView *adV;

@end

@implementation YPromotionFirstCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
//    YPromotionADView *adV = [[YPromotionADView alloc]initWithFrame:CGRectMake(0, 0, 178*__kWidth/375+10, 250)];
//    [self addSubview:adV];
//    adV.backgroundColor = [UIColor whiteColor];
    _adV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 178*__kWidth/375, 230)];
    [self addSubview:_adV];
    _adV.contentMode = UIViewContentModeScaleToFill;
    _adV.clipsToBounds = YES;
    _adV.backgroundColor =LH_RandomColor;

    UIImageView *sanIV = [[UIImageView alloc]initWithFrame:CGRectMake((178*__kWidth/375-93)/2-2+10, 222, 23, 28)];
    [self addSubview:sanIV];
    sanIV.image = MImage(@"dz");

    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseProHot)];
    _hotV = [[YPromtionHotView alloc]initWithFrame:CGRectMake(CGRectXW(_adV)+10, 14, 197*__kWidth/375-30, 118)];
    [self addSubview:_hotV];
    [_hotV addGestureRecognizer:tap];

    YPromotionWarnView *warnV = [[YPromotionWarnView alloc]initWithFrame:CGRectMake(CGRectXW(_adV)+12, CGRectYH(_hotV)+16, 60, 90)];
    [self addSubview:warnV];


     UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseProGood)];
    _goodV = [[YPromotionGoodView alloc]initWithFrame:CGRectMake(__kWidth-85, CGRectYH(_hotV)+14, 63, 90)];
    [self addSubview:_goodV];
    [_goodV addGestureRecognizer:tap1];

}

-(void)chooseProHot{
    [self.delegate chooseHot:_hot];
}

-(void)chooseProGood{
    [self.delegate chooseGood:_good];
}

-(void)setHot:(YGoodsModel *)hot{
    _hot =hot;
    _hotV.model = hot;
}

-(void)setGood:(YGoodsModel *)good{
    _good = good;
    _goodV.model = good;
}
-(void)setImageName:(NSString *)imageName{
    [_adV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,imageName]] placeholderImage:MImage(goodPlachorName)];
}

@end
