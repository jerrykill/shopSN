//
//  YOrdersDetailTimeCell.m
//  shopsN
//
//  Created by imac on 2016/12/20.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailTimeCell.h"

@interface YOrdersDetailTimeCell()

@property (strong,nonatomic) UILabel *creatLb;

@property (strong,nonatomic) UILabel *payLb;

@property (strong,nonatomic) UILabel *sendLb;

@end

@implementation YOrdersDetailTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}


-(void)initView{
    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, __kWidth-20, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;

    [self addSubview:self.creatLb];
    [self addSubview:self.payLb];
    [self addSubview:self.sendLb];

}

#pragma mark ==懒加载==
-(UILabel *)creatLb{
    if (!_creatLb) {
        _creatLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, __kWidth-20, 15)];
        _creatLb.textAlignment = NSTextAlignmentLeft;
        _creatLb.textColor = LH_RGBCOLOR(121, 121, 121);
        _creatLb.font = MFont(11);
    }
    return _creatLb;
}

-(UILabel *)payLb{
    if (!_payLb) {
        _payLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_creatLb)+15, __kWidth-20, 15)];
        _payLb.textAlignment = NSTextAlignmentLeft;
        _payLb.textColor =  LH_RGBCOLOR(121, 121, 121);
        _payLb.font = MFont(11);
    }
    return _payLb;
}

-(UILabel *)sendLb{
    if (!_sendLb) {
        _sendLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_payLb)+15, __kWidth-20, 15)];
        _sendLb.textAlignment = NSTextAlignmentLeft;
        _sendLb.textColor = LH_RGBCOLOR(121, 121, 121);
        _sendLb.font = MFont(11);
    }
    return _sendLb;
}

-(void)setCreateTime:(NSString *)createTime{
    _creatLb.text = [NSString stringWithFormat:@"创建时间：%@",createTime];
}

-(void)setPayTime:(NSString *)payTime{
    _payLb.text = [NSString stringWithFormat:@"付款时间：%@",payTime];
}
-(void)setSendTime:(NSString *)sendTime{
    _sendLb.text = [NSString stringWithFormat:@"发货时间：%@",sendTime];
}


@end
