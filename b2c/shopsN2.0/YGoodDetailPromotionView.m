//
//  YGoodDetailPromotionView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailPromotionView.h"

@interface YGoodDetailPromotionView()

@property (strong,nonatomic) UILabel *headLb;

@end

@implementation YGoodDetailPromotionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark ==懒加载==
-(UILabel *)headLb{
    if (!_headLb) {
        _headLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 30, 15)];
        _headLb.textColor = LH_RGBCOLOR(119, 119, 119);
        _headLb.font = MFont(13);
        _headLb.textAlignment=  NSTextAlignmentLeft;
        _headLb.text = @"促销";
    }
    return _headLb;
}


-(void)setData:(NSMutableArray<YGoodActiveModel *> *)data{
    for (id obj in self.subviews) {
        [obj removeFromSuperview];
    }
    [self addSubview:self.headLb];
    
    _data =data;
    for (int i=0; i<_data.count-1; i++) {
        YGoodActiveModel *model = _data[i];
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(45, 8+30*i, 40, 14)];
        [self addSubview:titleBtn];
        titleBtn.backgroundColor = __DefaultColor;
        titleBtn.titleLabel.font = MFont(10);
        [titleBtn setTitle:model.title forState:BtnNormal];
        [titleBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];

        UILabel *detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(titleBtn)+9, 7+30*i, __kWidth-110, 15)];
        [self addSubview:detailLb];
        detailLb.textColor = __DTextColor;
        detailLb.font = MFont(13);
        detailLb.text = model.info;
        detailLb.textAlignment = NSTextAlignmentLeft;
    }
    YGoodActiveModel *model = _data.lastObject;
    UIButton *listBtn = [[UIButton alloc]initWithFrame:CGRectMake(45, 8+30*(_data.count-1), 40, 14)];
    [self addSubview:listBtn];
    listBtn.layer.cornerRadius =2;
    listBtn.layer.borderColor = __DefaultColor.CGColor;
    listBtn.titleLabel.font = MFont(10);
    listBtn.layer.borderWidth =1;
    [listBtn setTitle:model.title forState:BtnNormal];
    [listBtn setTitleColor:__DefaultColor forState:BtnNormal];

    UILabel *detailLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(listBtn)+9, 7+30*(_data.count-1), __kWidth-110, 15)];
    [self addSubview:detailLb];
    detailLb.textColor =__DTextColor;
    detailLb.font = MFont(13);
    detailLb.textAlignment = NSTextAlignmentLeft;
    detailLb.text = model.info;
}



@end
