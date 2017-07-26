//
//  YSCLassLeftView.m
//  shopsN
//
//  Created by imac on 2017/4/28.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSCLassLeftView.h"
#import "YCLassButton.h"

@interface YSCLassLeftView ()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YSCLassLeftView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        [self addSubview:self.scrollV];
        _btnArr = [NSMutableArray array];
    }
    return self;
}

#pragma mark ==懒加载==
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth*180/750, __kHeight-114)];
        _scrollV.pagingEnabled = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}

- (void)setDataArr:(NSArray<YCLassModel *> *)dataArr{
    _dataArr = dataArr;
    [_btnArr removeAllObjects];
    for (int i=0; i<_dataArr.count; i++) {
        YCLassModel *model = _dataArr[i];
        YCLassButton *btn =[[YCLassButton alloc]initWithFrame:CGRectMake(0, i*__kWidth*100/750, 180*__kWidth/750, __kWidth*100/750)];
        [btn setTitle:model.className forState:BtnNormal];
        [btn setTitle:model.className forState:BtnStateSelected];
        btn.tag =i;
        if (!i) {
            btn.selected = YES;
            btn.lineIV.backgroundColor =__DefaultColor;
            btn.backgroundColor = __BackColor;
        }
        [self.scrollV addSubview:btn];
        [btn addTarget:self action:@selector(chooseClass:) forControlEvents:BtnTouchUpInside];
        [_btnArr addObject:btn];
    }
    self.scrollV.contentSize = CGSizeMake(180*__kWidth/750, _dataArr.count*__kWidth*100/750);

}

- (void)chooseClass:(YCLassButton*)sender {
    NSInteger i =sender.tag;
    YCLassModel *model = _dataArr[i];
    [self.delegate chooseClassOne:model.classId];
    for (YCLassButton *button in _btnArr) {
        if (button.tag == i) {
            button.selected = YES;
            button.backgroundColor = __BackColor;
            button.lineIV.backgroundColor = __DefaultColor;
        }else{
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
            button.lineIV.backgroundColor = [UIColor whiteColor];
        }
    }

}

@end
