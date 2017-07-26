//
//  YGoodLocationCheckView.m
//  shopsN
//
//  Created by imac on 2016/12/16.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodLocationCheckView.h"

@interface YGoodLocationCheckView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGRect _frame;
}

@property (strong,nonatomic) UIPickerView *pickV;

@property (nonatomic) NSInteger index;

@end

@implementation YGoodLocationCheckView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _index = 0;
        _frame = frame;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 1)];
    [self addSubview:lineIV];
    lineIV.backgroundColor =  __DefaultColor;

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

    _pickV =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 25, __kWidth, _frame.size.height-25)];
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
    return _locationArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    YSGoodLocationModel *model =_locationArr[row];
   return model.name;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _index = row;
}


#pragma mark ==取消==
-(void)chooseCanel{
    [self removeFromSuperview];
}

#pragma mark ==确认==
-(void)chooseSure{
    YSGoodLocationModel *model = _locationArr[_index];
    [self.delegate chooseLoaction:model];
    [self removeFromSuperview];
}

-(void)setLocationArr:(NSMutableArray<YSGoodLocationModel *> *)locationArr{
    _locationArr = locationArr;
    [_pickV reloadAllComponents];
}

@end
