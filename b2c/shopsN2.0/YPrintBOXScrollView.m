//
//  YPrintBOXScrollView.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPrintBOXScrollView.h"
#import "YPrintBOXGoodView.h"
@interface YPrintBOXScrollView ()<UIScrollViewDelegate>
{
    CGRect _frame;
}
@property (strong,nonatomic) UIScrollView *scrollV;


@end

@implementation YPrintBOXScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
    YPrintBOXGoodView *goodV;
    for (int i=0; i<_goodArr.count; i++) {
        YGoodsModel *model = _goodArr[i];
        goodV = [[YPrintBOXGoodView alloc]initWithFrame:CGRectMake(i*((__kWidth-30)/2.5+10), 5, (__kWidth-30)/2.5+10, 170)];
        [_scrollV addSubview:goodV];
        goodV.model = model;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseGD:)];
        [goodV addGestureRecognizer:tap];
        goodV.userInteractionEnabled = YES;

    }
    _scrollV.contentSize = CGSizeMake(((__kWidth-30)/2.5+10)*_goodArr.count, 0);

}

-(void)chooseGD:(UITapGestureRecognizer *)tap{
    YPrintBOXGoodView *boxV = (YPrintBOXGoodView*)tap.view;
    [self.delegate chooseGood:boxV.model];
}



@end
