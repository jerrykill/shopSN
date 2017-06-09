//
//  YConsRecordHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YConsRecordHeadView.h"

@interface YConsRecordHeadView ()

@property (strong,nonatomic) UIView *headV;

@property (strong,nonatomic) UILabel *dateLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UILabel *statusLb;

@end

@implementation YConsRecordHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headV];
    [_headV addSubview:self.dateLb];
    [_headV addSubview:self.detailLb];
    [_headV addSubview:self.numLb];
    [_headV addSubview:self.statusLb];

}

#pragma mark ==懒加载==
-(UIView *)headV{
    if (!_headV) {
        _headV = [[UIView alloc]initWithFrame:CGRectMake(10, 13, __kWidth-20, 30)];
        _headV.backgroundColor = __BackColor;
    }
    return _headV;
}

-(UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 6, 6*(__kWidth-20)/20, 15)];
        _dateLb.textAlignment = NSTextAlignmentCenter;
        _dateLb.textColor = LH_RGBCOLOR(102, 102, 102);
        _dateLb.font = MFont(12);
        _dateLb.text = @"补充耗材时间";
    }
    return _dateLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(6*(__kWidth-20)/20, 6, 6*(__kWidth-20)/20, 15)];
        _detailLb.textAlignment = NSTextAlignmentCenter;
        _detailLb.textColor = LH_RGBCOLOR(102, 102, 102);
        _detailLb.font = MFont(12);
        _detailLb.text = @"详情";
    }
    return _detailLb;
}

-(UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc]initWithFrame:CGRectMake(6*(__kWidth-20)/10, 6, 8*(__kWidth-20)/60, 15)];
        _numLb.textAlignment = NSTextAlignmentCenter;
        _numLb.textColor = LH_RGBCOLOR(102, 102, 102);
        _numLb.font = MFont(12);
        _numLb.text = @"数量";
    }
    return _numLb;
}

-(UILabel *)statusLb{
    if (!_statusLb) {
        _statusLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_numLb), 6, 8*(__kWidth-20)/30, 15)];
        _statusLb.textAlignment = NSTextAlignmentCenter;
        _statusLb.textColor = LH_RGBCOLOR(102, 102, 102);
        _statusLb.font = MFont(12);
        _statusLb.text = @"支付状态";
    }
    return _statusLb;
}

@end
