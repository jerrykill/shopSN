//
//  YAppariseHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YAppariseHeadView.h"

@interface YAppariseHeadView ()

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YAppariseHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.lineIV];
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];


    
}
#pragma mark ==懒加载==
-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 47, 44)];
        _goodIV.backgroundColor = LH_RandomColor;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+15, 30, __kWidth-90, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(10);
    }
    return _titleLb;
}


-(void)setImageName:(NSString *)imageName{
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,imageName]]placeholderImage:MImage(goodPlachorName)];
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

@end
