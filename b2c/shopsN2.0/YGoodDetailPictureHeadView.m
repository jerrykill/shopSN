//
//  YGoodDetailPictureHeadView.m
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailPictureHeadView.h"

@interface YGoodDetailPictureHeadView()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) UILabel *countLb;

@property (strong,nonatomic) UIView *circleV;

@property (assign,nonatomic) NSInteger current;

@end

@implementation YGoodDetailPictureHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.scrollV];
    [self sendSubviewToBack:_scrollV];
    [self addSubview:self.circleV];
    [_circleV addSubview:self.countLb];

}

#pragma mark ==懒加载==
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kWidth)];
        _scrollV.contentSize = CGSizeMake(__kWidth, 0);
        _scrollV.delegate =self;
        _scrollV.scrollEnabled = YES;
        _scrollV.bounces = YES;
        _scrollV.pagingEnabled = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}

-(UIView *)circleV{
    if (!_circleV) {
        _circleV = [[UIView alloc]initWithFrame:CGRectMake(__kWidth-56, __kWidth-47, 36, 36)];
        _circleV.backgroundColor = [UIColor blackColor];
        _circleV.alpha = 0.4;
        _circleV.layer.cornerRadius =18;
    }
    return _circleV;
}

-(UILabel *)countLb{
    if (!_countLb) {
        _countLb = [[UILabel alloc]initWithFrame:CGRectMake(3, 8, 30, 20)];
        _countLb.textAlignment = NSTextAlignmentCenter;
        _countLb.textColor = [UIColor whiteColor];
    }
    return _countLb;
}


-(void)setImageArr:(NSMutableArray *)imageArr {
    for (id obj in _scrollV.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    _imageArr = imageArr;
    UIImageView *imgV;
    for (int i=0; i<_imageArr.count; i++) {
        imgV  = [[UIImageView alloc]init];
        NSString *url = [NSString stringWithFormat:@"%@%@",HomeADUrl,_imageArr[i]];
        [imgV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:MImage(ADPlachorName)];
        imgV.contentMode = UIViewContentModeScaleToFill;
        imgV.clipsToBounds = YES;
        [_scrollV addSubview:imgV];
        imgV.frame = CGRectMake(i*__kWidth, 0, __kWidth, __kWidth);
//        imgV.backgroundColor = LH_RandomColor;
    }
    _scrollV.contentSize = CGSizeMake(__kWidth*_imageArr.count, 0);
    if (!_current) {
        _current=0;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld/%ld",_current+1,_imageArr.count]];
    [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(0,1)];
    [attr addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(1, attr.length-1)];
    _countLb.attributedText = attr;

}

#pragma mark ==UIScrollViewDelegate==
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = _scrollV.contentOffset;
    NSInteger index = round(point.x/__kWidth);
    if (index == _imageArr.count) {
        index =1;
    }
    _current = index;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld/%ld",index+1,_imageArr.count]];
    NSInteger length = [NSString stringWithFormat:@"%ld",index].length;
    [attr addAttribute:NSFontAttributeName value:MFont(18) range:NSMakeRange(0,length)];
    [attr addAttribute:NSFontAttributeName value:MFont(13) range:NSMakeRange(length, attr.length-length)];
    _countLb.attributedText = attr;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = _scrollV.contentOffset;
    CGFloat index = round(point.x/__kWidth);
    if (index>_imageArr.count-1) {
        _scrollV.contentOffset = CGPointMake(0, 0);
    }
}

@end
