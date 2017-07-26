//
//  YGoodCountCell.m
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodCountCell.h"

@interface YGoodCountCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *stockLb;

@property (strong,nonatomic) UIButton *numBtn;


@end

@implementation YGoodCountCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 50, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _titleLb.font = MFont(16);
    _titleLb.text = @"数量";

    _stockLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb), 15, __kWidth-225, 13)];
    [self addSubview:_stockLb];
    _stockLb.textAlignment = NSTextAlignmentRight;
    _stockLb.textColor = LH_RGBCOLOR(174, 173, 173);
    _stockLb.font = MFont(12);

    UIButton *reduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_stockLb)+5, 5, 35, 40)];
    [self addSubview:reduceBtn];
    reduceBtn.layer.cornerRadius = 4;
    reduceBtn.layer.borderWidth = 1;
    reduceBtn.layer.borderColor = __BackColor.CGColor;
    reduceBtn.titleLabel.font = MFont(15);
    [reduceBtn setTitle:@"－" forState:BtnNormal];
    [reduceBtn setTitleColor:LH_RGBCOLOR(117, 117, 117) forState:BtnNormal];
    [reduceBtn addTarget:self action:@selector(reduce) forControlEvents:BtnTouchUpInside];

    _numBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(reduceBtn), 5, 50, 40)];
    [self addSubview:_numBtn];
    _numBtn.layer.borderColor = __BackColor.CGColor;
    _numBtn.layer.borderWidth = 1;
    _numBtn.titleLabel.font = MFont(15);
    [_numBtn setTitle:@"1" forState:BtnNormal];
    [_numBtn setTitleColor:LH_RGBCOLOR(117, 117, 117) forState:BtnNormal];
    _numBtn.userInteractionEnabled = NO;

    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_numBtn), 5, 35, 40)];
    [self addSubview:addBtn];
    addBtn.layer.cornerRadius = 4;
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor = __BackColor.CGColor;
    addBtn.titleLabel.font = MFont(15);
    [addBtn setTitle:@"＋" forState:BtnNormal];
    [addBtn setTitleColor:LH_RGBCOLOR(117, 117, 117) forState:BtnNormal];
    [addBtn addTarget:self action:@selector(add) forControlEvents:BtnTouchUpInside];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(25, CGRectYH(_numBtn)+4, __kWidth-50, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;


}
#pragma mark ==减少==
-(void)reduce{
    NSInteger i = [_numBtn.titleLabel.text integerValue];
    if (i>1) {
    i--;
    [self.delegate countChange:NO];
    }
    [_numBtn setTitle:[NSString stringWithFormat:@"%ld",i] forState:BtnNormal];

}
#pragma mark ==增加==
-(void)add{
    NSInteger i = [_numBtn.titleLabel.text integerValue];
    if (i<[_stock integerValue]) {
        i++;
        [self.delegate countChange:YES];
    }else{
        [SXLoadingView showAlertHUD:@"抱歉！超出库存了" duration:1.5];
    }
    [_numBtn setTitle:[NSString stringWithFormat:@"%ld",i] forState:BtnNormal];
}

-(void)setStock:(NSString *)stock{
    _stock = stock;
    _stockLb.text = [NSString stringWithFormat:@"库存：%@件",_stock];
}

-(void)setNum:(NSString *)num{
    [_numBtn setTitle:num forState:BtnNormal];
}

@end
