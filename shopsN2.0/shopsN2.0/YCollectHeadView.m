//
//  YCollectHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/31.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCollectHeadView.h"

@interface YCollectHeadView ()
{
    CGRect _frame;
}

@property (strong,nonatomic) NSMutableArray *btnArr;

@property (strong,nonatomic) UIScrollView *scrollV;

@end

@implementation YCollectHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _frame = frame;
        _btnArr = [NSMutableArray array];
        [self addSubview:self.scrollV];
    }
    return self;
}

#pragma mark ==懒加载==
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        _scrollV.contentSize = _frame.size;
        _scrollV.pagingEnabled = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}

-(void)setDataArr:(NSMutableArray<YGoodClassModel *> *)dataArr{
    _dataArr = dataArr;
    for (int i=0; i<_dataArr.count; i++) {
        YGoodClassModel *model = _dataArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5+95*i, 10, 84, 28)];
        [_scrollV addSubview:btn];
        btn.tag = i;
        btn.backgroundColor = __BackColor;
        btn.layer.cornerRadius = 8;
        btn.titleLabel.font = MFont(12);
        [btn setTitle:model.classTitle forState:BtnNormal];
        [btn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnNormal];
        [btn setTitle:model.classTitle forState:BtnStateSelected];
        [btn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnStateSelected];
        [btn addTarget:self action:@selector(choose:) forControlEvents:BtnTouchUpInside];
//        if (!i) {
//            btn.backgroundColor = [UIColor whiteColor];
//            btn.selected = YES;
//            btn.layer.borderColor = LH_RGBCOLOR(255, 114, 0).CGColor;
//            btn.layer.borderWidth = 1;
//        }
        [_btnArr addObject:btn];
    }
    _scrollV.contentSize = CGSizeMake(95*_dataArr.count, 0);
}


-(void)choose:(UIButton*)sender{
    for (UIButton *btn in _btnArr) {
        if (btn.tag == sender.tag) {
            btn.backgroundColor = [UIColor whiteColor];
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
            btn.layer.borderColor = LH_RGBCOLOR(255, 114, 0).CGColor;
            btn.layer.borderWidth = 1;
        }else{
            btn.backgroundColor = __BackColor;
            btn.selected =NO;
            btn.userInteractionEnabled = YES;
            btn.layer.borderWidth =0;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
    [self.delegate getCollectType:_dataArr[sender.tag]];
}

@end
