//
//  YPopCell.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPopCell.h"

@interface YPopCell ()

@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YPopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 13, 13)];
    [self addSubview:_logoIV];
    _logoIV.backgroundColor = [UIColor clearColor];

    _titleLb= [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 30, 13)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = [UIColor whiteColor];
    _titleLb.font = MFont(12);
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setImageName:(NSString *)imageName{
    _logoIV.image = MImage(imageName);
}


@end
