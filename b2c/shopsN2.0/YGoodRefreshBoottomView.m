//
//  YGoodRefreshBoottomView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodRefreshBoottomView.h"
#import "YGoodDetailChooseTypeView.h"

@interface YGoodRefreshBoottomView()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) YGoodDetailChooseTypeView *typeV;

@end

@implementation YGoodRefreshBoottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =__BackColor;
        [self initView];
    }
    return self;
}


-(void)initView{
    [self addSubview:self.logoIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.typeV];
}

#pragma mark ==懒加载==
-(UIImageView *)logoIV{
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-180)/2, 17, 11, 11)];
        _logoIV.image = MImage(@"load");
    }
    return _logoIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+9, 14, 160, 15)];
        _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _titleLb.font = MFont(13);
        _titleLb.textAlignment =NSTextAlignmentLeft;
        _titleLb.text = @"继续滑动查看更多商品信息";
    }
    return _titleLb;
}

-(YGoodDetailChooseTypeView *)typeV{
    if (!_typeV) {
        _typeV = [[YGoodDetailChooseTypeView alloc]initWithFrame:CGRectMake(0, 40, __kWidth, 38)];
        _typeV.userInteractionEnabled = NO;
    }
    return _typeV;
}

-(void)setChooseIndex:(NSInteger)chooseIndex{
    _typeV.selectIndex = chooseIndex;
}


@end
