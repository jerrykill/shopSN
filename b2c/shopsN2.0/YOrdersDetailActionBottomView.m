//
//  YOrdersDetailActionBottomView.m
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrdersDetailActionBottomView.h"

@interface YOrdersDetailActionBottomView()

@property (strong,nonatomic) UIButton *payBtn;

@property (strong,nonatomic) UIButton *returnBtn;

@property (strong,nonatomic) UIButton *logisticsBtn;

@property (strong,nonatomic) UIButton *sureBtn;

@property (strong,nonatomic) UIButton *evaluteBtn;

@property (strong,nonatomic) UIButton *againBtn;

@property (strong,nonatomic) UIButton *cancelBtn;

@end

@implementation YOrdersDetailActionBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       self.backgroundColor = LH_RGBCOLOR(188, 188, 188);
    }
    return self;
}

-(void)setStatus:(NSString *)status{
    if ([status isEqualToString:@"待付款"]) {
        [self addSubview:self.payBtn];
        [self addSubview:self.cancelBtn];
    }else if ([status isEqualToString:@"待处理"]){
        [self addSubview:self.returnBtn];
    }else if ([status isEqualToString:@"已发货"]){
        [self addSubview:self.logisticsBtn];
        [self addSubview:self.sureBtn];
    }else if ([status isEqualToString:@"待评价"]){
        [self addSubview:self.logisticsBtn];
        _logisticsBtn.frame = CGRectMake(__kWidth-95, 8, 84, 24);
//        [self addSubview:self.evaluteBtn];
    }else{
        [self addSubview:self.againBtn];
    }
}

#pragma mark ==懒加载==
-(UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-95, 8, 84, 24)];
        _payBtn.tag = 101;
        _payBtn.layer.cornerRadius = 5;
        _payBtn.titleLabel.font = MFont(14);
        _payBtn.backgroundColor = __DefaultColor;
        [_payBtn setTitle:@"马上付款" forState:BtnNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_payBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _payBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-187, 8, 84, 24)];
        _cancelBtn.tag = 107;
        _cancelBtn.layer.cornerRadius = 5;
        _cancelBtn.titleLabel.font = MFont(14);
        _cancelBtn.backgroundColor = LH_RGBCOLOR(106, 106, 106);
        [_cancelBtn setTitle:@"取消订单" forState:BtnNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_cancelBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-95, 8, 84, 24)];
        _returnBtn.tag = 102;
        _returnBtn.layer.cornerRadius = 5;
        _returnBtn.titleLabel.font = MFont(14);
        _returnBtn.backgroundColor = __DefaultColor;
        [_returnBtn setTitle:@"申请退款" forState:BtnNormal];
        [_returnBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_returnBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _returnBtn;
}

-(UIButton *)logisticsBtn{
    if (!_logisticsBtn) {
        _logisticsBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-187, 8, 84, 24)];
        _logisticsBtn.tag = 103;
        _logisticsBtn.layer.cornerRadius =5;
        _logisticsBtn.titleLabel.font = MFont(14);
        _logisticsBtn.backgroundColor = LH_RGBCOLOR(106, 106, 106);
        [_logisticsBtn setTitle:@"查看物流" forState:BtnNormal];
        [_logisticsBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_logisticsBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _logisticsBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_logisticsBtn)+9, 8, 84, 24)];
        _sureBtn.tag = 104;
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.titleLabel.font = MFont(14);
        _sureBtn.backgroundColor = __DefaultColor;
        [_sureBtn setTitle:@"确认收货" forState:BtnNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_sureBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _sureBtn;
}

-(UIButton *)evaluteBtn{
    if (!_evaluteBtn) {
        _evaluteBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-95, 8, 84, 24)];
        _evaluteBtn.tag = 105;
        _evaluteBtn.layer.cornerRadius = 5;
        _evaluteBtn.titleLabel.font = MFont(14);
        _evaluteBtn.backgroundColor = __DefaultColor;
        [_evaluteBtn setTitle:@"马上评价" forState:BtnNormal];
        [_evaluteBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_evaluteBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _evaluteBtn;
}

-(UIButton *)againBtn{
    if (!_againBtn) {
        _againBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-95, 8, 84, 24)];
        _againBtn.tag = 106;
        _againBtn.layer.cornerRadius = 5;
        _againBtn.titleLabel.font = MFont(14);
        _againBtn.backgroundColor = __DefaultColor;
        [_againBtn setTitle:@"再次购买" forState:BtnNormal];
        [_againBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_againBtn addTarget:self action:@selector(orderAction:) forControlEvents:BtnTouchUpInside];
    }
    return _againBtn;
}

-(void)orderAction:(UIButton*)sender{
    [self.delegate OrderBottomAction:(sender.tag-101)];
}

@end
