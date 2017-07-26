
//
//  YGoodTypeView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodTypeView.h"


@interface YGoodTypeView (){
    CGRect _frame;
}

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *numLb;



@end

@implementation YGoodTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _frame= frame;
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-3, frame.size.width, 3)];
        [self addSubview:_bottomIV];
        [self bringSubviewToFront:_bottomIV];
        _bottomIV.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.numLb];

}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, _frame.size.width, 15)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor =  LH_RGBCOLOR(117, 117, 117);
        _titleLb.font = MFont(14);
    }
    return _titleLb;
}

-(UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleLb)+5, _frame.size.width, 15)];
        _numLb.textAlignment = NSTextAlignmentCenter;
        _numLb.textColor = __DTextColor;
        _numLb.font = MFont(15);
    }
    return _numLb;
}


-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setNum:(NSString *)num{
    _numLb.text = num;
}



@end
