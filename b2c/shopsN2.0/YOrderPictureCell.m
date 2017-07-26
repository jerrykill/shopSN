//
//  YOrderPictureCell.m
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YOrderPictureCell.h"

@interface YOrderPictureCell()


@end

@implementation YOrderPictureCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LH_RGBCOLOR(223, 223, 223);
        self.layer.borderColor =__BackColor.CGColor;
        self.layer.borderWidth = 1;
        [self initView];
    }
    return self;
}

- (void)initView{
    _goodIV = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 76, 76)];
    [self addSubview:_goodIV];


    _addIV = [[UIImageView alloc]initWithFrame:CGRectMake(18.5, 23.5, 42, 32)];
    [self addSubview:_addIV];
}

@end
