//
//  YDeliveryDetailOneCell.m
//  shopsN
//
//  Created by imac on 2017/1/18.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YDeliveryDetailOneCell.h"

@interface YDeliveryDetailOneCell()

@property (strong,nonatomic) NSMutableArray *titleArr;

@end


@implementation YDeliveryDetailOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _titleArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    for (int i=0; i<6; i++) {
        UILabel  *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+35*i, __kWidth-50, 15)];
        [self addSubview:titleLb];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.font = MFont(13);
        titleLb.textColor = __DTextColor;
        titleLb.tag = i;
        [_titleArr addObject:titleLb];
    }
    for (int i=0; i<5; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 34+35*i, __kWidth-60, 1)];
        [self addSubview:lineIV];
        lineIV.backgroundColor = __BackColor;
    }

}

-(void)setModel:(YDeliveryModel *)model{
    _model = model;
    NSArray *listArr = @[[NSString stringWithFormat:@"订单号：%@",_model.orderNo],[NSString stringWithFormat:@"客户编号：%@",_model.payId],[NSString stringWithFormat:@"开票日期：%@",_model.billDate],[NSString stringWithFormat:@"销售单位:%@",_model.saleName],[NSString stringWithFormat:@"创建日期：%@",_model.creatDate],[NSString stringWithFormat:@"总金额：%@",_model.money]];
    for (UILabel *list in _titleArr) {
          NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:listArr[list.tag]];
        if (list.tag==0||list.tag==5) {
            [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 4)];
            [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(4, attr.length-4)];
        }else{
            [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
            [attr addAttribute:NSForegroundColorAttributeName value:__DTextColor range:NSMakeRange(5, attr.length-5)];
        }
        list.attributedText = attr;
    }
}

@end
