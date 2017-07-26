//
//  YServiceAutoCell.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceAutoCell.h"

@interface YServiceAutoCell()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YServiceAutoCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.logoIV];
    [self addSubview:self.titleLb];
}

#pragma mark ==懒加载==
-(UIImageView *)logoIV{
    if (!_logoIV) {
        CGFloat width = (__kWidth-2)/3;
        _logoIV =[[UIImageView alloc]initWithFrame:CGRectMake((width-33)/2, 33, 33, 33)];
        _logoIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        CGFloat width = (__kWidth-2)/3;
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_logoIV)+5, width, 15)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = __TextColor;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(void)setImageName:(NSString *)imageName{
    _logoIV.image = MImage(imageName);
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

@end
