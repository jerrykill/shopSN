//
//  YApplyAfterSalesCell.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplyAfterSalesCell.h"

@interface YApplyAfterSalesCell ()

@property (strong,nonatomic) UILabel *orderLb;

@property (strong,nonatomic) UILabel *dateLb;

@property (strong,nonatomic) UIImageView *goodIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UIView *bottomV;

@end

@implementation YApplyAfterSalesCell

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
    [self addSubview:self.dateLb];
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

-(UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_orderLb)+8, __kWidth-100, 15)];
        _dateLb.textAlignment = NSTextAlignmentLeft;
        _dateLb.font = MFont(13);
        _dateLb.textColor = __TextColor;
    }
    return _dateLb;
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


-(void)setModel:(YReturnsOrdersModel *)model{
    _model =model;
    YReturnsGoodModel *good = _model.list.firstObject;
    _orderLb.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderId];
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[_model.createDate integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _dateLb.text = [NSString stringWithFormat:@"下单时间：%@",[dateFormatter stringFromDate:times]];
    [_goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,good.imageName]]];
    _titleLb.text = good.title;
    _numLb.text = [NSString stringWithFormat:@"数量：%@",good.num];
}

@end
