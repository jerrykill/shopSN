//
//  YChnageCountBtn.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YChnageCountBtn.h"

@interface YChnageCountBtn()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIButton *addBtn;

@property (strong,nonatomic) UIButton *reduceBtn;

@property (strong,nonatomic) UILabel *numLb;

@end

@implementation YChnageCountBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 4;
        self.layer.borderColor = __BackColor.CGColor;
        self.layer.borderWidth = 1;
        _frame = frame;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width =_frame.size.width;
    CGFloat height = _frame.size.height;
    _reduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width*7/24, height)];
    [self addSubview:_reduceBtn];
    [_reduceBtn setImage:MImage(@"less") forState:BtnNormal];
    [_reduceBtn addTarget:self action:@selector(modify:) forControlEvents:BtnTouchUpInside];
    _reduceBtn.tag = 20;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_reduceBtn), 0, 1, height)];
    lineIV.backgroundColor = __BackColor;
    [self addSubview:lineIV];

    _numLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(lineIV), 12, width*5/12-2, height-24)];
    [self addSubview:_numLb];
    _numLb.textColor = __TextColor;
    _numLb.font = MFont(15);
    _numLb.text = @"1";
    _numLb.textAlignment = NSTextAlignmentCenter;

    UIImageView *linesIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_numLb), 0, 1, height)];
    linesIV.backgroundColor = __BackColor;
    [self addSubview:linesIV];

    _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(linesIV), 0, width*7/24, height)];
    [self addSubview:_addBtn];
    [_addBtn setImage:MImage(@"add") forState:BtnNormal];
    [_addBtn addTarget:self action:@selector(modify:) forControlEvents:BtnTouchUpInside];
    _addBtn.tag = 21;
}

-(void)modify:(UIButton*)sender{
    NSInteger num  = [_numLb.text integerValue];
    if (sender.tag - 20) {
        [self.delegate changeCount:YES];
        num ++;
    }else{
        if (num>1) {
        [self.delegate changeCount:NO];
         num --;
        }
    }
    _numLb.text = [NSString stringWithFormat:@"%ld",(long)num];

}

-(void)setCount:(NSString *)count{
    _numLb.text = count;
}

@end
