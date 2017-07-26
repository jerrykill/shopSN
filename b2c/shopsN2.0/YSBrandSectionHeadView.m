//
//  YSBrandSectionHeadView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandSectionHeadView.h"

@interface YSBrandSectionHeadView ()

@property (strong,nonatomic) UILabel *titleLbl;

@end

@implementation YSBrandSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.titleLbl];
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, __kWidth-30, 25)];
        _titleLbl.font = MFont(12);
        _titleLbl.textColor = __DTextColor;
        _titleLbl.textAlignment = NSTextAlignmentLeft;

    }
    return _titleLbl;
}

- (void)setName:(UILabel *)name {
    _titleLbl.text = name;
}

@end
