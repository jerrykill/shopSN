//
//  YSFirstADCircleSectionView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSFirstADCircleSectionView.h"

@interface YSFirstADCircleSectionView ()
{
    CGFloat width;
}

@property (strong,nonatomic) UIImageView *imageIV;

@end

@implementation YSFirstADCircleSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        width = frame.size.width;
        self.backgroundColor = __BackColor;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.imageIV];
}

- (UIImageView *)imageIV {
    if (!_imageIV) {
        _imageIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, width-20, 84)];
        _imageIV.contentMode = UIViewContentModeScaleToFill;
        _imageIV.layer.masksToBounds = YES;
        _imageIV.backgroundColor = LH_RandomColor;
        _imageIV.layer.cornerRadius = 5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAD)];
        [_imageIV addGestureRecognizer:tap];
        _imageIV.userInteractionEnabled = YES;
    }
    return _imageIV;
}
-(void)setModel:(YHeadImage *)model {
    _model = model;
    [_imageIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_model.imageName]] placeholderImage:MImage(ADPlachorName)];
}

- (void)chooseAD {
    [self.delegate chooseSectionADPush:_model.imageUrl Id:_model.imageID];
}

@end


