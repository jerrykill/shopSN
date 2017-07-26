//
//  YSureOrderWarnCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderWarnCell.h"

@interface YSureOrderWarnCell ()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YSureOrderWarnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 21, __kWidth-30, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(13);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 55, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

@end
