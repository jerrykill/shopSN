//
//  YBuyingLeadsHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingLeadsHeadView.h"

@interface YBuyingLeadsHeadView ()

@property (strong,nonatomic) UIImageView *bottomIV;

@property (strong,nonatomic)  UIImageView *lineIV;

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *listIV;

@end

@implementation YBuyingLeadsHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.bottomIV];
    [self addSubview:self.lineIV];
    [self addSubview:self.logoIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.listIV];
}

#pragma mark ==懒加载==
-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 5)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 2, 40)];
        _lineIV.backgroundColor = __DefaultColor;
    }
    return _lineIV;
}

-(UIImageView *)logoIV{
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 17, 17)];
    }
    return _logoIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+10, 16, __kWidth-50, 16)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DefaultColor;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UIImageView *)listIV{
    if (!_listIV) {
        _listIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth, 1)];
        _listIV.backgroundColor = __BackColor;
    }
    return _listIV;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setImageName:(NSString *)imageName{
    _logoIV.image = MImage(imageName);
}

@end
