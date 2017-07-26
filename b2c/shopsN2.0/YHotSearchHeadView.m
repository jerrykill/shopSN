
//
//  YHotSearchHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YHotSearchHeadView.h"

@interface YHotSearchHeadView()

@property (strong,nonatomic) UIImageView *hotIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YHotSearchHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;

}

-(void)initView{
    _hotIV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 21, 12, 16)];
    [self addSubview:_hotIV];
    _hotIV.contentMode = UIViewContentModeScaleAspectFit;

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_hotIV)+10, 22, 80, 15)];
    [self addSubview:_titleLb];
    _titleLb.textColor = LH_RGBCOLOR(153, 153, 153);
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.font = MFont(15);
    _titleLb.backgroundColor = [UIColor clearColor];
    
}

-(void)setImage:(NSString *)image{
    if (!IsNilString(image)) {
        _hotIV.image = MImage(image);
        _hotIV.hidden = NO;
        _titleLb.frame = CGRectMake(CGRectXW(_hotIV)+10, 22, 80, 15);
    }else{
        _hotIV.hidden = YES;
        _titleLb.frame = CGRectMake(12, 22, 80, 15);
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLb.text = _title;
}

@end
