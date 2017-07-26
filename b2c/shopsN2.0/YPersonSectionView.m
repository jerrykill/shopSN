//
//  YPersonSectionView.m
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonSectionView.h"

@interface YPersonSectionView()

@property (strong,nonatomic) UIButton *sureBtn;

@end

@implementation YPersonSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, __kWidth-20, 44)];
    [self addSubview:_sureBtn];
    _sureBtn.backgroundColor = __DefaultColor;
    _sureBtn.layer.cornerRadius = 4;
    _sureBtn.titleLabel.font = MFont(15);
    [_sureBtn setTitle:@"确认修改" forState:BtnNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
    [_sureBtn addTarget:self action:@selector(chooseSure) forControlEvents:BtnTouchUpInside];

}

-(void)chooseSure{
    [self.delegate sureChange];
}

@end
