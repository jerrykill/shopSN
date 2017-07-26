//
//  YMessageHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YMessageHeadView.h"

@interface YMessageHeadView ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *userLb;

@property (strong,nonatomic) UILabel *timeLb;

@end

@implementation YMessageHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(16, 15, __kWidth-40, 17)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = [UIColor blackColor];
    _titleLb.font = MFont(17);

    _userLb = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectYH(_titleLb)+15, __kWidth/2, 15)];
    [self addSubview:_userLb];
    _userLb.textAlignment = NSTextAlignmentLeft;
    _userLb.font = MFont(14);

    _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-100, 44, 83, 15)];
    [self addSubview:_timeLb];
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.textColor = LH_RGBCOLOR(170, 170, 170);
    _timeLb.font = MFont(11);

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(16, 73, __kWidth-37, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setUserName:(NSString *)userName{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"发件人：%@",userName]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(170, 170, 170) range:NSMakeRange(0, 4)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(110, 167, 32) range:NSMakeRange(4, attr.length-4)];
    _userLb.attributedText = attr;
}


-(void)setTime:(NSString *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *pass = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSString*day = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pass]];
    _timeLb.text = day;

}


@end
