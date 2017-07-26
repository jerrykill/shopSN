
//
//  YOrderGoodListCell.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderGoodListCell.h"
#import "YChnageCountBtn.h"

@interface YOrderGoodListCell()<YChnageCountBtnDelegate>

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *priceLb;

@property (strong,nonatomic) YChnageCountBtn *changeBtn;

@end

@implementation YOrderGoodListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView{
    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 80, 80)];
    [self addSubview:_goodIV];
    _goodIV.backgroundColor = LH_RandomColor;
    _goodIV.contentMode = UIViewContentModeScaleAspectFit;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 15, __kWidth-140, 30)];
    [self addSubview:_titleLb];
    _titleLb.font = MFont(12);
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.numberOfLines = 2;
    _titleLb.textColor = __TextColor;

    _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+10, __kWidth-140, 13)];
    [self addSubview:_detailLb];
    _detailLb.font = MFont(11);
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);

    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_detailLb)+24, 100, 16)];
    [self addSubview:_priceLb];
    _priceLb.textColor = __MoneyColor;
    _priceLb.textAlignment = NSTextAlignmentLeft;

    _changeBtn =[[YChnageCountBtn alloc]initWithFrame:CGRectMake(__kWidth-132, CGRectYH(_detailLb)+14, 132, 40)];
    [self addSubview:_changeBtn];
    _changeBtn.delegate = self;


    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 129, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
    
}

-(void)changeCount:(BOOL)sender{
    [self.delegate changeGoodCount:sender index:self.tag];
}

-(void)setModel:(YShopGoodModel *)model{
    _titleLb.text = model.goodTitle;
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];
    NSString *str = @"";
    for (YGoodTypeModel*type in model.goodTypeArr) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@:%@",type.name,type.size]];
    }
    _detailLb.text = str;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.goodMoney]];
    [attri addAttribute:NSFontAttributeName value:MFont(14) range:NSMakeRange(0, 1)];
    [attri addAttribute:NSFontAttributeName value:MFont(19) range:NSMakeRange(1, attri.length-3)];
    [attri addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(attri.length-3, 3)];
    _priceLb.attributedText = attri;

    _changeBtn.count = model.goodCount;
}


@end
