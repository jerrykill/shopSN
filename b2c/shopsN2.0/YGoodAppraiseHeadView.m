//
//  YGoodAppraiseHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodAppraiseHeadView.h"
#import "YAppraiseGradeView.h"

@interface YGoodAppraiseHeadView()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *nameLb;

@property (strong,nonatomic) UILabel *timeLb;

@property (strong,nonatomic) YAppraiseGradeView *gradV;

@end

@implementation YGoodAppraiseHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headIV];
    [self addSubview:self.nameLb];
    [self addSubview:self.timeLb];
    [self addSubview:self.gradV];

}

#pragma mark ==懒加载==
-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 16, 16)];
        _headIV.image = MImage(@"evico");
    }
    return _headIV;
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+8, 10, __kWidth-200, 12)];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.font = MFont(10);
        _nameLb.textColor = LH_RGBCOLOR(176, 176, 176);
    }
    return _nameLb;
}

-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-170, 10, 110, 11)];
        _timeLb.textAlignment = NSTextAlignmentRight;
        _timeLb.font = MFont(10);
        _timeLb.textColor =  LH_RGBCOLOR(176, 176, 176);
    }
    return _timeLb;
}

-(YAppraiseGradeView *)gradV{
    if (!_gradV) {
        _gradV = [[YAppraiseGradeView alloc]initWithFrame:CGRectMake(CGRectXW(_timeLb)+10, 2, 50, 30)];
    }
    return _gradV;
}

-(void)setModel:(YGoodAppraiseModel *)model {
//    [_headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.imageUrl]]];
    NSString *str =model.name;
    NSMutableString *attr = [[NSMutableString alloc]init];
    for (int i=0; i<str.length-2; i++) {
        [attr appendString:[NSString stringWithFormat:@"*"]];
    }
     NSString *list=[str stringByReplacingCharactersInRange:NSMakeRange(1, str.length-2) withString:attr];
    _nameLb.text = list;
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[model.time doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _timeLb.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:times]];
    _gradV.star =  [model.grade integerValue];
}

@end
