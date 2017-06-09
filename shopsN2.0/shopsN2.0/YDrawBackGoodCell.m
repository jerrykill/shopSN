//
//  YDrawBackGoodCell.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YDrawBackGoodCell.h"

@interface YDrawBackGoodCell ()

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *countLb;

@end

@implementation YDrawBackGoodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.countLb];
}

#pragma mark ==懒加载==
-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 74, 74)];
        _goodIV.backgroundColor = LH_RandomColor;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 18, __kWidth-120, 36)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(13);
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

-(UILabel *)countLb{
    if (!_countLb) {
        _countLb =[[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+10,  __kWidth-120, 15)];
        _countLb.textAlignment =NSTextAlignmentLeft;
        _countLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _countLb.font = MFont(13);

    }
    return _countLb;
}

-(void)setModel:(YShopGoodModel *)model{
    _model = model;
    _titleLb.text = _model.goodTitle;
    _countLb.text = [NSString stringWithFormat:@"数量：%@",_model.goodCount];
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.goodUrl]]];
}


@end
