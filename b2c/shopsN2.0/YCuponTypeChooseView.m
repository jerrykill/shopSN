//
//  YCuponTypeChooseView.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YCuponTypeChooseView.h"

@interface YCuponTypeChooseView ()

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YCuponTypeChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _btnArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleArr = @[@"未使用",@"已使用",@"已过期"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*__kWidth/3, 0, (__kWidth-2)/3, 45)];
        [self addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = MFont(13);
        [btn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnNormal];
        [btn setTitleColor:__DefaultColor forState:BtnStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:BtnTouchUpInside];
        if (!i) {
            btn.selected = YES;
            btn.userInteractionEnabled =NO;
        }
        [btn setTitle:_titleArr[i] forState:BtnNormal];
        [btn setTitle:_titleArr[i] forState:BtnStateSelected];
        [_btnArr addObject:btn];
    }
}

-(void)chooseType:(UIButton*)sender{
    for (UIButton*btn in _btnArr) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.userInteractionEnabled = YES;
        }
    }
    [self.delegate chooseCuponType:sender.tag];
}

//-(void)setTitleArr:(NSArray *)titleArr{
//    _titleArr = titleArr;
//    for (int i=0; i<_btnArr.count; i++) {
//        UIButton *btn = _btnArr[i];
//        NSString *title;
//        if (i==0) {
//            title = [NSString stringWithFormat:@"未使用",_titleArr[0]];
//        }else if (i==1){
//            title = [NSString stringWithFormat:@"已使用",_titleArr[1]];
//        }else{
//            title = [NSString stringWithFormat:@"已过期",_titleArr[2]];
//        }
//        [btn setTitle:title forState:BtnNormal];
//        [btn setTitle:title forState:BtnStateSelected];
//    }
//
//}

@end
