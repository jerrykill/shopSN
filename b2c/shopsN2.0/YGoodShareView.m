//
//  YGoodShareView.m
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodShareView.h"
#import "YGoodShareBtnView.h"

@interface YGoodShareView()

@end

@implementation YGoodShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseHidden)];
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-180)];
    [self addSubview:backV];
    backV.backgroundColor = [UIColor blackColor];
    backV.alpha = 0.4;
    [backV addGestureRecognizer:tap];

    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, __kHeight-180, __kWidth, 180)];
    [self addSubview:bottomV];
    bottomV.backgroundColor = [UIColor whiteColor];

    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-120)/2, 10, 120, 20)];
    [bottomV addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.font = MFont(17);
    titleLb.textColor = LH_RGBCOLOR(199, 199, 199);
    titleLb.text = @"分享到";

    for (int i=0; i<2; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*(__kWidth/2+60), 21, (__kWidth-140)/2, 2)];
        [bottomV addSubview:lineIV];
        lineIV.backgroundColor = __BackColor;
    }
//    NSArray *titleArr = @[@"微信好友",@"朋友圈",@"QQ好友",@"新浪微博"];
//    NSArray *imageArr =@[@"share_wx",@"share_pyq",@"share_qq",@"share_wb"];
    NSArray *titleArr = @[@"微信好友",@"朋友圈",@"QQ好友"];
    NSArray *imageArr =@[@"share_wx",@"share_pyq",@"share_qq"];
    for (int i=0; i<3; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseShare:)];
        YGoodShareBtnView *btnV = [[YGoodShareBtnView alloc]initWithFrame:CGRectMake(i*__kWidth/3, CGRectYH(titleLb)+20, __kWidth/3, 100)];
        [bottomV addSubview:btnV];
        btnV.title = titleArr[i];
        btnV.imageName = imageArr[i];
        btnV.tag = i+66;
        [btnV addGestureRecognizer:tap];
    }
}

-(void)chooseShare:(UITapGestureRecognizer*)tap{
    [self.delegate shareType:(tap.view.tag-66) Url:_goodID];
}

-(void)chooseHidden{
    [self removeFromSuperview];
}



@end
