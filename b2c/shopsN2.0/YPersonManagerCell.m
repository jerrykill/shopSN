//
//  YPersonManagerCell.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonManagerCell.h"

@implementation YPersonManagerCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.alpha = 0.34901960784313724;
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width =(__kWidth-54)/2;
    CGFloat height = width*21/16;
    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake((width-55)/2, (height-90)/2, 55, 55)];
    [self addSubview:_headIV];

    _headIV.contentMode = UIViewContentModeScaleAspectFit;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_headIV)+10, width, 20)];
    [self addSubview:_titleLb];
    _titleLb.textColor = [UIColor blackColor];
    _titleLb.font = MFont(19);
    _titleLb.textAlignment = NSTextAlignmentCenter;

}

@end
