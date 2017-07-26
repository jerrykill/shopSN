//
//  YSendTimeView.m
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSendTimeView.h"

@interface YSendTimeView()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YSendTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _titleLb  = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 120, 20)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
    _titleLb.font = MFont(12);

    
}

-(void)setTitle:(NSString *)title{
    _title= title;
    _titleLb.text=title;
}

-(void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        _titleLb.text = [NSString stringWithFormat:@"%@ √",_title];
        _titleLb.textColor = __DefaultColor;
    }else{
        _titleLb.text = [NSString stringWithFormat:@"%@",_title];
        _titleLb.textColor = LH_RGBCOLOR(117, 117, 117);
    }
}

@end
