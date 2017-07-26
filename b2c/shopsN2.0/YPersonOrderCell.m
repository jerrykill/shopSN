//
//  YPersonOrderCell.m
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonOrderCell.h"

@interface YPersonOrderCell()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YPersonOrderCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor =  __BackColor;

    _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth/5-20)/2, 15, 20, 20)];
    [self addSubview:_logoIV];

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_logoIV)+10, __kWidth/5, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = MFont(12);
    _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
    
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setImageName:(NSString *)imageName{
    _logoIV.image = MImage(imageName);
}

@end
