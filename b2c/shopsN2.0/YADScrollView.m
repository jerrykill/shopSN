//
//  YADScrollView.m
//  shopsN
//
//  Created by imac on 2016/11/25.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YADScrollView.h"

@interface YADScrollView()<UIScrollViewDelegate>
{
    CGRect _frame;
}

@property (strong,nonatomic) UIScrollView *srollV;


@property (strong,nonatomic) UIPageControl* pagControl;

@property (strong,nonatomic) NSTimer* timer;
@end

@implementation YADScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        _frame = frame;
        [self addSubview:self.srollV];
        //开启定时器
        [_timer setFireDate:[NSDate distantPast]];

        //scrollView动画播放
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(playingImage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)dealloc{
    //取消定时器
    [_timer invalidate];
    _timer = nil;
}

-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    UIImageView *imgV;
    for (int i=0; i<imgArr.count; i++) {
        YHeadImage *headimg = _imgArr[i];
        imgV  = [[UIImageView alloc]init];
        NSString *url = [NSString stringWithFormat:@"%@%@",HomeADUrl,headimg.imageName];
        [imgV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:MImage(ADPlachorName)];
        imgV.contentMode = UIViewContentModeScaleToFill;
        imgV.clipsToBounds = YES;
        [_srollV addSubview:imgV];

        imgV.frame = CGRectMake(i*_frame.size.width, 0, _frame.size.width, _frame.size.height);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAD:)];
        [imgV addGestureRecognizer:tap];
        imgV.tag = 400+i;
        imgV.backgroundColor = LH_RandomColor;
        imgV.userInteractionEnabled = YES;
    }
    _srollV.contentSize = CGSizeMake(_frame.size.width*_imgArr.count, 0);

    //页面控制器
    _pagControl = [[UIPageControl alloc]init];
    [self addSubview:_pagControl];
    _pagControl.frame = CGRectMake(0, _frame.size.height-10, _frame.size.width, 10);
    _pagControl.numberOfPages = _imgArr.count;
    _pagControl.pageIndicatorTintColor = HEXCOLOR(0x828282);
    _pagControl.currentPageIndicatorTintColor = __DefaultColor;
    _pagControl.userInteractionEnabled = NO;
    _pagControl.hidden = YES;


}

-(void)chooseAD:(UITapGestureRecognizer*)sender{
    YHeadImage *headimg = _imgArr[sender.view.tag-400];
    [self.delegate chooseAD:headimg.imageUrl];
}

#pragma mark ==UIScrollView Delegate==
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = _srollV.contentOffset;
    NSInteger index = round(point.x/_frame.size.width);
    if (index == _imgArr.count) {
        index = 0;
    }
    _pagControl.currentPage = index;
}

-(void)playingImage{
    int i = 1;
    if (_pagControl.currentPage == _imgArr.count-1) {
        _pagControl.currentPage = 0;
        i=0;
    }
    _srollV.contentOffset = CGPointMake((_pagControl.currentPage+i)*_frame.size.width, 0);
}

#pragma mark ==懒加载==
-(UIScrollView *)srollV{
    if (!_srollV) {
        _srollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        _srollV.contentSize = _frame.size;
        _srollV.delegate = self;
        _srollV.pagingEnabled = YES;
        _srollV.showsVerticalScrollIndicator = NO;
        _srollV.showsHorizontalScrollIndicator = NO;
    }
    return _srollV;
}



@end
