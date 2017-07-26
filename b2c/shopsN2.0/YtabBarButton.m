//
//  YtabBarButton.m
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YtabBarButton.h"

@interface YtabBarButton()


@end

@implementation YtabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;

        _colorIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, width, 1)];
        [self addSubview:_colorIV];
        _colorIV.userInteractionEnabled = NO;
        _colorIV.backgroundColor = [UIColor blackColor];

        self.titleLabel.font = MFont(10);
        self.imageEdgeInsets = UIEdgeInsetsMake((height-25-15)/2,(width-25)/2 ,15, (width-25)/2);
        self.titleEdgeInsets = UIEdgeInsetsMake((height-25-15)/2+25+4, -25, 0, 0);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:LH_RGBCOLOR(50, 50, 50) forState:BtnNormal];
        [self setTitleColor:__DefaultColor forState:BtnStateSelected];
    }
    return self;
}



- (void)addBtnImage:(UIImage *)image SelectedImage:(UIImage *)selectedImage title:(NSString *)name {
    [self setImage:image forState:BtnNormal];
    [self setImage:selectedImage forState:BtnStateSelected];
    [self setTitle:name forState:BtnNormal];
    [self setTitle:name forState:BtnStateSelected];
}

@end
