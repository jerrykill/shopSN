//
//  YFeedbackChooseView.m
//  shopsN
//
//  Created by imac on 2017/2/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YFeedbackChooseView.h"

@interface YFeedbackChooseView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGRect _frame;
}

@property (strong,nonatomic) UIPickerView *pickV;

@property (nonatomic) NSInteger index;



@end

@implementation YFeedbackChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _frame =frame;
        [self initView];
    }
    return self;
}

-(void)initView{
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

    _pickV =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, __kWidth, _frame.size.height-30)];
    [self addSubview:_pickV];
    _pickV.backgroundColor = [UIColor whiteColor];
    _pickV.delegate = self;
    _pickV.dataSource = self;

}
#pragma mark ==UIPickerViewDelegate==
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _typeArr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _typeArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _index =row;
}

-(void)setTypeArr:(NSArray *)typeArr{
    _typeArr = typeArr;
    [_pickV reloadAllComponents];
}
- (void)chooseCanel{
    [self removeFromSuperview];
}
-(void)chooseSure{
    [self.delegate chooseFeedType:[NSString stringWithFormat:@"%ld",_index+1]];
    [self removeFromSuperview];
}

@end
