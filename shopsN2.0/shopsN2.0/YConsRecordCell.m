//
//  YConsRecordCell.m
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YConsRecordCell.h"

@interface YConsRecordCell ()

@property (strong,nonatomic) UILabel *dateLb;

@property (strong,nonatomic) UILabel *detailLb;

@property (strong,nonatomic) UILabel *numLb;

@property (strong,nonatomic) UILabel *statusLb;

@property (strong,nonatomic) UIImageView *lineIV;

@end

@implementation YConsRecordCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;

}

-(void)initView{
    [self addSubview:self.dateLb];
    [self addSubview:self.detailLb];
    [self addSubview:self.numLb];
    [self addSubview:self.statusLb];
    [self addSubview:self.lineIV];
}

#pragma mark ==懒加载==
-(UILabel *)dateLb{
    if (!_dateLb) {
        _dateLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 6*(__kWidth-20)/20, 15)];
        _dateLb.textAlignment = NSTextAlignmentCenter;
        _dateLb.textColor = __DTextColor;
        _dateLb.font = MFont(12);
    }
    return _dateLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(6*(__kWidth-20)/20, 18, 6*(__kWidth-20)/20, 15)];
        _detailLb.textAlignment = NSTextAlignmentCenter;
        _detailLb.textColor = __DTextColor;
        _detailLb.font = MFont(12);
    }
    return _detailLb;
}

-(UILabel *)numLb{
    if (!_numLb) {
        _numLb = [[UILabel alloc]initWithFrame:CGRectMake(6*(__kWidth-20)/10+5, 18, 8*(__kWidth-20)/60, 15)];
        _numLb.textAlignment = NSTextAlignmentCenter;
        _numLb.textColor = __DTextColor;
        _numLb.font = MFont(12);
    }
    return _numLb;
}

-(UILabel *)statusLb{
    if (!_statusLb) {
        _statusLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_numLb), 18, 8*(__kWidth-20)/30, 15)];
        _statusLb.textAlignment = NSTextAlignmentCenter;
        _statusLb.textColor = __DTextColor;
        _statusLb.font = MFont(12);
    }
    return _statusLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, __kWidth, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(void)setModel:(YConsModel *)model{
    _model = model;
    _dateLb.text = _model.date;
    _numLb.text = _model.num;
    _detailLb.text = _model.title;
    if ([_model.status isEqualToString:@"配送中"]) {
        _statusLb.textColor = __DefaultColor;
    }
    _statusLb.text = _model.status;
}


@end
