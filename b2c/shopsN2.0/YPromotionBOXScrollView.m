//
//  YPromotionBOXScrollView.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionBOXScrollView.h"
#import "YPromotionBOXGoodView.h"

@interface YPromotionBOXScrollView ()<UIScrollViewDelegate>
{
    CGRect _frame;
}
@property (strong,nonatomic) UIScrollView *scrollV;

@end

@implementation YPromotionBOXScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _frame = frame;
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        [self addSubview:_scrollV];
        _scrollV.contentSize = frame.size;
        _scrollV.scrollEnabled = YES;
        _scrollV.bounces = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)setGoodArr:(NSMutableArray<YGoodsModel *> *)goodArr{
    _goodArr = goodArr;
    YPromotionBOXGoodView *goodV ;
    for (int i=0; i<_goodArr.count; i++) {
        YGoodsModel *model = _goodArr[i];
        goodV = [[YPromotionBOXGoodView alloc]initWithFrame:CGRectMake(i*((__kWidth-40)/3.5+10), 0, 10+(__kWidth-40)/3.5, 160)];
        [_scrollV addSubview:goodV];
        goodV.model = model;
        goodV.tag = i+333;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseGD:)];
        [goodV addGestureRecognizer:tap];
        goodV.userInteractionEnabled = YES;
    }
    _scrollV.contentSize = CGSizeMake(((__kWidth-40)/3.5+10)*_goodArr.count+10, 0);
}

-(void)chooseGD:(UITapGestureRecognizer *)tap{
    YPromotionBOXGoodView *boxV = (YPromotionBOXGoodView*)tap.view;
    [self.delegate chooseGood:_goodArr[boxV.tag-333]];
}



@end
