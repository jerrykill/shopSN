//
//  YSTimeSetctionHeadView.m
//  shopsN2.0
//
//  Created by imac on 2017/7/3.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSTimeSetctionHeadView.h"

@interface YSTimeSetctionHeadView ()

@property (strong,nonatomic) UIImageView *logoImageView;

@property (strong,nonatomic) UILabel *nameLbl;

@property (strong,nonatomic) UILabel *hourLbl;

@property (strong,nonatomic) UILabel *minuteLbl;

@property (strong,nonatomic) UILabel *secondLbl;

@property (strong,nonatomic) UIButton *moreBtn;

@property (assign,nonatomic) NSInteger endTime;

@property (strong,nonatomic) NSTimer *timer;

@end

@implementation YSTimeSetctionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _endTime= 0;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.logoImageView];
    [self addSubview:self.nameLbl];
    [self addSubview:self.hourLbl];

    UILabel *maoLbel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_hourLbl), 15, 9, 10)];
        label.textColor = LH_RGBCOLOR(166, 166, 166);
        label.font = MFont(10);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @":";
        [self addSubview:label];
        label;
    });

    [self addSubview:self.minuteLbl];

    UILabel *haoLbel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_minuteLbl), 15, 9, 10)];
        label.textColor = LH_RGBCOLOR(166, 166, 166);
        label.font = MFont(10);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @":";
        [self addSubview:label];
        label;
    });

    [self addSubview:self.secondLbl];
    [self addSubview:self.moreBtn];
    
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 14, 15)];
        _logoImageView.image = MImage(@"形状");
    }
    return _logoImageView;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_logoImageView)+5, 12, 75, 25)];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
        _nameLbl.font = MFont(17);
        _nameLbl.textColor = __MoneyColor;
        _nameLbl.text = @"尾货清仓";
    }
    return _nameLbl;
}

- (UILabel *)hourLbl {
    if (!_hourLbl) {
        _hourLbl = [[UILabel alloc]initWithFrame:CGRectMake((__kWidth-80)/2, 12, 21, 25)];
        _hourLbl.layer.cornerRadius = 2;
        _hourLbl.layer.borderWidth = 1;
        _hourLbl.layer.borderColor = LH_RGBCOLOR(217, 217, 217).CGColor;
        _hourLbl.font = MFont(11);
        _hourLbl.textAlignment = NSTextAlignmentCenter;
        _hourLbl.textColor = LH_RGBCOLOR(102, 102, 102);
        _hourLbl.text = @"00";

    }
    return _hourLbl;
}

- (UILabel *)minuteLbl {
    if (!_minuteLbl) {
        _minuteLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_hourLbl)+10, 12, 21, 25)];
        _minuteLbl.layer.cornerRadius = 2;
        _minuteLbl.layer.borderWidth = 1;
        _minuteLbl.layer.borderColor = LH_RGBCOLOR(217, 217, 217).CGColor;
        _minuteLbl.font = MFont(11);
        _minuteLbl.textAlignment = NSTextAlignmentCenter;
        _minuteLbl.textColor = LH_RGBCOLOR(102, 102, 102);
        _minuteLbl.text = @"00";
    }
    return _minuteLbl;
}

- (UILabel *)secondLbl {
    if (!_secondLbl) {
        _secondLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectXW(_minuteLbl)+10, 12, 21, 25)];
        _secondLbl.layer.cornerRadius = 2;
        _secondLbl.layer.borderWidth = 1;
        _secondLbl.layer.borderColor = LH_RGBCOLOR(217, 217, 217).CGColor;
        _secondLbl.font = MFont(11);
        _secondLbl.textAlignment = NSTextAlignmentCenter;
        _secondLbl.textColor = LH_RGBCOLOR(102, 102, 102);
        _secondLbl.text = @"00";
    }
    return _secondLbl;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-60, 7.5, 60, 30)];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"更多 >"];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(111, 111, 111) range:NSMakeRange(0, 2)];
        [attr addAttribute:NSForegroundColorAttributeName value:LH_RGBCOLOR(200, 200, 200) range:NSMakeRange(2, attr.length-2)];
        [attr addAttribute:NSFontAttributeName value:MFont(15) range:NSMakeRange(0, 2)];
        [attr addAttribute:NSFontAttributeName value:MFont(10) range:NSMakeRange(2, attr.length-2)];
        [_moreBtn setAttributedTitle:attr forState:BtnNormal];
        [_moreBtn addTarget:self action:@selector(chooseMore) forControlEvents:BtnTouchUpInside];
    }
    return _moreBtn;
}

- (void)chooseMore {
    [self.delegate lookClearanceMore];
    
}

- (void)setTime:(NSString *)time {
    _time = time;
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",[dateNow timeIntervalSince1970]];
    if (!_endTime) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduce) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        _endTime = [_time integerValue]-[timeSp integerValue];
        if (_endTime>0) {
            NSString *hour = [NSString stringWithFormat:@"%ld",_endTime/3600];
            NSString *minute = [NSString stringWithFormat:@"%02ld",_endTime%3600/60];
            NSString *second = [NSString stringWithFormat:@"%02ld",_endTime%3600%60];
            _hourLbl.text = hour;
            _minuteLbl.text = minute;
            _secondLbl.text = second;
        }
    }

}
-(void)reduce{
    NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    if (_endTime>0) {
        _endTime = [_time integerValue]-[timeSp integerValue];

        NSString *hour = [NSString stringWithFormat:@"%ld",_endTime/3600];
        NSString *minute = [NSString stringWithFormat:@"%02ld",_endTime%3600/60];
        NSString *second = [NSString stringWithFormat:@"%02ld",_endTime%3600%60];
        _hourLbl.text = hour;
        _minuteLbl.text = minute;
        _secondLbl.text = second;
    }

}


-(void)dealloc{
    //取消定时器
    [_timer invalidate];
    _timer = nil;
}

@end
