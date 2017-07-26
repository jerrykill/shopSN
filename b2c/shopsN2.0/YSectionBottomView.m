//
//  YSectionBottomView.m
//  shopsN
//
//  Created by imac on 2016/11/25.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YSectionBottomView.h"
#import "YADScrollView.h"

@interface YSectionBottomView ()<YADScrollViewDelegate>{
    CGFloat _width;
    CGFloat _height;
}

@property (strong,nonatomic) YADScrollView *adScrollV;

@end

@implementation YSectionBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _width = frame.size.width;
        _height = frame.size.height;
        [self addSubview:self.adScrollV];

    }
    return self;
}

-(void)chooseAD:(NSString *)url{
    [self.delegate chooseBottomV:url];
}

-(void)setImageArr:(NSArray<YHeadImage *> *)imageArr{
    _imageArr = imageArr;
    _adScrollV.imgArr = _imageArr;
}

#pragma mark ==懒加载==
-(YADScrollView *)adScrollV{
    if (!_adScrollV) {
        _adScrollV = [[YADScrollView alloc]initWithFrame:CGRectMake(0, 5, _width, _height-5)];
        _adScrollV.delegate = self;
    }
    return _adScrollV;
}



@end
