//
//  YBillDetailCell.m
//  shopsN
//
//  Created by imac on 2017/1/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBillDetailCell.h"

@interface YBillDetailCell()

@property (strong,nonatomic) NSMutableArray *titleArr;

@end

@implementation YBillDetailCell

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
    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 10)];
    [self addSubview:headIV];
    headIV.backgroundColor = __BackColor;

    for (int i=0; i<3; i++) {
        UILabel  *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+35*i, __kWidth-50, 15)];
        [self addSubview:titleLb];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.font = MFont(13);
        titleLb.textColor = __DTextColor;
        titleLb.tag = i;
        [_titleArr addObject:titleLb];
    }

    for (int i=3; i<7; i++) {
        UILabel  *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10+((i-3)%2)*__kWidth/2, 20+35*3+35*((i-3)/2), __kWidth/2-20, 15)];
        [self addSubview:titleLb];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.font = MFont(13);
        titleLb.textColor = __DTextColor;
        titleLb.tag = i;
        [_titleArr addObject:titleLb];
    }

    for (int i=0; i<5; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 34+35*i+10, __kWidth-60, 1)];
        [self addSubview:lineIV];
        lineIV.backgroundColor = __BackColor;
    }

}

-(void)setModel:(YBillGoodModel *)model{
    _model = model;
    NSArray *listArr = @[[NSString stringWithFormat:@"商品编号：%@",_model.goodId],[NSString stringWithFormat:@"商品名称：%@",_model.name],[NSString stringWithFormat:@"规格型号：%@",_model.size],[NSString stringWithFormat:@"单位：      %@",_model.units],[NSString stringWithFormat:@"数量：  %@",_model.num],[NSString stringWithFormat:@"单价：      %@",_model.price],[NSString stringWithFormat:@"金额：  %@",_model.total]];
    for (UILabel*list in _titleArr) {
        list.text = listArr[list.tag];
    }

}

@end
