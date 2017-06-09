//
//  YADClassCell.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YADClassCell.h"

@interface YADClassCell(){
    CGFloat _width;
}

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;

@end

@implementation YADClassCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;

        [self addSubview:self.headIV];
        [self addSubview:self.titleLb];
        
    }
    return self;
}

-(void)setData:(YHeadClass *)data{
    _data = data;
    _headIV.image = MImage(_data.imageName);
    _titleLb.text = _data.title;
}

#pragma mark ==懒加载==
-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:
                   CGRectMake((_width-56)/2, 15, 56, 56)];
        _headIV.layer.cornerRadius = 20;
        _headIV.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _headIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:
                    CGRectMake(0, CGRectYH(_headIV)+4, _width, 20)];
        _titleLb.textColor = LH_RGBCOLOR(85, 85, 85);
        _titleLb.font = MFont(15);
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}


@end
