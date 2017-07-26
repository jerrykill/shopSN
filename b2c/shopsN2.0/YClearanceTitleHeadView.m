//
//  YClearanceTitleHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/9.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClearanceTitleHeadView.h"

@interface YClearanceTitleHeadView()

@property (strong,nonatomic) GradientLablel *titleLb;


@property (strong,nonatomic) UIImageView *backIV;

@end

@implementation YClearanceTitleHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 40)];
    [self addSubview:_backIV];
    _backIV.image = MImage(@"h2");
    [self sendSubviewToBack:_backIV];


    _titleLb = [[GradientLablel alloc]initWithFrame:CGRectMake((__kWidth-76)/2, 12, 76, 19)];
    [self addSubview:_titleLb];
    _titleLb.font = MFont(19);
    _titleLb.textAlignment = NSTextAlignmentCenter;


}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;

}


@end
