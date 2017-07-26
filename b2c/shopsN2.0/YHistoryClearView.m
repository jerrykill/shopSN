 //
//  YHistoryClearView.m
//  shopsN
//
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YHistoryClearView.h"

@interface YHistoryClearView()

@property (strong,nonatomic) UIButton *clearBtn;

@end

@implementation YHistoryClearView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 11, __kWidth-20, 38)];
    [self addSubview:_clearBtn];
    _clearBtn.backgroundColor = [UIColor clearColor];
    _clearBtn.layer.cornerRadius = 4;
    _clearBtn.layer.borderWidth = 1;
    _clearBtn.layer.borderColor = LH_RGBCOLOR(210, 210, 210).CGColor;
    [_clearBtn setTitle:@"清空历史" forState:BtnNormal];
    [_clearBtn setTitleColor:LH_RGBCOLOR(117, 117, 117) forState:BtnNormal];
    [_clearBtn addTarget:self action:@selector(Clear) forControlEvents:BtnTouchUpInside];


}

-(void)Clear{
    [self.delegate clear];
}

@end
