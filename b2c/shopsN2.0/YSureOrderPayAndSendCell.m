//
//  YSureOrderPayAndSendCell.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSureOrderPayAndSendCell.h"

@interface YSureOrderPayAndSendCell()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *payTypeLb;

@property (strong,nonatomic) UILabel *sendTypeLb;


@end

@implementation YSureOrderPayAndSendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 60, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(119, 119, 119);
    _titleLb.font = MFont(13);
    _titleLb.text = @"支付配送";

    _payTypeLb =[[UILabel alloc]initWithFrame:CGRectMake(__kWidth-150, 15, 123, 15)];
    [self addSubview:_payTypeLb];
    _payTypeLb.textAlignment = NSTextAlignmentRight;
    _payTypeLb.textColor = __DTextColor;
    _payTypeLb.font = MFont(13);


    _sendTypeLb = [[UILabel alloc]initWithFrame:CGRectMake(__kWidth-150, CGRectYH(_payTypeLb)+10, 123, 15)];
    [self addSubview:_sendTypeLb];
    _sendTypeLb.textAlignment = NSTextAlignmentRight;
    _sendTypeLb.textColor = __DTextColor;
    _sendTypeLb.font = MFont(13);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 69, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;
}

-(void)setPayType:(NSString *)payType{
    _payTypeLb.text = payType;
}

-(void)setSendType:(NSString *)sendType{
    _sendTypeLb.text = sendType;
}

@end
