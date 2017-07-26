//
//  YSendTimeAreaChooseView.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSendTimeAreaChooseView.h"
#import "YSendTimeView.h"

@interface YSendTimeAreaChooseView()

@property (strong,nonatomic) NSMutableArray *chooseArr;

@property (strong,nonatomic) YSendTimeView *firstV;

@property (strong,nonatomic) YSendTimeView *secondV;

@end

@implementation YSendTimeAreaChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _chooseArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)];
    _firstV = [[YSendTimeView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    [self addSubview:_firstV];
    _firstV.tag = 301;
    _firstV.title = @"0:00~14:00";
    [_chooseArr addObject:_firstV];
    [_firstV addGestureRecognizer:tap];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose:)];
    _secondV = [[YSendTimeView alloc]initWithFrame:CGRectMake(0, 40, 200, 40)];
    [self addSubview:_secondV];
    _secondV.tag = 302;
    _secondV.title = @"14:00~24:00";
    [_chooseArr addObject:_secondV];
    [_secondV addGestureRecognizer:tap1];

}

-(void)choose:(UITapGestureRecognizer *)tap{
    for (YSendTimeView *chooseV in _chooseArr) {
        if (chooseV.tag == tap.view.tag) {
            chooseV.isSelected = YES;
            chooseV.userInteractionEnabled = NO;
            [self.delegate chooseSendTime:chooseV.title];
        }else{
            chooseV.isSelected = NO;
            chooseV.userInteractionEnabled = YES;
        }
    }
}

@end
