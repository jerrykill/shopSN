//
//  YSFirstPromotionGoodCell.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSFirstPromotionGoodCell.h"
#import "YSPromotionGoodView.h"

@interface YSFirstPromotionGoodCell ()<UIScrollViewDelegate>
{
    CGFloat width;
    CGFloat height;
}

@property (strong,nonatomic) UIScrollView *scrollV;

@end

@implementation YSFirstPromotionGoodCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        height = frame.size.height;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.scrollV];
}


- (UIScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        _scrollV.contentSize =CGSizeMake(width, height);
        _scrollV.backgroundColor = __BackColor;
        _scrollV.scrollEnabled = YES;
        _scrollV.bounces = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}

- (void)setGoodArr:(NSMutableArray<YGoodsModel *> *)goodArr {
    _goodArr = goodArr;
    for (id obj in _scrollV.subviews) {
        [obj removeFromSuperview];
    }
    for (int i=0; i<_goodArr.count; i++) {
        YGoodsModel *model = _goodArr[i];
        YSPromotionGoodView *goodV = [[YSPromotionGoodView alloc]initWithFrame:CGRectMake(10+i*115, 0, 110, 185)];
        goodV.model = model;
        [_scrollV addSubview:goodV];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseGD:)];
        [goodV addGestureRecognizer:tap];
        goodV.userInteractionEnabled = YES;
    }
    _scrollV.contentSize = CGSizeMake(115*_goodArr.count+20, height);
}
-(void)chooseGD:(UITapGestureRecognizer *)tap{
    YSPromotionGoodView *boxV = (YSPromotionGoodView*)tap.view;
    [self.delegate choosePromotionGood:boxV.model];
}



@end
