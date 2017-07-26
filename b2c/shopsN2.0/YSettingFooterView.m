//
//  YSettingFooterView.m
//  shopsN
//
//  Created by imac on 2016/12/19.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSettingFooterView.h"

@interface YSettingFooterView ()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YSettingFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, __kWidth-14, 36)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment =NSTextAlignmentLeft;
    _titleLb.numberOfLines = 0;
    _titleLb.font = MFont(14);
    _titleLb.textColor = LH_RGBCOLOR(151, 151, 151);

}

-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}


@end
