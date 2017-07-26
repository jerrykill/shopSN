//
//  SectionHeadView.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSectionHeadView.h"

@interface YSectionHeadView()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation YSectionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR(0xf2f2f2);
        [self addSubview:self.headIV];
        [self addSubview:self.titleLb];
    }
    return self;
}

-(void)initTitle:(NSString *)title Image:(NSString *)imageName{
    _headIV.frame= CGRectMake((__kWidth-30-15*(title.length))/2, 7.5, 15, 15);

    _headIV.image = MImage(imageName);

    _titleLb.frame = CGRectMake(CGRectXW(_headIV)+12, 7.5, 15*(title.length)+20, 15);
    _titleLb.text = title;

}


#pragma mark ==懒加载==
-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]init];
        _headIV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.textColor = __DefaultColor;
        _titleLb.font = BFont(14);
        _titleLb.backgroundColor = [UIColor clearColor];
    }
    return _titleLb;
}

@end
