//
//  YSureOrderPicNumCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderPicNumCell.h"

@interface YSureOrderPicNumCell()


@property (strong,nonatomic) UILabel *countLb;

@end

@implementation YSureOrderPicNumCell

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
    for (int i=0; i<2; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*90, __kWidth, 5)];
        [self addSubview:lineIV];
        lineIV.backgroundColor= __BackColor;
    }
    _countLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-110, 39, 82, 16)];
    [self addSubview:_countLb];
    _countLb.textAlignment = NSTextAlignmentRight;
}

-(void)setData:(NSMutableArray<YShopGoodModel *> *)data{
    _data = data;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%ld类商品",_data.count]];
    [attr addAttribute:NSFontAttributeName value:MFont(14) range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(1, attr.length-4)];
    [attr addAttribute:NSFontAttributeName value:MFont(14) range:NSMakeRange(attr.length-3, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(0, 1)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(1, attr.length-4)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(attr.length-3, 3)];
    _countLb.attributedText = attr;

    for (int i=0; i<_data.count; i++) {
        if (i<3) {
            YShopGoodModel *model = _data[i];
            UIImageView *goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10+70*i, 7.5+5, 60, 60)];
            [self addSubview:goodIV];
            [goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.goodUrl]] placeholderImage:MImage(goodPlachorName)];

        }else{
            for (int j=0; j<3; j++) {
                UIImageView *lineIV =[[UIImageView alloc]initWithFrame:CGRectMake(220+10*j, 44, 7, 7)];
                [self addSubview:lineIV];
                lineIV.backgroundColor = __BackColor;

            }
        }
    }

}


@end
