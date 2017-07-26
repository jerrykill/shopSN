//
//  YOrderTypeButton.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderTypeButton.h"

@implementation YOrderTypeButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;

        _colorIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, height-1, width, 1)];
        [self addSubview:_colorIV];
        _colorIV.userInteractionEnabled = NO;
        _colorIV.backgroundColor = [UIColor whiteColor];

        self.titleLabel.font = MFont(15);
        [self setTitleColor:__DefaultColor forState:BtnStateSelected];
        [self setTitleColor:LH_RGBCOLOR(120, 120, 120) forState:BtnNormal];

    }
    return self;
}

@end
