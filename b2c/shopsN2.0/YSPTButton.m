//
//  YSPTButton.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSPTButton.h"

@implementation YSPTButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;

        self.titleLabel.font = MFont(10);
        self.imageEdgeInsets = UIEdgeInsetsMake((height-25-15)/2,(width-25)/2 ,15, (width-25)/2);
        self.titleEdgeInsets = UIEdgeInsetsMake((height-25-15)/2+25+4, -25, 0, 0);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:__DTextColor forState:BtnNormal];
        [self setTitleColor:[UIColor blackColor] forState:BtnStateSelected];
    }
    return self;
}

@end
