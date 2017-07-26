//
//  YHotPromotionHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YHotPromotionHeadView.h"
#import "YADScrollView.h"

@interface YHotPromotionHeadView()<YADScrollViewDelegate>

@property (strong,nonatomic) UIButton *titleBtn;

@property (strong,nonatomic) YADScrollView *adScrollV;

@end

@implementation YHotPromotionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

- (void)initView{
    _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth-75)/2, 0, 75, 30)];
    [self addSubview:_titleBtn];
    _titleBtn.titleLabel.font = BFont(15);
    _titleBtn.userInteractionEnabled = NO;
    [_titleBtn setTitleColor:__DefaultColor forState:BtnNormal];
    _titleBtn.backgroundColor = [UIColor clearColor];
    for (int i=0; i<2; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-75)/2-10+85*i, 14, 10, 2)];
        [self addSubview:lineIV];
        lineIV.backgroundColor = HEXCOLOR(0xcecece);
    }

    _adScrollV = [[YADScrollView alloc]initWithFrame:CGRectMake(0, 30, __kWidth, 170*__kWidth/750)];
    [self addSubview:_adScrollV];
    _adScrollV.delegate = self;
}

-(void)chooseAD:(NSString *)url{
    [self.delegate choosebottomAD:url];
}

-(void)setImageArr:(NSMutableArray<YHeadImage *> *)imageArr{
    _imageArr = imageArr;
    _adScrollV.imgArr = _imageArr;
}

-(void)setTitle:(NSString *)title{
    [_titleBtn setTitle:title forState:BtnNormal];
}

@end
