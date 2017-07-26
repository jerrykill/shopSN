//
//  YGiftGoodDetailView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftGoodDetailView.h"

@interface YGiftGoodDetailView ()

@property (strong,nonatomic) UILabel *goodLb;

@property (strong,nonatomic) UILabel *detailLb;


@end

@implementation YGiftGoodDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.goodLb];

    [self addSubview:self.detailLb];

}

#pragma mark ==懒加载==
-(UILabel *)goodLb{
    if (!_goodLb) {
        _goodLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 15)];
        _goodLb.textAlignment = NSTextAlignmentLeft;
        _goodLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _goodLb.font = MFont(13);
        _goodLb.text = @"商品";
    }
    return _goodLb;
}

-(UILabel *)detailLb{
    if (!_detailLb) {
        _detailLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_goodLb)+5, 60, 15)];
        _detailLb.textAlignment = NSTextAlignmentLeft;
        _detailLb.textColor = LH_RGBCOLOR(153, 153, 153);
        _detailLb.font = MFont(13);
        _detailLb.text = @"描述";
    }
    return _detailLb;
}

-(void)setModel:(YGiftGoodModel *)model{
    _model = model;
//    NSArray *titleArr = @[@"品牌：",@"型号：",@"基本单位：",@"产品包装：",@"产品规格："];
//    NSArray *detailArr = @[_model.brand,_model.model,_model.unit,_model.way,_model.goodSize];
    for (int i=0; i<_model.list.count+1; i++) {
        YGiftGoodSpecModel *dic = [[YGiftGoodSpecModel alloc]init];
        if (i==0) {
            dic.item = model.brand;
            dic.name = @"品牌";
        }else{
            dic = _model.list[i-1];
        }
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(70,5+20*i, __kWidth-90, 15)];
        [self addSubview:titleLb];
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.textColor = __DTextColor;
        titleLb.font = MFont(13);
        titleLb.text = [NSString stringWithFormat:@"%@:%@",dic.name,dic.item];

    }
  

}

@end
