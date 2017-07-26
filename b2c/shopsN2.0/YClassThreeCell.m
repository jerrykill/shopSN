//
//  YClassThreeCell.m
//  shopsN
//
//  Created by imac on 2016/11/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClassThreeCell.h"

@interface YClassThreeCell()
{
    float _width;
    float _height;
}
@property (strong,nonatomic) UIImageView *headIV;

@property (strong,nonatomic) UILabel *titleLb;


@end

@implementation YClassThreeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
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
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, _width-20, _height-40)];
        _headIV.contentMode = UIViewContentModeScaleToFill;
        _headIV.clipsToBounds = YES;
    }
    return _headIV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(1, CGRectYH(_headIV)+5, _width-2, 15)];
        _titleLb.font = MFont(14);
        _titleLb.textColor = LH_RGBCOLOR(85, 85, 85);
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

-(void)setModel:(YClassThreeModel *)model{
    _model = model;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,model.imageName]] placeholderImage:MImage(goodPlachorName)];
    _titleLb.text = model.title;
}

@end
