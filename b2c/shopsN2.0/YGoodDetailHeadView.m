//
//  YGoodDetailHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailHeadView.h"
#import "YGoodDetailPictureHeadView.h"
#import "YGoodDetailTitleView.h"

@interface YGoodDetailHeadView ()<YGoodDetailTitleViewDelegate>

@property (strong,nonatomic) YGoodDetailPictureHeadView *headV;

@property (strong,nonatomic) YGoodDetailTitleView *titleV;

@end

@implementation YGoodDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headV];
    [self addSubview:self.titleV];
}
#pragma mark ==懒加载==
-(YGoodDetailPictureHeadView *)headV{
    if (!_headV) {
    _headV = [[YGoodDetailPictureHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kWidth)];
    }
    return _headV;
}

-(YGoodDetailTitleView *)titleV{
    if (!_titleV) {
        _titleV = [[YGoodDetailTitleView alloc]init];
        _titleV.delegate = self;
    }
    return _titleV;
}


-(void)setModel:(YGoodDetailModel *)model{
    _model = model;
    _headV.imageArr = _model.imageArr;
    if (_model.list.count) {
        _titleV.frame = CGRectMake(0, CGRectYH(_headV), __kWidth, 125+30*_model.list.count);
        _titleV.model = _model;
    }else{
        _titleV.frame = CGRectMake(0, CGRectYH(_headV), __kWidth, 110);
        _titleV.model = _model;
    }
}

#pragma mark ==YGoodDetailTitleViewDelegate==
-(void)goodShare{
    [self.delegate ShareGood];
}


@end
