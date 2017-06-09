//
//  YAddNewCardCell.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAddNewCardCell.h"

@interface YAddNewCardCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *addIV;

@end


@implementation YAddNewCardCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _addIV = [[UIImageView alloc]initWithFrame:CGRectMake((__kWidth-120)/2, 16.5, 15, 15)];
    [self addSubview:_addIV];
    _addIV.image = MImage(@"add_card");

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_addIV)+10, 16.5, 100, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __TextColor;
    _titleLb.font = MFont(14);
    _titleLb.text = @"使用新银行卡";
}

@end
