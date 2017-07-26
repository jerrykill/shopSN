//
//  YSFirstSectionheadView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSFirstSectionheadView.h"

@interface YSFirstSectionheadView ()

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UILabel *titleLbl;

@property (strong,nonatomic) UIButton *moreBtn;

@end

@implementation YSFirstSectionheadView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.lineIV];
    [self addSubview:self.titleLbl];
    [self addSubview:self.moreBtn];
}

- (UIImageView *)lineIV {
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 3, 15)];
        _lineIV.backgroundColor = LH_RGBCOLOR(239, 34, 0);
    }
    return _lineIV;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_lineIV)+4, 13, 100, 20)];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = __DTextColor;
        _titleLbl.font = MFont(15);
    }
    return _titleLbl;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-60, 7.5, 60, 30)];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"更多 >"];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(111, 111, 111) range:NSMakeRange(0, 2)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(200, 200, 200) range:NSMakeRange(2, attr.length-2)];
        [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 2)];
        [attr addAttribute:NSFontAttributeName value:MFont(10) range:NSMakeRange(2, attr.length-2)];
        [_moreBtn setAttributedTitle:attr forState:BtnNormal];
        [_moreBtn addTarget:self action:@selector(chooseMore) forControlEvents:BtnTouchUpInside];
    }
    return _moreBtn;
}


- (void)chooseMore {
    [self.delegate lookClassSection:self.tag];
}

- (void)setClassName:(NSString *)className {
    _titleLbl.text = className;
}

@end
