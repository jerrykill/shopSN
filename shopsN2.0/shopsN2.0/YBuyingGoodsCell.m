//
//  YBuyingGoodsCell.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingGoodsCell.h"

@interface YBuyingGoodsCell ()

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) UILabel *nameLb;

@end

@implementation YBuyingGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.countLb];
    [self addSubview:self.priceLb];
    [self addSubview:self.nameLb];

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 114, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}
#pragma mark ==懒加载==
-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 21, 120, 16)];
        _countLb.textAlignment = NSTextAlignmentLeft;
        _countLb.font = MFont(16);
    }
    return _countLb;
}

-(UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth/2, 21, __kWidth/2-36, 16)];
        _priceLb.textAlignment = NSTextAlignmentRight;
        _priceLb.font = MFont(16);
    }
    return _priceLb;
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_countLb)+15, __kWidth-70, 45)];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.font = MFont(16);
        _nameLb.numberOfLines = 2;
    }
    return _nameLb;
}

-(void)setCount:(NSString *)count{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"所需数量：%@",count]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(5, attr.length-5)];
    _countLb.attributedText = attr;
}

-(void)setMoney:(NSString *)money{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"预算单价：¥%@",money]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(5, attr.length-5)];
    _priceLb.attributedText = attr;
}

-(void)setName:(NSString *)name{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"商品名称：\n%@",name]];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(5, attr.length-5)];
    _nameLb.attributedText = attr;
}

@end
