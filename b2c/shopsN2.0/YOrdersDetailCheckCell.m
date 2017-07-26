//
//  YOrdersDetailCheckCell.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailCheckCell.h"

@interface YOrdersDetailCheckCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YOrdersDetailCheckCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor  = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.detailLb];

    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 55, __kWidth-50, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;
    
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb  = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 70, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(119, 119, 119);
        _titleLb.font = MFont(13);
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb =  [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_titleLb)+20, 20, __kWidth-130, 15)];
        _detailLb.textColor = __DTextColor;
        _detailLb.textAlignment = NSTextAlignmentRight;
        _detailLb.font = MFont(14);
    }
    return _detailLb;
}


-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
}

@end
