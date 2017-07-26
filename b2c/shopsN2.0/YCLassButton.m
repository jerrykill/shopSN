//
//  YCLassButton.m
//  shopsN
//
//  Created by imac on 2017/4/28.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCLassButton.h"

@interface YCLassButton ()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YCLassButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        [self addSubview:self.lineIV];
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = MFont(13);
        [self setTitleColor:[UIColor blackColor] forState:BtnNormal];
        [self setTitleColor:__DefaultColor forState:BtnStateSelected];
        [self addSubview:self.bottomIV];
    }
    return self;
}

#pragma mark ==懒加载==
- (UIImageView *)lineIV {
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1, _frame.size.height)];
        _lineIV.backgroundColor = [UIColor whiteColor];
    }
    return _lineIV;
}

- (UIImageView *)bottomIV {
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, _frame.size.height-1, _frame.size.width, 1)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}


@end
