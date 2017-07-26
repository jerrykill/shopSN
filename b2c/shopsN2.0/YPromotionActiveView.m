//
//  YPromotionActiveView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionActiveView.h"
#import "YPromotionClassView.h"
#import "YPromotionClassTwoView.h"

@interface YPromotionActiveView()<YPromotionClassViewDelegate>

@property (strong,nonatomic) YPromotionClassView *oneV;

@property (strong,nonatomic) YPromotionClassTwoView *twoV;

@property (strong,nonatomic) YPromotionClassTwoView *threeV;

@end

@implementation YPromotionActiveView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseClass:)];
    _oneV = [[YPromotionClassView alloc]initWithFrame:CGRectMake(0, 0, __kWidth/2, 380)];
    [self addSubview:_oneV];
    _oneV.tag = 1;
    _oneV.delegate =self;
    _oneV.userInteractionEnabled = YES;
    [_oneV addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTwoClass:)];
    _twoV = [[YPromotionClassTwoView alloc]initWithFrame:CGRectMake(CGRectXW(_oneV), 0, __kWidth/2, 180)];
    [self addSubview:_twoV];
    _twoV.imageName = @"Promotions_hot2";
    _twoV.tag = 2;
    [_twoV addGestureRecognizer:tap2];

    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseTwoClass:)];
    _threeV = [[YPromotionClassTwoView alloc]initWithFrame:CGRectMake(CGRectXW(_oneV), CGRectYH(_twoV), __kWidth/2, 180)];
    [self addSubview:_threeV];
    _threeV.imageName = @"Promotions_hot3";
    _threeV.tag =3;
    [_threeV addGestureRecognizer:tap3];

}

-(void)chooseClass:(UITapGestureRecognizer*)sender{
    YPromotionClassView *class = (YPromotionClassView*)sender.view;

    [self.delegate chooseCLass:_dataArr[class.tag-1]];
}

- (void)chooseTwoClass:(UITapGestureRecognizer*)tap{
    YPromotionClassTwoView *class = (YPromotionClassTwoView*)tap.view;
    [self.delegate chooseCLass:_dataArr[class.tag-1]];
}

-(void)chooseTagV:(NSString *)sender{
    [self.delegate chooseTagV:sender];
}

-(void)setDataArr:(NSArray<YPromotionClassModel *> *)dataArr{
    _dataArr = dataArr;
    _oneV.model = _dataArr[0];
    _twoV.model = _dataArr[1];
    _threeV.model = _dataArr[2];
}

@end
