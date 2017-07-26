//
//  YBillChooseView.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBillChooseView.h"

@interface YBillChooseView ()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIImageView *chooseIV;

@property (strong,nonatomic) UILabel *titlLb;

@end

@implementation YBillChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _frame= frame;
        [self initView];
    }
    return self;
}

-(void)initView{
    _chooseIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14, 20, 20)];
    [self addSubview:_chooseIV];
    _chooseIV.image = MImage(@"Cart_off");

    _titlLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_chooseIV)+5, 16, _frame.size.width-25, 16)];
    [self addSubview:_titlLb];
    _titlLb.textAlignment = NSTextAlignmentLeft;
    _titlLb.textColor = LH_RGBCOLOR(102, 102, 102);
    _titlLb.font = MFont(16);
}
-(void)setChoose:(BOOL)choose{
    _choose = choose;
    if (_choose) {
        _chooseIV.image = MImage(@"Cart_on");
    }else{
        _chooseIV.image = MImage(@"Cart_off");
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titlLb.text = title;
}

@end
