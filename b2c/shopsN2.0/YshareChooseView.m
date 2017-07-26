//
//  YshareChooseView.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YshareChooseView.h"

@interface YshareChooseView()

@end

@implementation YshareChooseView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-100)/2, 0, 100, 13)];
    [self addSubview:titleLb];
    titleLb.textColor = LH_RGBCOLOR(159, 159, 159);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.font = MFont(12);
    titleLb.text = @"社交账号一键登录";

//    NSArray *imageArr = @[@"login_qq",@"login_wx",@"login_wb"];
    NSArray *imageArr = @[@"login_qq",@"login_wx"];
    for (int i=0; i<2; i++) {
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*((__kWidth-120)/3+60)+(__kWidth-120)/3, 28, 60, 60)];
        [self addSubview:shareBtn];
        shareBtn.layer.cornerRadius = 30;
        [shareBtn setImage:MImage(imageArr[i]) forState:BtnNormal];
        shareBtn.tag = i;
        [shareBtn addTarget:self action:@selector(login:) forControlEvents:BtnTouchUpInside];
    }
}

- (void)login:(UIButton*)sender{
    [self.delegate chooseShare:sender.tag];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(ctx, 0.2);  //线宽
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetRGBStrokeColor(ctx, 228/255, 228/255, 228/255, 0.5);  //颜色
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, __kWidth/2+50, 7);  //起点坐标
    CGContextAddLineToPoint(ctx, __kWidth-30, 7);   //终点坐标
    CGContextStrokePath(ctx);

    CGContextRef ctx1 = UIGraphicsGetCurrentContext();//获取当前ctx
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(ctx1, 0.2);  //线宽
    CGContextSetAllowsAntialiasing(ctx1, YES);
    CGContextSetRGBStrokeColor(ctx1, 228/255, 228/255, 228/255, 0.5);  //颜色
    CGContextBeginPath(ctx1);
    CGContextMoveToPoint(ctx1, 30, 7);  //起点坐标
    CGContextAddLineToPoint(ctx1, (__kWidth-100)/2, 7);   //终点坐标
    CGContextStrokePath(ctx1);
}

@end
