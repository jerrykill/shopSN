//
//  YCashedNameCell.m
//  shopsN
//
//  Created by imac on 2017/1/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YCashedNameCell.h"

@interface YCashedNameCell()

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UILabel *nameLb;

@end

@implementation YCashedNameCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _numLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 40, 15)];
    [self addSubview:_numLb];
    _numLb.textAlignment = NSTextAlignmentLeft;
    _numLb.textColor = LH_RGBCOLOR(153, 153, 153);
    _numLb.font = MFont(13);

    _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, __kWidth-125, 15)];
    [self addSubview:_nameLb];
    _nameLb.textAlignment = NSTextAlignmentRight;
    _nameLb.textColor = __TextColor;
    _nameLb.font = MFont(15);
    
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 34, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setNum:(NSString *)num{
    _numLb.text = [NSString stringWithFormat:@"%@",num];
}

-(void)setName:(NSString *)name{
    _nameLb.text = name;
}

@end
