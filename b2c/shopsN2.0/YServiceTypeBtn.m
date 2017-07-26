//
//  YServiceTypeBtn.m
//  shopsN
//
//  Created by imac on 2017/2/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceTypeBtn.h"

@interface YServiceTypeBtn()

@end

@implementation YServiceTypeBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-13, frame.size.height-13, 13, 13)];
        [self addSubview:_lineIV];
        _lineIV.image = MImage(@"service_select");
        _lineIV.layer.masksToBounds = YES;
        _lineIV.layer.cornerRadius = 5;
    }
    return self;
}



@end
