//
//  YServiceAskCell.m
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceAskCell.h"

@interface YServiceAskCell()

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YServiceAskCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.backV];
    [_backV addSubview:self.titleLb];

}

#pragma mark ==懒加载==
-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 82, 82)];
    }
    return _backV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(24, 21, 34, 40)];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.font = MFont(16);
        _titleLb.numberOfLines = 2;
    }
    return _titleLb;
}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
    if (self.tag%3==0) {
        _backV.backgroundColor = LH_RGBCOLOR(253, 231, 232);
        _titleLb.textColor = LH_RGBCOLOR(186, 76, 82);
    }else if (self.tag%3==1){
        _backV.backgroundColor = LH_RGBCOLOR(253, 248, 231);
        _titleLb.textColor =  LH_RGBCOLOR(179, 136, 53);
    }else{
        _backV.backgroundColor = LH_RGBCOLOR(232, 250, 255);
        _titleLb.textColor = LH_RGBCOLOR(59, 125, 143);
    }
}
- (void)setTitleArr:(NSArray<YServiceTitleModel *> *)titleArr{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }
    _titleArr = titleArr;
    for (int i=0; i<_titleArr.count; i++) {
        YServiceTitleModel *model = _titleArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_backV)+((__kWidth-103)/2+1)*(i%2), 10+41*(i/2), (__kWidth-103)/2, 40)];
        [self addSubview:btn];
        btn.titleLabel.font = MFont(13);
        [btn setTitle:model.titleName forState:BtnNormal];
        [btn setTitleColor:__TextColor forState:BtnNormal];
        btn.tag = i+33;
        [btn addTarget:self action:@selector(chooseDetail:) forControlEvents:BtnTouchUpInside];
    }
}

-(void)chooseDetail:(UIButton*)sender{
    [self.delegate getQuestion:self.tag index:(sender.tag-33)];
}

@end
