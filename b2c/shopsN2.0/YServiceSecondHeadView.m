//
//  YServiceSecondHeadView.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceSecondHeadView.h"

@interface YServiceSecondHeadView ()

@end

@implementation YServiceSecondHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(18, 16, 100, 15)];
    [self addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.textColor = __TextColor;
    titleLb.font = MFont(13);
    titleLb.text = @"问题查询";
}

@end
