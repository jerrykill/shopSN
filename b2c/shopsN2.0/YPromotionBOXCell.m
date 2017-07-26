//
//  YPromotionBOXCell.m
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPromotionBOXCell.h"
#import "YPromotionBOXScrollView.h"

@interface YPromotionBOXCell()<YPromotionBOXScrollViewDelegate>

@property (strong,nonatomic) YPromotionBOXScrollView *scrollV;

@end

@implementation YPromotionBOXCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _scrollV = [[YPromotionBOXScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_scrollV];
        _scrollV.delegate = self;
    }
    return self;
}

-(void)setGoodArr:(NSMutableArray<YGoodsModel *> *)goodArr{
    _scrollV.goodArr = goodArr;
}


-(void)chooseGood:(YGoodsModel *)model{
    [self.delegate chooseBoxGood:model];
}

@end
