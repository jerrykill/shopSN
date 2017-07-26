//
//  YPersonIntegralCell.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonIntegralCell.h"

@interface YPersonIntegralCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *timeLb;

@property (strong,nonatomic) UILabel *changeLb;

@end

@implementation YPersonIntegralCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.timeLb];

    [self addSubview:self.changeLb];

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 59, __kWidth-20, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
    
}
#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(16, 11, __kWidth-116, 15)];
        _titleLb.textAlignment =NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(14);
    }
    return _titleLb;
}

-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectYH(_titleLb)+5, 120, 15)];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _timeLb.font = MFont(11);
    }
    return _timeLb;
}

-(UILabel *)changeLb{
    if (!_changeLb) {
        _changeLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-100, 21, 77, 15)];
        _changeLb.textAlignment = NSTextAlignmentRight;
        _changeLb.font = MFont(13);
    }
    return _changeLb;
}


- (void)setModel:(YPersonIntegralModel *)model {
    _titleLb.text = model.title;
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[model.time integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *str = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:times]];
    _timeLb.text = str;
    if ([model.change rangeOfString:@"-"].location==NSNotFound) {
        _changeLb.textColor = LH_RGBCOLOR(57, 171, 4);
    }else{
        _changeLb.textColor = __DefaultColor;
    }
    _changeLb.text = model.change;
}

@end
