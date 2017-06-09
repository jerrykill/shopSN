//
//  YClearanceTimeView.m
//  shopsN
//
//  Created by imac on 2016/12/9.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YClearanceTimeView.h"
#import "YAdHeadView.h"

@interface YClearanceTimeView()<YAdHeadViewDelegate>

@property (strong,nonatomic) YAdHeadView *adheadV;


@property (strong,nonatomic) UIImageView *logoIV;

@property (strong,nonatomic) UIButton *hourBtn;

@property (strong,nonatomic) UIButton *minuteBtn;

@property (strong,nonatomic) UIButton *secondBtn;

@property (strong,nonatomic) NSTimer *timer;

@property (assign,nonatomic) NSInteger endTime;

@end

@implementation YClearanceTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
        _endTime = 0;
    }
    return self;
}

-(void)initView{
    _adheadV =[[YAdHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 158*__kWidth/375)];
    [self addSubview:_adheadV];
    _adheadV.delegate = self;

    _logoIV =[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectYH(_adheadV)+14, 110, 19)];
    [self addSubview:_logoIV];
    _logoIV.image =MImage(@"Limited-time");
    _logoIV.contentMode = UIViewContentModeScaleAspectFit;

    _hourBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(_logoIV)+28, CGRectYH(_adheadV)+10, 21, 25)];
    [self addSubview:_hourBtn];
    _hourBtn.layer.cornerRadius = 2;
    _hourBtn.layer.borderColor = LH_RGBCOLOR(217, 217, 217).CGColor;
    _hourBtn.layer.borderWidth = 1;
    _hourBtn.titleLabel.font = MFont(11);
    [_hourBtn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnNormal];
    _hourBtn.userInteractionEnabled = NO;

    UILabel *maoLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_hourBtn), CGRectYH(_adheadV)+15, 9, 10)];
    [self addSubview:maoLb];
    maoLb.textColor = LH_RGBCOLOR(166, 166, 166);
    maoLb.font = MFont(10);
    maoLb.textAlignment = NSTextAlignmentCenter;
    maoLb.text = @":";

    _minuteBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(maoLb), CGRectYH(_adheadV)+10, 21, 25)];
    [self addSubview:_minuteBtn];
    _minuteBtn.layer.cornerRadius = 2;
    _minuteBtn.layer.borderColor = LH_RGBCOLOR(217, 217, 217).CGColor;
    _minuteBtn.layer.borderWidth = 1;
    _minuteBtn.titleLabel.font = MFont(11);
    [_minuteBtn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnNormal];
    _minuteBtn.userInteractionEnabled = NO;

    UILabel *haoLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_minuteBtn), CGRectYH(_adheadV)+15, 9, 10)];
    [self addSubview:haoLb];
    haoLb.textColor = LH_RGBCOLOR(166, 166, 166);
    haoLb.font = MFont(10);
    haoLb.textAlignment = NSTextAlignmentCenter;
    haoLb.text = @":";

    _secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectXW(haoLb), CGRectYH(_adheadV)+10, 21, 25)];
    [self addSubview:_secondBtn];
    _secondBtn.layer.cornerRadius = 2;
    _secondBtn.layer.borderColor = LH_RGBCOLOR(217, 217, 217).CGColor;
    _secondBtn.layer.borderWidth = 1;
    _secondBtn.titleLabel.font = MFont(11);
    [_secondBtn setTitleColor:LH_RGBCOLOR(102, 102, 102) forState:BtnNormal];
    _secondBtn.userInteractionEnabled = NO;


}

-(void)setImageArr:(NSMutableArray<YHeadImage *> *)imageArr{
    _adheadV.dataArr = imageArr;
}



-(void)setTime:(NSString *)time{
    _time =time;
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",[dateNow timeIntervalSince1970]];
    if (!_endTime) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduce) userInfo:nil repeats:YES];
        _endTime = [_time integerValue]-[timeSp integerValue];
        NSString *hour = [NSString stringWithFormat:@"%ld",_endTime/3600];
        NSString *minute = [NSString stringWithFormat:@"%02ld",_endTime%3600/60];
        NSString *second = [NSString stringWithFormat:@"%02ld",_endTime%3600%60];
        [_hourBtn setTitle:hour forState:BtnNormal];
        [_minuteBtn setTitle:minute forState:BtnNormal];
        [_secondBtn setTitle:second forState:BtnNormal];
    }



}

#pragma mark ==YAdHeadViewDelegate==
-(void)chooseAD:(NSString *)url{
    [self.delegate chooseAD:url];
}

-(void)reduce{
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
//    NSLog(@"%@",timeSp);
    if (_endTime) {
         _endTime = [_time integerValue]-[timeSp integerValue];

        NSString *hour = [NSString stringWithFormat:@"%ld",_endTime/3600];
        NSString *minute = [NSString stringWithFormat:@"%02ld",_endTime%3600/60];
        NSString *second = [NSString stringWithFormat:@"%02ld",_endTime%3600%60];
        [_hourBtn setTitle:hour forState:BtnNormal];
        [_minuteBtn setTitle:minute forState:BtnNormal];
        [_secondBtn setTitle:second forState:BtnNormal];
    }

}


-(void)dealloc{
    //取消定时器
    [_timer invalidate];
    _timer = nil;
}
@end
