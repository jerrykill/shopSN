//
//  YPayThreeCell.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayThreeCell.h"


@interface YPayThreeCell ()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YPayThreeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initView];
    }
    return self;
}

-(void)initView{
    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 16, 42, 42)];
    [self addSubview:_headIV];
    _headIV.layer.cornerRadius = 21;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+15, 18, 120, 17)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(17);

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+15, CGRectYH(_titleLb)+5, 130, 15)];
    [self addSubview:_detailLb];
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
    _detailLb.font = MFont(14);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setImageName:(NSString *)imageName{
    _headIV.image = MImage(imageName);
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _detailLb.text = detail;
}

@end
