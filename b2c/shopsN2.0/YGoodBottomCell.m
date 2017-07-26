//
//  YGoodBottomCell.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodBottomCell.h"
#import "YGoodDetailChooseTypeView.h"
#import "YGoodDetailView.h"
#import "YGoodDetailSpecificationView.h"
#import "YGoodDetailsAppraiseView.h"
//#import "YGoodDetailConsultView.h"

@interface YGoodBottomCell()<YGoodDetailChooseTypeViewDelegate,YGoodDetailViewDelegate,YGoodDetailSpecificationViewDelegate,YGoodDetailsAppraiseViewDelegate>

@property (strong,nonatomic) YGoodDetailChooseTypeView *typeV;

//图文详情
@property (strong,nonatomic) YGoodDetailView *deatilVew;
//规格参数
@property (strong,nonatomic) YGoodDetailSpecificationView *specificationView;
//商品评价
@property (strong,nonatomic) YGoodDetailsAppraiseView *apppraiseView;

@end

@implementation YGoodBottomCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}


-(void)initView{

    [self addSubview:self.typeV];

    [self addSubview:self.baseV];

    [_baseV addSubview:self.deatilVew];
    
    [_baseV addSubview:self.specificationView];
    _specificationView.hidden =YES;

    [_baseV addSubview:self.apppraiseView];
    _apppraiseView.hidden = YES;


}

#pragma mark ==懒加载==
-(YGoodDetailChooseTypeView *)typeV{
    if (!_typeV) {
        _typeV = [[YGoodDetailChooseTypeView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 38)];
        _typeV.delegate = self;
    }
    return _typeV;
}

-(UIScrollView *)baseV{
    if (!_baseV) {
        _baseV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectYH(_typeV), __kWidth, __kHeight-64-50-38)];
        _baseV.backgroundColor = __BackColor;
        _baseV.scrollEnabled = NO;
        _baseV.contentSize = CGSizeMake(0, __kHeight-64-50-38);
    }
    return _baseV;
}

-(YGoodDetailView *)deatilVew{
    if (!_deatilVew) {
        _deatilVew = [[YGoodDetailView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-64-50-38)];
        _deatilVew.delegate =self;
    }
    return _deatilVew;
}

-(YGoodDetailSpecificationView *)specificationView{
    if (!_specificationView) {
        _specificationView = [[YGoodDetailSpecificationView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-64-50-38)];
        _specificationView.delegate = self;
    }
    return _specificationView;
}

-(YGoodDetailsAppraiseView *)apppraiseView{
    if (!_apppraiseView) {
        _apppraiseView = [[YGoodDetailsAppraiseView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight-64-50-38)];
        _apppraiseView.delegate = self;
    }
    return _apppraiseView;
}


-(void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
    _deatilVew.goodId = goodID;
    _apppraiseView.goodID = goodID;
    _specificationView.goodID = goodID;


}


#pragma mark ==YGoodDetailViewDelegate==
-(void)getGoodHead{
    [self.delegate getHeadFresh];
}
#pragma mark ==YGoodDetailSpecificationViewDelegate==
-(void)getFresh{
    [self.delegate getHeadFresh];
}
#pragma mark ==YGoodDetailsAppraiseViewDelegate==
-(void)getGoodBack{
    [self.delegate getHeadFresh];
}

//#pragma mark ==YGoodDetailConsultViewDelegate==
//-(void)putGoodQurstion:(NSString *)text{
//    [self.delegate putQuestions:text];
//}

-(void)gotoHead{
    [self.delegate getHeadFresh];
}


#pragma mark ==YGoodDetailChooseTypeViewDelegate==
-(void)chooseDetailView:(NSInteger)sender{
    switch (sender) {
        case 0:
        {
            _deatilVew.hidden = NO;
            _specificationView.hidden = YES;
            _apppraiseView.hidden = YES;
//            _consultView.hidden = YES;
        }
            break;
        case 1:
        {
            _deatilVew.hidden = YES;
            _specificationView.hidden = NO;
            _apppraiseView.hidden = YES;
//            _consultView.hidden = YES;
        }
            break;
        case 2:
        {
            _deatilVew.hidden = YES;
            _specificationView.hidden = YES;
            _apppraiseView.hidden = NO;
//            _consultView.hidden = YES;
        }
            break;
//        case 3:{
//            _deatilVew.hidden = YES;
//            _specificationView.hidden = YES;
//            _apppraiseView.hidden = YES;
//            _consultView.hidden = NO;
//        }
//            break;
        default:
            break;
    }
    [self.delegate chooseType:sender];
}


@end
