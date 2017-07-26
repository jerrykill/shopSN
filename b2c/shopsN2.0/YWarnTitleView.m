//
//  YWarnTitleView.m
//  shopsN
//
//  Created by imac on 2017/2/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YWarnTitleView.h"

@interface YWarnTitleView ()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIScrollView *scrollV;


@property (strong,nonatomic) NSTimer *timer;

@property (assign,nonatomic) NSInteger index;

@end

@implementation YWarnTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        _index = 0;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.scrollV];
    //scrollView动画播放
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(playChange) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark ==懒加载==
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        _scrollV.contentSize = _frame.size;
//        _scrollV.pagingEnabled = YES;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
    }
    return _scrollV;
}

-(void)setTitleArr:(NSArray<YWarnModel *> *)titleArr{
    _titleArr = titleArr;
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
    for (id obj in _scrollV.subviews) {
        [obj removeFromSuperview];
    }
    _scrollV.contentSize =CGSizeMake(0, (_titleArr.count+1)*_frame.size.height);
    for (int i=0; i<_titleArr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*_frame.size.height, _frame.size.width, _frame.size.height)];
        [_scrollV addSubview:label];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = MFont(14);
        label.textColor = __TextColor;
        YWarnModel *model = _titleArr[i];
        label.text = model.warnTitle;
        label.tag = i+33;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWarn:)];
        [label addGestureRecognizer:tap];

    }
    if (_titleArr.count>1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleArr.count*_frame.size.height, _frame.size.width, _frame.size.height)];
        [_scrollV addSubview:label];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = MFont(14);
        label.textColor = __TextColor;
        YWarnModel *model =_titleArr[0];
        label.text = model.warnTitle;
        label.tag = 33;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseWarn:)];
        [label addGestureRecognizer:tap];

    }else{
        //关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

-(void)playChange{
    _index++;
    if (_index == _titleArr.count) {
        [UIView animateWithDuration:1 animations:^{
            _scrollV.contentOffset = CGPointMake(0, (_index)*_frame.size.height);
        } completion:^(BOOL finished) {
            _scrollV.contentOffset = CGPointMake(0, 0);
        }];
        _index=0;
    }else{
       [UIView animateWithDuration:1.0 animations:^{
          _scrollV.contentOffset = CGPointMake(0, _index*_frame.size.height);
      }];
    }
}

-(void)chooseWarn:(UITapGestureRecognizer*)sender{
    [self.delegate chooseWarnTitle:sender.view.tag];
}

-(void)dealloc{
    //取消定时器
    [_timer invalidate];
    _timer = nil;
}

@end
