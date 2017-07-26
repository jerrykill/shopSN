//
//  YSystemNewsCell.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSystemNewsCell.h"

@interface YSystemNewsCell ()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *timeLb;

@end

@implementation YSystemNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 50, 50)];
    [self addSubview:_logoIV];
    _logoIV.layer.cornerRadius = 5;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+14, 22, 110, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(15);

    _timeLb = [[UILabel  alloc]initWithFrame:CGRectMake(__kWidth-100, 22, 75, 15)];
    [self addSubview:_timeLb];
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.textColor = LH_RGBCOLOR(170, 170, 170);
    _timeLb.font = MFont(12);

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+14, CGRectYH(_titleLb)+7, __kWidth-90, 15)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
    _detailLb.font = MFont(13);

    UIImageView *bottomIV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 76, __kWidth, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;


}

- (void)setModel:(YSMessageModel *)model {
    _model = model;
    _titleLb.text = model.title;
    _logoIV.image = MImage(model.imageName);
    _detailLb.text = model.content;

    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    NSInteger sendTime = [timeSp integerValue]- [model.time integerValue];
    if (sendTime/60<1) {
        _timeLb.text = @"刚刚";
    }else if (sendTime/3600<1){
        _timeLb.text = [NSString stringWithFormat:@"%ld分钟前",sendTime/60];
    }else if (sendTime/216000<1){
        _timeLb.text = [NSString stringWithFormat:@"%ld小时前",sendTime/3600];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSDate *pass = [NSDate dateWithTimeIntervalSince1970:[model.time integerValue]];
        NSString*day = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pass]];
        _timeLb.text = day;
    }
}


@end
