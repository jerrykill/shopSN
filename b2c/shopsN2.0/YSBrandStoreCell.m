//
//  YSBrandStoreCell.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSBrandStoreCell.h"

@interface YSBrandStoreCell ()
{
    CGFloat width;
    CGFloat height;
}
@property (strong,nonatomic) UIImageView *logoIV;

@end

@implementation YSBrandStoreCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        height = frame.size.height;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.logoIV];
}

- (UIImageView *)logoIV {
    if (!_logoIV) {
        _logoIV = [[UIImageView alloc]initWithFrame:CGRectMake((width-50)/2, (height-20)/2, 50, 20)];
        _logoIV.contentMode = UIViewContentModeScaleToFill;
        _logoIV.layer.masksToBounds = YES;
    }
    return _logoIV;
}



- (void)setModel:(YSBrandModel *)model {
    [_logoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.logo]]];
}

@end
