//
//  YBindingCell.m
//  shopsN
//
//  Created by imac on 2017/1/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBindingCell.h"

@interface YBindingCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YBindingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 17)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(16);
    _titleLb.textColor =  __DTextColor;


    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+25, 18, __kWidth-170, 15)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.font = MFont(14);
    _detailLb.textColor = LH_RGBCOLOR(155, 155, 155);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDeatil:(NSString *)deatil{
    _detailLb.text = deatil;
}

@end
