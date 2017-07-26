//
//  YSendTimeCell.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSendTimeCell.h"

@interface YSendTimeCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YSendTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 120, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _titleLb.font = MFont(12);

    _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(119, 0, 1, 40)];
    [self addSubview:_lineIV];
    _lineIV.backgroundColor = __BackColor;

    _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 120, 1)];
    [self addSubview:_bottomIV];
    _bottomIV.backgroundColor = __BackColor;
    _bottomIV.hidden = YES;
}

-(void)setTitle:(NSString *)title{
    _title =title;
    _titleLb.text = _title;
}

-(void)setChoose:(BOOL)choose{
    if (choose) {
        _titleLb.textColor = __DefaultColor;
        _bottomIV.hidden = NO;
        _lineIV.hidden = YES;
    }else{
        _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _bottomIV.hidden = YES;
        _lineIV.hidden = NO;
    }
}

@end
