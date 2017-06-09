//
//  YClassThreeCell.m
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClassThreeCell.h"

@interface YClassThreeCell()

@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;


@end

@implementation YClassThreeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.headIV];

    [self addSubview:self.titleLb];
}

#pragma mark ==懒加载==
-(UIImageView *)headIV{
    if (!_headIV) {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-40)];
        _headIV.backgroundColor = LH_RandomColor;
        _headIV.contentMode = UIViewContentModeScaleToFill;
        _headIV.clipsToBounds = YES;
    }
    return _headIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectYH(_headIV)+5, self.frame.size.width, 15)];
        _titleLb.font = MFont(14);
        _titleLb.textColor = LH_RGBCOLOR(85, 85, 85);
        _titleLb.backgroundColor = [UIColor whiteColor];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

-(void)setModel:(YClassThreeModel *)model{
    _model = model;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.imageName]]];
    _titleLb.text = model.title;
}

@end
