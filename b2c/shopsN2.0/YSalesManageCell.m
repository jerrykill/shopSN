//
//  YSalesManageCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSalesManageCell.h"

@interface YSalesManageCell ()

@property (strong,nonatomic) UILabel *saleIdLb;

@property (strong,nonatomic) UILabel *orderIdLb;

@property (strong,nonatomic) UILabel *timeLb;

@property (strong,nonatomic) UILabel *typeLb;

@property (strong,nonatomic) UIImageView *lineIV;

@property (strong,nonatomic) UILabel *reasonLb;

@property (strong,nonatomic) UILabel *infoLb;

@property (strong,nonatomic)  UIView *bottomV;

@end

@implementation YSalesManageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.saleIdLb];
    [self addSubview:self.orderIdLb];
    [self addSubview:self.timeLb];
    [self addSubview:self.typeLb];
    [self addSubview:self.lineIV];
    [self addSubview:self.reasonLb];
    [self addSubview:self.infoLb];
    [self addSubview:self.bottomV];
}

#pragma mark ==懒加载==
-(UILabel *)saleIdLb{
    if (!_saleIdLb) {
        _saleIdLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, __kWidth-120, 15)];
        _saleIdLb.textAlignment = NSTextAlignmentLeft;
        _saleIdLb.textColor = __DTextColor;
        _saleIdLb.font = MFont(13);
    }
    return _saleIdLb;
}

-(UILabel *)orderIdLb{
    if (!_orderIdLb) {
        _orderIdLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_saleIdLb)+5, __kWidth-120, 15)];
        _orderIdLb.textAlignment = NSTextAlignmentLeft;
        _orderIdLb.textColor = __DTextColor;
        _orderIdLb.font = MFont(13);
    }
    return _orderIdLb;
}

-(UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_orderIdLb)+5, __kWidth, 15)];
        _timeLb.textAlignment = NSTextAlignmentLeft;
        _timeLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _timeLb.font = MFont(13);
    }
    return _timeLb;
}

-(UILabel *)typeLb{
    if (!_typeLb) {
        _typeLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-100, 20, 90, 15)];
        _typeLb.textAlignment = NSTextAlignmentRight;
        _typeLb.textColor = LH_RGBCOLOR(102, 102, 102);
    }
    return _typeLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 89, __kWidth-20, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(UILabel *)reasonLb{
    if (!_reasonLb) {
        _reasonLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_lineIV)+8, 100, 15)];
        _reasonLb.textAlignment = NSTextAlignmentLeft;
        _reasonLb.textColor =  LH_RGBCOLOR(117, 117, 117);
        _reasonLb.font = MFont(13);
        _reasonLb.text = @"售后原因：";
    }
    return _reasonLb;
}

-(UILabel *)infoLb{
    if (!_infoLb) {
        _infoLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_reasonLb)+5, __kWidth-20, 15)];
        _infoLb.textAlignment = NSTextAlignmentLeft;
        _infoLb.textColor = __DTextColor;
        _infoLb.font = MFont(13);
        _infoLb.numberOfLines =0;
    }
    return _infoLb;
}

- (UIView *)bottomV {
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 130, __kWidth, 10)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

-(void)setModel:(YSalesManageModel *)model{
    _model = model;
    _saleIdLb.text = [NSString stringWithFormat:@"售后编号：%@",_model.salesId];
    _orderIdLb.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderId];
    _timeLb.text = [NSString stringWithFormat:@"申请时间：%@",_model.applyTime];
    switch ([_model.manageSatus integerValue]) {
        case 0:
            _typeLb.text = @"审核中";
            break;
        case 1:
            _typeLb.text = @"审核失败";
            break;
        case 2:
            _typeLb.text = @"审核通过";
            break;
        case 3:
            _typeLb.text = @"退货中";
            break;
        case 4:
            _typeLb.text = @"退款中";
            break;
        case 5:
            _typeLb.text = @"完成";
            break;
        case 6:
            _typeLb.text = @"已撤销";
            break;
        default:
            break;
    }
    NSString *str = _model.info;
    CGSize size =[str boundingRectWithSize:CGSizeMake(__kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(13)} context:nil].size;
    _infoLb.frame= CGRectMake(10, 118, __kWidth-20, size.height);
    _infoLb.text = _model.info;

    _bottomV.frame = CGRectMake(0, 130+size.height, __kWidth, 10);

   
}

@end
