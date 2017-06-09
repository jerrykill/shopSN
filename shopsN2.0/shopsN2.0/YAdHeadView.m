//
//  YAdHeadView.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAdHeadView.h"
#import "YADScrollView.h"


@interface YAdHeadView()<YADScrollViewDelegate>
{
    CGRect _frame;
}

@property (strong,nonatomic) YADScrollView *adScrollV;

@end

@implementation YAdHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.adScrollV];
    }
    return self;
}

-(void)chooseAD:(NSString *)url{
    [self.delegate chooseAD:url];
}

-(void)setDataArr:(NSArray<YHeadImage *> *)dataArr{
    _dataArr = dataArr;
    _adScrollV.imgArr = dataArr;
}

#pragma mark ==懒加载==
-(YADScrollView *)adScrollV{
    if (!_adScrollV) {
        _adScrollV = [[YADScrollView alloc]initWithFrame:_frame];
        _adScrollV.delegate = self;
    }
    return _adScrollV;
}


@end
