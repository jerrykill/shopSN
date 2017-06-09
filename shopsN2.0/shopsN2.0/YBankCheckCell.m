//
//  YBankCheckCell.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBankCheckCell.h"

@interface YBankCheckCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YBankCheckCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 16, 80, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(16);
    _titleLb.text = @"银行卡";

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-132, 16, 100, 20)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = LH_RGBCOLOR(209, 209, 209);
    _detailLb.font = MFont(16);
    _detailLb.text = @"请选择银行卡";
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
    _detailLb.textColor = __TextColor;
}

@end
