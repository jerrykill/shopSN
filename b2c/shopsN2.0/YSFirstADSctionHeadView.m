//
//  YSFirstADSctionHeadView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSFirstADSctionHeadView.h"

@interface YSFirstADSctionHeadView ()

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UILabel *titleLbl;

@property (strong,nonatomic) UIButton *moreBtn;

@property (strong,nonatomic) UIImageView *adImageIV;

@end

@implementation YSFirstADSctionHeadView

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
    [self addSubview:self.adImageIV];
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

- (UIImageView *)adImageIV {
    if (!_adImageIV) {
        _adImageIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, __kWidth, __kWidth/2)];
        _adImageIV.contentMode = UIViewContentModeScaleToFill;
        _adImageIV.layer.masksToBounds = YES;
        _adImageIV.backgroundColor = LH_RandomColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAD)];
        [_adImageIV addGestureRecognizer:tap];
        _adImageIV.userInteractionEnabled = YES;
    }
    return _adImageIV;
}

- (void)setModel:(YHeadImage *)model {
    _model = model;
     [_adImageIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.imageName]] placeholderImage:MImage(ADPlachorName)];
}

- (void)setClassName:(NSString *)className {
    _titleLbl.text = className;
}

- (void)chooseMore {
    [self.delegate chooseSectionclass:self.tag];
}

- (void)chooseAD {
    [self.delegate chooseADPush:_model.imageUrl Id:_model.imageID];
}

@end
