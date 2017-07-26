//
//  YGoodsFilterView.m
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodsFilterView.h"

@interface YGoodsFilterView()
//销量
@property (strong,nonatomic) UIButton *salesBtn;
//价格
@property (strong,nonatomic) UIButton *priceBtn;
//新品
@property (strong,nonatomic) UIButton *nowBtn;

@end

@implementation YGoodsFilterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _salesBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (self.frame.size.width-2)/3, self.frame.size.height-1)];
    [self addSubview:_salesBtn];
    _salesBtn.backgroundColor = [UIColor whiteColor];
    _salesBtn.titleLabel.font = MFont(15);
    _salesBtn.tag = 22;
    [_salesBtn setTitle:@"销量" forState:BtnNormal];
    [_salesBtn setTitleColor:__TextColor forState:BtnNormal];
    [_salesBtn setTitle:@"销量" forState:BtnStateSelected];
    [_salesBtn setTitleColor:__DefaultColor forState:BtnStateSelected];
    [_salesBtn addTarget:self action:@selector(fileter:) forControlEvents:BtnTouchUpInside];

    _priceBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_salesBtn)+1, 0, (self.frame.size.width-2)/3, self.frame.size.height-1)];
    [self addSubview:_priceBtn];
    _priceBtn.backgroundColor = [UIColor whiteColor];
    _priceBtn.titleLabel.font = MFont(15);
    _priceBtn.tag = 23;
    [_priceBtn setTitle:@"价格" forState:BtnNormal];
    [_priceBtn setTitleColor:__TextColor forState:BtnNormal];
    [_priceBtn setTitle:@"价格" forState:BtnStateSelected];
    [_priceBtn setTitleColor:__DefaultColor forState:BtnStateSelected];
    [_priceBtn setImage:MImage(@"ico1") forState:BtnNormal];
    _priceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (__kWidth-2)/6+3, 0, 0);
    [_priceBtn addTarget:self action:@selector(fileter:) forControlEvents:BtnTouchUpInside];

    _nowBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_priceBtn)+1, 0, (self.frame.size.width-2)/3, self.frame.size.height-1)];
    [self addSubview:_nowBtn];
    _nowBtn.backgroundColor = [UIColor whiteColor];
    _nowBtn.titleLabel.font = MFont(15);
    _nowBtn.tag = 25;
    [_nowBtn setTitle:@"人气" forState:BtnNormal];
    [_nowBtn setTitleColor:__TextColor forState:BtnNormal];
    [_nowBtn setTitle:@"人气" forState:BtnStateSelected];
    [_nowBtn setTitleColor:__DefaultColor forState:BtnStateSelected];
    [_nowBtn addTarget:self action:@selector(fileter:) forControlEvents:BtnTouchUpInside];


    for (int i=0; i<2; i++) {
        UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectXW(_salesBtn)+(self.frame.size.width+1)*i/3, 7.5, 1, self.frame.size.height-15)];
        [self addSubview:lineIV];
        lineIV.backgroundColor = __BackColor;
    }

    UIImageView *booIV = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectYH(_salesBtn) , self.frame.size.width, 1)];
    [self addSubview:booIV];
    booIV.backgroundColor = __BackColor;


}

-(void)fileter:(UIButton*)sender{
    [self.delegate chooseType:(sender.tag-22)];
    switch (sender.tag-22) {
        case 0:{
            sender.selected = !sender.selected;
            _nowBtn.selected = NO;
            _nowBtn.userInteractionEnabled = YES;
            _priceBtn.selected = NO;
            _priceBtn.tag = 23;
            sender.userInteractionEnabled = NO;
        }
            break;
        case 1:{
            if (!sender.isSelected) {
                sender.selected = !sender.selected;
            }
            _salesBtn.selected = NO;
            _salesBtn.userInteractionEnabled = YES;
            _nowBtn.selected = NO;
            _nowBtn.userInteractionEnabled = YES;
            [_priceBtn setImage:MImage(@"ico2") forState:BtnStateSelected];
            sender.tag +=1;
        }
            break;
        case 2:{
            sender.tag -=1;
            _salesBtn.selected = NO;
            _salesBtn.userInteractionEnabled = YES;
            _nowBtn.selected = NO;
            _nowBtn.userInteractionEnabled = YES;
             [_priceBtn setImage:MImage(@"ico3") forState:BtnStateSelected];
        }
            break;
        case 3:{
            sender.selected = !sender.selected;
            _salesBtn.selected = NO;
            _salesBtn.userInteractionEnabled = YES;
            _priceBtn.selected = NO;
            _priceBtn.tag = 23;
            sender.userInteractionEnabled = NO;
        }
        default:
            break;
    }

}

@end
