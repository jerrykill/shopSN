
//
//  YGoodShareBtnView.m
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodShareBtnView.h"

@interface YGoodShareBtnView()
{
    CGFloat _width;
}
@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YGoodShareBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        [self initView];
    }
    return self;
}

-(void)initView{
    _headIV = [[UIImageView alloc]initWithFrame:CGRectMake((_width -60)/2, 0, 60, 60)];
    [self addSubview:_headIV];
    _headIV.layer.cornerRadius = 30;


    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_headIV)+10, _width, 15)];
    [self addSubview:_titleLb];
    _titleLb.font = MFont(15);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = __TextColor;

}

-(void)setTitle:(NSString *)title{
    _titleLb.text =title;
}

-(void)setImageName:(NSString *)imageName{
    _headIV.image =MImage(imageName);
}

@end
