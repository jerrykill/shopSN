//
//  YPayTypeChooseCell.m
//  shopsN
//
//  Created by imac on 2016/12/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPayTypeChooseCell.h"

@interface YPayTypeChooseCell ()

@property (strong,nonatomic) UIImageView *chooseIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YPayTypeChooseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _chooseIV = [[UIImageView alloc]initWithFrame:CGRectMake(11, 12, 25, 25)];
    [self addSubview:_chooseIV];
    _chooseIV.layer.cornerRadius = 12.5;
    _chooseIV.image = MImage(@"Cart_off");

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_chooseIV)+10, 17, __kWidth-70, 16)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = __DTextColor;
    _titleLb.font = MFont(16);
    _titleLb.text = @"银行卡快捷支付服务";
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

}

-(void)setMoney:(NSString *)money{
    _money = money;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"使用账户余额(当前余额：%@元)",_money]];
    [attr addAttribute:NSFontAttributeName value:MFont(16) range:NSMakeRange(0, 6)];
    [attr addAttribute:NSFontAttributeName value:MFont(14) range:NSMakeRange(6, attr.length-6)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(0, 6)];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(6, 6)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(12, _money.length)
     ];
    [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(attr.length-2, 2)];
    _titleLb.attributedText = attr;
}

-(void)setChoose:(BOOL)choose{
    _choose = choose;
    if (_choose) {
        _chooseIV.image = MImage(@"Cart_on");
    }else{
        _chooseIV.image = MImage(@"Cart_off");
    }
}
@end
