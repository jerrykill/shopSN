//
//  YGiftFilterNaviView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftFilterNaviView.h"

@interface YGiftFilterNaviView ()

@property (strong,nonatomic) UIButton *leftBtn;

@property (strong,nonatomic) UIButton *titleBtn;

@property (strong,nonatomic) UIButton *rightBtn;

@end

@implementation YGiftFilterNaviView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LH_RGBCOLOR(208, 17, 27);
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.leftBtn];
    [self addSubview:self.titleBtn];
    [self addSubview:self.rightBtn];



}

#pragma mark ==懒加载==
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 29, 25, 25)];
        _leftBtn.tag = 20;
        _leftBtn.layer.cornerRadius = 12.5;
        [_leftBtn setImage:MImage(@"back") forState:BtnNormal];
        [_leftBtn addTarget:self action:@selector(naviAction:) forControlEvents:BtnTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake((__kWidth-160)/2, 27, 160, 30)];
        _titleBtn.backgroundColor= [UIColor clearColor];
        _titleBtn.tag = 21;
        _titleBtn.titleLabel.font = BFont(16);
        [_titleBtn setImage:MImage(@"head_down") forState:BtnNormal];
        [_titleBtn setTitle:@"积分筛选" forState:BtnNormal];
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        [_titleBtn addTarget:self action:@selector(naviAction:) forControlEvents:BtnTouchUpInside];
    }
    return _titleBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn  = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-35, 29, 25, 25)];
        _rightBtn.tag = 22;
        [_rightBtn setImage:MImage(@"more") forState:BtnNormal];
        _rightBtn.titleLabel.font = MFont(15);
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_rightBtn addTarget:self action:@selector(naviAction:) forControlEvents:BtnTouchUpInside];
    }
    return _rightBtn;
}

- (void)setTitle:(NSString *)title {
    [_titleBtn setTitle:title forState:BtnNormal];
}

-(void)naviAction:(UIButton*)sender{
    [self.delegate giftNaviAction:(sender.tag-20)];
}

@end
