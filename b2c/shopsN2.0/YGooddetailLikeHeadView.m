//
//  YGooddetailLikeHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGooddetailLikeHeadView.h"

@interface YGooddetailLikeHeadView()

@property (strong,nonatomic) UIImageView *bottomIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIButton *nextBtn;

@end

@implementation YGooddetailLikeHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.bottomIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.nextBtn];
}
#pragma mark ==懒加载==
-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 120, 17)];
        _titleLb.font = MFont(14);
        _titleLb.textAlignment =NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
    }
    return _titleLb;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-50, 11, 50, 20)];
        _nextBtn.backgroundColor =[UIColor clearColor];
        _nextBtn.titleLabel.font = MFont(12);
        [_nextBtn setTitle:@"换一批" forState:BtnNormal];
        [_nextBtn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnNormal];
        [_nextBtn addTarget:self action:@selector(changeNext) forControlEvents:BtnTouchUpInside];
    }
    return _nextBtn;
}

-(void)changeNext{
    [self.delegate changeNext];
}

- (void)setTitles:(NSString *)titles {
    _titleLb.text = titles;
    if (![titles isEqualToString:@"猜你喜欢"]) {
        _nextBtn.hidden = YES;
        _titleLb.textColor = LH_RGBCOLOR(224, 40, 40);
    }else{
        _titleLb.textColor = __DTextColor;
        _nextBtn.hidden = NO;
    }
}

@end
