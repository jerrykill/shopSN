//
//  YSettingCell.m
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSettingCell.h"

@interface YSettingCell ()

@property (strong,nonatomic) UILabel *titleLb;


@end

@implementation YSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, __kWidth-70, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(16);
    _titleLb.textColor = __DTextColor;

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-60, 17, 42, 13)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.font = MFont(12);
    _detailLb.textColor = LH_RGBCOLOR(151, 151, 151);
    _detailLb.hidden = YES;

    _switChoose = [[UISwitch alloc]initWithFrame:CGRectMake(__kWidth-63, 8, 54, 31)];
    [self addSubview:_switChoose];
    [_switChoose addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    _switChoose.on= YES;

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 46, __kWidth, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)switchAction:(UISwitch *)sender{
    if ([sender isOn]) {
        [self.delegate chooseSwitch:YES index:self.tag];
    }else{
         [self.delegate chooseSwitch:NO index:self.tag];
    }
}


@end
