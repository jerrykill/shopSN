//
//  YAppariseBottomView.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YAppariseBottomView.h"
#import "YAppraiseGradeView.h"

@interface YAppariseBottomView()

@property (strong,nonatomic) UILabel *listLb;

@property (strong,nonatomic) YAppraiseGradeView *gradV;

@end

@implementation YAppariseBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.listLb];
    [self addSubview:self.gradV];

    
}
#pragma mark ==懒加载==
-(UILabel *)listLb{
    if (!_listLb) {
        _listLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 2, __kWidth-80, 15)];
        _listLb.textAlignment = NSTextAlignmentLeft;
        _listLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _listLb.font = MFont(10);
    }
    return _listLb;
}

-(YAppraiseGradeView *)gradV{
    if (_gradV) {
        _gradV = [[YAppraiseGradeView alloc]initWithFrame:CGRectMake(__kWidth-60, 0, 50, 30)];
    }
    return _gradV;
}

-(void)setModel:(YGoodAppraiseModel *)model{
    _model = model;
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[model.time doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *str = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:times]];
    for (YGoodTypeModel *type in _model.list) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@" %@:%@",type.name,type.size]];
    }
    _listLb.text = str;
    _gradV.star = [_model.grade integerValue];
    
}

@end
