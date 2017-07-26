//
//  YSearchPushCell.m
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSearchPushCell.h"

@interface YSearchPushCell()

@property (strong,nonatomic) UIButton *mainBtn;

@end

@implementation YSearchPushCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _mainBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (__kWidth-40)/3, 38)];
    [self addSubview:_mainBtn];
    _mainBtn.backgroundColor = [UIColor whiteColor];
    _mainBtn.layer.cornerRadius = 5;
    _mainBtn.titleLabel.font = MFont(15);
    [_mainBtn setTitleColor:__TextColor forState:BtnNormal];
    _mainBtn.userInteractionEnabled = NO;

}

-(void)setTitle:(NSString *)title{
    [_mainBtn setTitle:title forState:BtnNormal];
}

@end
