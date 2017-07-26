//
//  YGoodDetailBottomActionView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailBottomActionView.h"
#import "YSPTButton.h"

@interface YGoodDetailBottomActionView()

@property (strong,nonatomic) YSPTButton *collectBtn;

@property (strong,nonatomic) UIButton *addShopBtn;

@property (strong,nonatomic) UIButton *payBtn;

@end

@implementation YGoodDetailBottomActionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.collectBtn];
    [self addSubview:self.addShopBtn];
    [self addSubview:self.payBtn];
}

-(void)chooseAction:(UIButton*)sender{
    if (sender.tag==21) {
        sender.selected = !sender.selected;
        [self.delegate chooseGoodAction:sender.tag-21 isCollect:sender.selected];
    }else{
        [self.delegate chooseGoodAction:sender.tag-21 isCollect:YES];
    }

}

-(void)setIsCollect:(BOOL)isCollect{
    _isCollect = isCollect;
    if (_isCollect) {
        _collectBtn.selected = YES;
    }else{
        _collectBtn.selected = NO;
    }
}

#pragma mark ==懒加载==
-(YSPTButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [[YSPTButton alloc]initWithFrame:CGRectMake(0, 0, __kWidth/3, 50)];
        _collectBtn.tag = 21;
        [_collectBtn  setTitle:@"收藏" forState:BtnNormal];
        [_collectBtn setTitle:@"收藏" forState:BtnStateSelected];
        [_collectBtn setImage:MImage(@"collect") forState:BtnNormal];
        [_collectBtn setImage:MImage(@"collected") forState:BtnStateSelected];
        [_collectBtn addTarget:self action:@selector(chooseAction:) forControlEvents:BtnTouchUpInside];
    }
    return _collectBtn;
}


-(UIButton *)addShopBtn{
    if (!_addShopBtn) {
        _addShopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_collectBtn), 0, __kWidth/3, 50)];
        _addShopBtn.tag = 22;
        _addShopBtn.titleLabel.font = MFont(16);
        _addShopBtn.backgroundColor = LH_RGBCOLOR(255, 114, 0);
        [_addShopBtn setTitle:@"加入购物车" forState:BtnNormal];
        [_addShopBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_addShopBtn addTarget:self action:@selector(chooseAction:) forControlEvents:BtnTouchUpInside];
    }
    return _addShopBtn;
}

-(UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_addShopBtn), 0, __kWidth/3, 50)];
        _payBtn.tag = 23;
        _payBtn.titleLabel.font = MFont(16);
        _payBtn.backgroundColor = __DefaultColor;
        [_payBtn setTitle:@"立即购买" forState:BtnNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:BtnNormal];
        [_payBtn addTarget:self action:@selector(chooseAction:) forControlEvents:BtnTouchUpInside];
    }
    return _payBtn;
}

@end
