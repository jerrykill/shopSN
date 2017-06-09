//
//  YApplySalesSureCell.m
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YApplySalesSureCell.h"

@interface YApplySalesSureCell ()

@property (strong,nonatomic)  UIView *bottomV;

@property (strong,nonatomic) UIButton *applyBtn;

@end


@implementation YApplySalesSureCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.bottomV];
    [self addSubview:self.applyBtn];
}

#pragma mark ==懒加载==
-(UIView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 10)];
        _bottomV.backgroundColor = __BackColor;
    }
    return _bottomV;
}

-(UIButton *)applyBtn{
    if (!_applyBtn) {
        _applyBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 24, __kWidth-20, 45)];
        _applyBtn.backgroundColor = __DefaultColor;
        _applyBtn.layer.cornerRadius = 5;
        _applyBtn.titleLabel.font = MFont(16);
        [_applyBtn setTitle:@"确认申请" forState:BtnNormal];
        [_applyBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_applyBtn addTarget:self action:@selector(choose) forControlEvents:BtnTouchUpInside];
    }
    return _applyBtn;
}


-(void)choose{
    [self.delegate makeAppply];
}

@end
