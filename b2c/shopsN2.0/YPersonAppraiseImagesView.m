//
//  YPersonAppraiseImagesView.m
//  shopsN2.0
//
//  Created by imac on 2017/6/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonAppraiseImagesView.h"

@implementation YPersonAppraiseImagesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    for (int i=0; i<imageArr.count; i++) {
        UIImageView *picIV = [[UIImageView alloc]initWithFrame:CGRectMake(10+54*i, 15, 47, 44)];
        [self addSubview:picIV];
        picIV.backgroundColor = LH_RandomColor;
        [picIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,imageArr[i]]] placeholderImage:MImage(goodPlachorName)];

    }

}

@end
