//
//  YPayAndSendView.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayAndSendView.h"

@interface YPayAndSendView ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *chooseIV;

@end

@implementation YPayAndSendView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, __kWidth-100, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __TextColor;
    _titleLb.font = MFont(18);

    _chooseIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-30, 15, 20, 20)];
    [self addSubview:_chooseIV];
    _chooseIV.image = MImage(@"selects");
    _chooseIV.hidden = YES;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setChoose:(BOOL)choose{
    if (choose) {
        _titleLb.textColor = __DefaultColor;
        _chooseIV.hidden=NO;
    }else{
        _titleLb.textColor = __TextColor;
        _chooseIV.hidden=YES;
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLb.text = title;
}

@end
