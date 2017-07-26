//
//  YGoodAppraiseTypeView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodAppraiseTypeView.h"
#import "YGoodTypeView.h"

@interface YGoodAppraiseTypeView ()

@property (strong,nonatomic) NSMutableArray *btnArr;

@property (strong,nonatomic) NSArray *titleArr;

@end

@implementation YGoodAppraiseTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _btnArr = [NSMutableArray array];
    }
    return self;
}

-(void)setNumArr:(NSArray *)numArr{
    for (id obj in self.subviews) {
        [obj removeFromSuperview];
    }
    _numArr = numArr;
    _titleArr = @[@"全部评价",@"好评",@"中评",@"差评",@"有图"];
    for (int i=0; i<5; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseView:)];
        YGoodTypeView *typeV = [[YGoodTypeView alloc]initWithFrame:CGRectMake(i*(__kWidth/5), 0, __kWidth/5, 52)];
        [self addSubview:typeV];
        typeV.title = _titleArr[i];
        typeV.num = _numArr[i];
        typeV.tag = i+33;
        [typeV addGestureRecognizer:tap];
        if (!i) {
            typeV.bottomIV.backgroundColor = __DefaultColor;
        }
        [_btnArr addObject:typeV];
    }
}

-(void)chooseView:(UITapGestureRecognizer*)tap{
    for (YGoodTypeView*typeV in _btnArr) {
        if (typeV.tag == tap.view.tag) {
            typeV.bottomIV.backgroundColor =  __DefaultColor;
        }else{
            typeV.bottomIV.backgroundColor = [UIColor whiteColor];
        }
    }
    [self.delegate chooseAppraiseType:(tap.view.tag-33)];
}

@end
