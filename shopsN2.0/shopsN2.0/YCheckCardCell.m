//
//  YCheckCardCell.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCheckCardCell.h"

@interface YCheckCardCell ()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *headIV;

@end

@implementation YCheckCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];

    }
    return self;
}

-(void)initView{
    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 18, 18)];
    [self addSubview:_headIV];
    _headIV.image = MImage(@"card_ico");

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_headIV)+10, 15, __kWidth-70, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(13);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 47, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setImageName:(NSString *)imageName {
//    _headIV.image = MImage(imageName);
}



@end
