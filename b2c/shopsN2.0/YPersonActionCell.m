//
//  YPersonActionCell.m
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonActionCell.h"

@interface YPersonActionCell()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YPersonActionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(((__kWidth-3)/4-30)/2, 20, 30, 30)];
    [self addSubview:_logoIV];
    _logoIV.contentMode= UIViewContentModeScaleAspectFit;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_logoIV)+10, (__kWidth-3)/4, 15)];
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
