//
//  YAnnounceCell.m
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAnnounceCell.h"

@interface YAnnounceCell()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YAnnounceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *HeadIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 28, 28)];
    [self addSubview:HeadIV];
    HeadIV.layer.cornerRadius = 4;
    HeadIV.image = MImage(@"announce");


    _titleLb = [[UILabel  alloc]initWithFrame:CGRectMake(CGRectXW(HeadIV)+10, 20, __kWidth-70, 16)];
    [self addSubview:_titleLb];
    _titleLb.textColor = [UIColor blackColor];
    _titleLb.font = MFont(16);
    _titleLb.textAlignment = NSTextAlignmentLeft;

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

@end
