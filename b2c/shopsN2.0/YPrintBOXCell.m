//
//  YPrintBOXCell.m
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPrintBOXCell.h"
#import "YPrintBOXScrollView.h"

@interface YPrintBOXCell()<YPrintBOXScrollViewDelegate>

@property (strong,nonatomic) YPrintBOXScrollView *scrollV;

@end

@implementation YPrintBOXCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _scrollV = [[YPrintBOXScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_scrollV];
        _scrollV.delegate = self;
    }
    return self;
}

-(void)setGoodArr:(NSMutableArray<YGoodsModel *> *)goodArr{
    _scrollV.goodArr = goodArr;
}

-(void)chooseGood:(YGoodsModel *)sender{
    [self.delegate chooseGood:sender];
}

@end
