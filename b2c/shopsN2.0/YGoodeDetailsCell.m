//
//  YGoodeDetailsCell.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodeDetailsCell.h"

@interface YGoodeDetailsCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *deatilLb;

@property (strong,nonatomic) UIImageView *bottomIV;

@end

@implementation YGoodeDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.titleLb];
    [self addSubview:self.deatilLb];
    [self addSubview:self.bottomIV];
}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, __kWidth/3-10, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = LH_RGBCOLOR(105, 105, 105);
        _titleLb.font = MFont(13);
    }
    return _titleLb;
}

-(UILabel *)deatilLb{
    if (!_deatilLb) {
        _deatilLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth/3, 14, __kWidth*2/3-20, 15)];
        _deatilLb.textAlignment = NSTextAlignmentLeft;
        _deatilLb.textColor = __DTextColor;
        _deatilLb.font = MFont(13);
    }
    return _deatilLb;
}

-(UIImageView *)bottomIV{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, __kWidth, 1)];
        _bottomIV.backgroundColor = __BackColor;
    }
    return _bottomIV;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

-(void)setDetail:(NSString *)detail{
    _deatilLb.text = detail;
}

-(void)setIsHead:(BOOL)isHead{
    if (isHead) {
        _deatilLb.numberOfLines = 2;
        _deatilLb.frame = CGRectMake(__kWidth/3, 10, __kWidth*2/3-20, 40);
        _bottomIV.frame = CGRectMake(0, 61, __kWidth, 1);
    }

    
}
@end
