//
//  YSureOrderDiscountCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderDiscountCell.h"

@interface YSureOrderDiscountCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end


@implementation YSureOrderDiscountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor =[UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-150, 20, 123, 15)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = __DTextColor;
    _detailLb.font = MFont(14);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 55, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
}


@end
