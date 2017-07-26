

//
//  YOrderEvaluteFootView.m
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderEvaluteFootView.h"

@interface YOrderEvaluteFootView()

@property (strong,nonatomic) NSMutableArray *btnArr;

@end

@implementation YOrderEvaluteFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _btnArr = [NSMutableArray array];
    NSArray *titleArr = @[@"好评",@"中评",@"差评"];
    NSArray *color =@[LH_RGBCOLOR(107, 198, 139),LH_RGBCOLOR(255, 153, 33),LH_RGBCOLOR(208, 17, 27)];
    NSArray *imageArr =@[@"comment_good",@"comment_mid",@"comment_bad"];
    NSArray *selectArr =@[@"comment_goods",@"comment_mids",@"comment_bads"];
    for (int i=0; i<3; i++) {
        UIButton *starBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*__kWidth/3, 0, __kWidth/3, 50)];
        [self addSubview:starBtn];
        starBtn.tag =i+33;
        starBtn.titleLabel.font = MFont(13);
        [starBtn setTitle:titleArr[i] forState:BtnNormal];
        [starBtn setTitleColor:LH_RGBCOLOR(202, 202, 202) forState:BtnNormal];
        [starBtn setTitle:titleArr[i] forState:BtnStateSelected];
        [starBtn setTitleColor:color[i] forState:BtnStateSelected];
        [starBtn setImage:MImage(imageArr[i]) forState:BtnNormal];
        [starBtn setImage:MImage(selectArr[i]) forState:BtnStateSelected];
        starBtn.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 0);
        starBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_btnArr addObject:starBtn];
        [starBtn addTarget:self action:@selector(chooseStar:) forControlEvents:BtnTouchUpInside];
    }

}

-(void)chooseStar:(UIButton*)sender{
    for (UIButton*btn in _btnArr) {
        if (btn.tag == sender.tag) {
            btn.selected = !btn.selected;
            btn.userInteractionEnabled = NO;
        }else{
            btn.selected = NO;
            btn.userInteractionEnabled = YES;
        }
    }

    [self.delegate chooseStar:36-sender.tag];
}


@end
