//
//  YGoodListBottomView.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodListBottomView.h"

@interface YGoodListBottomView()
//分享
@property (strong,nonatomic) UIButton *shareBtn;
//加入清单
@property (strong,nonatomic) UIButton *addshopBtn;
//找相似
@property (strong,nonatomic) UIButton *likeBtn;

@end

@implementation YGoodListBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 6, 25, 16)];
    [self addSubview:_shareBtn];
    [_shareBtn setImage:MImage(@"share") forState:BtnNormal];
    _shareBtn.tag = 30;
    [_shareBtn addTarget:self action:@selector(ListAction:) forControlEvents:BtnTouchUpInside];

    _addshopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_shareBtn)+5, 2, 75, 24)];
    [self addSubview:_addshopBtn];
    _addshopBtn.layer.cornerRadius = 3;
    _addshopBtn.layer.borderColor = __BackColor.CGColor;
    _addshopBtn.layer.borderWidth = 0.5;
    _addshopBtn.titleLabel.font = MFont(12);
    _addshopBtn.tag = 31;
    [_addshopBtn setTitle:@"加入购物车" forState:BtnNormal];
    [_addshopBtn setTitleColor:LH_RGBCOLOR(255, 114, 0) forState:BtnNormal];
    [_addshopBtn addTarget:self action:@selector(ListAction:) forControlEvents:BtnTouchUpInside];

    _likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_addshopBtn)+5, 2, 62, 24)];
    [self addSubview:_likeBtn];
    _likeBtn.layer.cornerRadius = 3;
    _likeBtn.layer.borderColor = __BackColor.CGColor;
    _likeBtn.layer.borderWidth = 0.5;
    _likeBtn.titleLabel.font = MFont(12);
    _likeBtn.tag = 32;
    [_likeBtn setTitle:@"找相似" forState:BtnNormal];
    [_likeBtn setTitleColor:__TextColor forState:BtnNormal];
    [_likeBtn addTarget:self action:@selector(ListAction:) forControlEvents:BtnTouchUpInside];

}

-(void)ListAction:(UIButton*)sender{
    [self.delegate GoodListAction:(sender.tag-30)];
}


@end
