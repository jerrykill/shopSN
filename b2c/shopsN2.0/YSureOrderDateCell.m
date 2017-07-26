//
//  YSureOrderDateCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderDateCell.h"

@interface YSureOrderDateCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *dateLb;

@end

@implementation YSureOrderDateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 21, 90, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(119, 119, 119);
    _titleLb.font = MFont(13);
    _titleLb.text = @"送货时间";

    _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth/2, 21, __kWidth/2-47, 15)];
    [self addSubview:_dateLb];
    _dateLb.textAlignment = NSTextAlignmentRight;
    _dateLb.textColor = LH_RGBCOLOR(119, 119, 119);
    _dateLb.font = MFont(14);

    UIImageView *dataIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth-33, 18, 20, 20)];
    [self addSubview:dataIV];
    dataIV.image = MImage(@"purchase_date");

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 55, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

-(void)setDate:(NSString *)date{
    _dateLb.text = date;
}

@end
