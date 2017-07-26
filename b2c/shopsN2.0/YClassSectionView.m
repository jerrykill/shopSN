//
//  YClassSectionView.m
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClassSectionView.h"

@interface YClassSectionView()

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YClassSectionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}


-(void)initView{
    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, self.frame.size.width, 15)];
    [self addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = LH_RGBCOLOR(85, 85, 85);
    _titleLb.font =MFont(15);
    

}
-(void)setTitle:(NSString *)title{
    _titleLb.text = title;
}

@end
