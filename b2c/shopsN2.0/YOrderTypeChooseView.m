//
//  YOrderTypeChooseView.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderTypeChooseView.h"
#import "YOrderTypeButton.h"
@interface YOrderTypeChooseView()

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YOrderTypeChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 46)];
    [self addSubview:_scrollV];
    _scrollV.backgroundColor = [UIColor whiteColor];
    _scrollV.pagingEnabled = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.contentSize = CGSizeMake(630, 0);
    
    NSArray *titleArr = @[@"全部",@"待付款",@"待处理",@"已发货",@"待评价",@"已取消",@"已完成"];
    _btnArr = [NSMutableArray array];
    for (int i=0; i<7; i++) {
        YOrderTypeButton *btn = [[YOrderTypeButton alloc]initWithFrame:CGRectMake(i*90, 0, 90, 46)];
        [_scrollV addSubview:btn];
        btn.tag = i;
        [btn setTitle:titleArr[i] forState:BtnNormal];
        [btn setTitle:titleArr[i] forState:BtnStateSelected];
        [_btnArr addObject:btn];
        if (!i) {
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
        }
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:BtnTouchUpInside];
    }
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


-(void)setSelectIndex:(NSInteger)selectIndex{
    for (YOrderTypeButton *btn in _btnArr) {
        if (btn.tag==selectIndex) {
            btn.selected = YES;
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.colorIV.backgroundColor = [UIColor whiteColor];
            btn.userInteractionEnabled = YES;
        }
    }
    if (selectIndex>2&&selectIndex<5) {
        double width = 90*selectIndex-(__kWidth/2-45);
        _scrollV.contentOffset = CGPointMake(width, 0);
    }else if (selectIndex>=5){
        double width = 90*5-(__kWidth/2-45);
        _scrollV.contentOffset = CGPointMake(width, 0);
    }else{
        _scrollV.contentOffset = CGPointMake(0, 0);
    }
    [self.delegate chooseOrderType:selectIndex];
}

@end
