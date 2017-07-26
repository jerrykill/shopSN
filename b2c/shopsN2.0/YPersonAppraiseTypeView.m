
//
//  YPersonAppraiseTypeView.m
//  shopsN
//
//  Created by imac on 2017/1/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonAppraiseTypeView.h"
#import "YAppraiseTypeBtnView.h"

@interface YPersonAppraiseTypeView ()

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YPersonAppraiseTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _btnArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    NSArray *titleArr = @[@"发布评价",@"有图评价"];
    for (int i=0; i<2; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooose:)];
        YAppraiseTypeBtnView *btnV = [[YAppraiseTypeBtnView alloc]initWithFrame:CGRectMake(i*(__kWidth-1)/2, 0, (__kWidth-1)/2, 60)];
        [self addSubview:btnV];
        btnV.tag = i;
        [btnV addGestureRecognizer:tap];
        btnV.type =titleArr[i];
        if (!i) {
            btnV.isHidden = NO;
            btnV.userInteractionEnabled = NO;
        }else{
            btnV.isHidden = YES;
        }
        [_btnArr addObject:btnV];
    }
}

-(void)chooose:(UITapGestureRecognizer*)tap{
    for (YAppraiseTypeBtnView *btnV in _btnArr) {
        if (btnV.tag == tap.view.tag) {
            btnV.isHidden = NO;
            btnV.userInteractionEnabled = NO;
        }else{
            btnV.isHidden = YES;
            btnV.userInteractionEnabled = YES;
        }
    }
    [self.delegate chooseView:tap.view.tag];
}

-(void)setCountArr:(NSArray *)countArr{
    _countArr = countArr;
    for (int i=0; i<_btnArr.count; i++) {
        YAppraiseTypeBtnView *btnV = _btnArr[i];
        btnV.count = _countArr[i];
    }
}

@end
