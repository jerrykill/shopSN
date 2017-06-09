//
//  YCompanyInfoCell.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCompanyInfoCell.h"

@interface YCompanyInfoCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YCompanyInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];

    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];

    [self addSubview:self.detailLb];

    UIImageView *lineIV= [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 14, 65, 16)];
        _titleLb.textColor = LH_RGBCOLOR(185, 185, 185);
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(15);
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+5, 14, __kWidth-100, 16)];
        _detailLb.textColor = __TextColor;
        _detailLb.textAlignment = NSTextAlignmentRight;
        _detailLb.font = MFont(16);
    }
    return _detailLb;
}


-(void)setTitle:(NSString *)title{
    _titleLb.text =title;
}

-(void)setDeatil:(NSString *)deatil{
    _detailLb.text = deatil;
}

@end
