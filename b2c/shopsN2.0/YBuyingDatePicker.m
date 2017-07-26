//
//  YBuyingDatePicker.m
//  shopsN
//
//  Created by imac on 2017/3/14.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBuyingDatePicker.h"

@interface YBuyingDatePicker ()
{
    CGRect _frame;
}

@property (strong,nonatomic) UIDatePicker *datePicker;

@property (strong,nonatomic) NSString *dateTime;

@end

@implementation YBuyingDatePicker

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _frame = frame;
        [self initView];
    }
    return self;
}

- (void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor = __DefaultColor;

    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 50, 20)];
    [self addSubview:cancelBtn];
    cancelBtn.titleLabel.font = MFont(15);
    [cancelBtn setTitle:@"取消" forState:BtnNormal];
    [cancelBtn setTitleColor:LH_RGBCOLOR(0, 122, 255) forState:BtnNormal];
    [cancelBtn addTarget:self action:@selector(chooseCanel) forControlEvents:BtnTouchUpInside];

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-50, 5, 50, 20)];
    [self addSubview:sureBtn];
    sureBtn.titleLabel.font = MFont(15);
    [sureBtn setTitle:@"确定" forState:BtnNormal];
    [sureBtn setTitleColor:LH_RGBCOLOR(0, 122, 255) forState:BtnNormal];
    [sureBtn addTarget:self action:@selector(chooseSure) forControlEvents:BtnTouchUpInside];
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30, __kWidth, _frame.size.height-25)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [self addSubview:_datePicker];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}
- (void)dateChanged:(id)sender
{    _datePicker = (UIDatePicker *)sender;
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStrs = [NSString stringWithFormat:@"%ld",(long)[_datePicker.date timeIntervalSince1970]];
    _dateTime = dateStrs;
}

#pragma mark ==取消==
-(void)chooseCanel{
    [self removeFromSuperview];
    [self.delegate hiddenView];
}
#pragma mark ==确认==
-(void)chooseSure{
    if ([_dateTime integerValue]<100) {
        _dateTime = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
    }
    [self.delegate chooseDateTime:_dateTime];
    [self removeFromSuperview];
}

@end
