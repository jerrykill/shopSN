//
//  YGoodDetailChooseTypeView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailChooseTypeView.h"
#import "YOrderTypeButton.h"

@interface YGoodDetailChooseTypeView()

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YGoodDetailChooseTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _btnArr = [NSMutableArray array];
    NSArray *titleArr = @[@"图文详情",@"规格参数",@"商品评论"];
    for (int i=0; i<titleArr.count; i++) {
        YOrderTypeButton  *btn =[[YOrderTypeButton alloc]initWithFrame:CGRectMake(__kWidth/3*i, 0, __kWidth/3, 38)];
        [self addSubview:btn];
        btn.tag = i;
        btn.titleLabel.font = MFont(13);
        [btn setTitleColor:__DTextColor forState:BtnNormal];
        [btn setTitleColor:__DTextColor forState:BtnStateSelected];
        [btn setTitle:titleArr[i] forState:BtnNormal];
        [btn setTitle:titleArr[i] forState:BtnStateSelected];
        [_btnArr addObject:btn];
        if (!i) {
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.selected = YES;
            btn.titleLabel.font =MFont(15);
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
            btn.titleLabel.font = MFont(15);
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.titleLabel.font = MFont(13);
            btn.colorIV.backgroundColor = [UIColor whiteColor];
            btn.userInteractionEnabled = YES;
        }
    }
    [self.delegate chooseDetailView:sender.tag];
}


-(void)setSelectIndex:(NSInteger)selectIndex{
    for (YOrderTypeButton *btn in _btnArr) {
        if (btn.tag==selectIndex) {
            btn.colorIV.backgroundColor = __DefaultColor;
            btn.titleLabel.font = MFont(15);
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.titleLabel.font = MFont(13);
            btn.colorIV.backgroundColor = [UIColor whiteColor];
            btn.userInteractionEnabled = YES;
        }
    }

}


@end
