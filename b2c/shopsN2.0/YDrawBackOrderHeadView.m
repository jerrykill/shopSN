//
//  YDrawBackOrderHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YDrawBackOrderHeadView.h"

@interface YDrawBackOrderHeadView()

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) UILabel *detailLb;

@end

@implementation YDrawBackOrderHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        [self initView];
    }
    return self;
}

-(void)initView{
     [self addSubview:self.titleLb];
     [self addSubview:self.detailLb];


    UIImageView *bottomIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 65, __kWidth-20, 1)];
    [self addSubview:bottomIV];
    bottomIV.backgroundColor = __BackColor;

}

#pragma mark ==懒加载==
-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, __kWidth-20, 15)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(13);
        _titleLb.textColor = __DTextColor;
    }
    return _titleLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_titleLb)+15, __kWidth-20, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(117, 117, 117);
        _detailLb.font = MFont(13);
    }
    return _detailLb;
}


-(void)setOrderId:(NSString *)orderId{
    _titleLb.text = [NSString stringWithFormat:@"订单编号：%@",orderId];
}

-(void)setOrderTime:(NSString *)orderTime{
    NSDate *times =[NSDate dateWithTimeIntervalSince1970:[orderTime integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    _detailLb.text = [NSString stringWithFormat:@"下单时间：%@",[dateFormatter stringFromDate:times]];
}

@end
