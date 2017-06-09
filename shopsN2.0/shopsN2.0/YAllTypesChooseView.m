//
//  YAllTypesChooseView.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YAllTypesChooseView.h"
#import "YOrderTypeButton.h"


@interface YAllTypesChooseView ()

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YAllTypesChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.scrollV];
}

#pragma mark ==懒加载==
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 48)];
        _scrollV.backgroundColor = [UIColor whiteColor];
        _scrollV.pagingEnabled = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}



-(void)setTypeArr:(NSArray *)typeArr{
    _typeArr = typeArr;
    _btnArr = [NSMutableArray array];
    for (int i=0; i<_typeArr.count; i++) {
        YOrderTypeButton *btn = [[YOrderTypeButton alloc]initWithFrame:CGRectMake(i*90, 0, 90, 46)];
        [_scrollV addSubview:btn];
        btn.tag = i;
        [btn setTitle:typeArr[i] forState:BtnNormal];
        [btn setTitle:typeArr[i] forState:BtnStateSelected];
        [_btnArr addObject:btn];
        if (!i) {
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
        }
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:BtnTouchUpInside];
    }
    _scrollV.contentSize = CGSizeMake(90*_typeArr.count, 0);

}

-(void)chooseType:(UIButton*)sender{
    sender.selected = !sender.selected;
    for (YOrderTypeButton *btn in _btnArr) {
        if (btn.tag==sender.tag) {
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.colorIV.backgroundColor = [UIColor whiteColor];
            btn.userInteractionEnabled = YES;
        }
    }
    [self.delegate chooseOrderType:sender.tag];
}


@end
