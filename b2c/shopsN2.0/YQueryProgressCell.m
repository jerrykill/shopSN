//
//  YQueryPrgressCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YQueryProgressCell.h"

@interface YQueryProgressCell ()

@property (strong,nonatomic) UILabel *orderLb;

@property (strong,nonatomic) UILabel *moneyLb;

@property (strong,nonatomic) UILabel *statusLb;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UIView *bottomV;

@end

@implementation YQueryProgressCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.orderLb];
    [self addSubview:self.moneyLb];
    [self addSubview:self.statusLb];
    [self addSubview:self.goodIV];
    [self addSubview:self.titleLb];
    [self addSubview:self.numLb];
    [self addSubview:self.lineIV];
    [self addSubview:self.bottomV];


}
#pragma mark ==懒加载==
-(UILabel *)orderLb{
    if (!_orderLb) {
        _orderLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, __kWidth-100, 15)];
        _orderLb.textAlignment = NSTextAlignmentLeft;
        _orderLb.textColor = __DTextColor;
        _orderLb.font = MFont(13);
    }
    return _orderLb;
}

-(UILabel *)moneyLb{
    if (!_moneyLb) {
        _moneyLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_orderLb)+8, __kWidth-100, 15)];
        _moneyLb.textAlignment = NSTextAlignmentLeft;
        _moneyLb.font = MFont(13);
    }
    return _moneyLb;
}

-(UILabel *)statusLb{
    if (!_statusLb) {
        _statusLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-70, 25, 60, 15)];
        _statusLb.textColor= __DefaultColor;
        _statusLb.textAlignment=NSTextAlignmentRight;
        _statusLb.font = MFont(15);
        _statusLb.text = @"待审核";
    }
    return _statusLb;
}

-(UIImageView *)goodIV{
    if (!_goodIV) {
        _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 75, 72, 72)];
        _goodIV.backgroundColor = LH_RandomColor;
        _goodIV.layer.borderColor = __BackColor.CGColor;
        _goodIV.layer.borderWidth = 1;
    }
    return _goodIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, 75, __kWidth-120, 36)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DTextColor;
        _titleLb.font = MFont(14);
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

-(UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_goodIV)+10, CGRectYH(_titleLb)+10, 100, 15)];
        _numLb.textAlignment = NSTextAlignmentLeft;
        _numLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _numLb.font = MFont(14);
    }
    return _numLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 60, __kWidth-20, 1)];
        _lineIV.backgroundColor = __BackColor;

    }
    return _lineIV;
}

-(UIView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 170, __kWidth, 10)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

-(void)setModel:(YReturnsGoodModel *)model{
    _model =model;
    _orderLb.text = [NSString stringWithFormat:@"订单编号：%@",_model.goodId];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:   [NSString stringWithFormat:@"退款金额：%@元",_model.applyMoney]];
    [attr addAttribute:NSForegroundColorAttributeName value:__TextColor range:NSMakeRange(0, 5)];
    [attr addAttribute:NSForegroundColorAttributeName value:__DefaultColor range:NSMakeRange(5, attr.length-6)];
    [attr addAttribute:NSForegroundColorAttributeName value:__TextColor range:NSMakeRange(attr.length-1, 1)];
    _moneyLb.attributedText = attr;

    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.imageName]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = _model.title;
    _numLb.text = [NSString stringWithFormat:@"数量：%@",_model.num];
    switch ([_model.status integerValue]) {
        case 0:
        {
            _statusLb.text = @"审核中";
        }
            break;
        case 1:
        {
            _statusLb.text = @"审核失败";
        }
            break;
        case 2:
            _statusLb.text = @"审核通过";
            break;
        case 3:
            _statusLb.text = @"退货中";
            break;
        case 4:
            _statusLb.text = @"退款中";
            break;
        case 5:
            _statusLb.text = @"完成";
            break;
        case 6:
            _statusLb.text = @"已撤销";
            break;
        default:
            break;
    }
}


@end
