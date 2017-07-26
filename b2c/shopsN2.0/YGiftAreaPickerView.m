//
//  YGiftAreaPickerView.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftAreaPickerView.h"

@interface YGiftAreaPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong,nonatomic) UIPickerView *pickV;

@property (nonatomic) NSInteger index;

@end

@implementation YGiftAreaPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCancel)];
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight*2/3)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor blackColor];
    headV.alpha = 0.2;
    [headV addGestureRecognizer:tap];

    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectYH(headV), __kWidth, __kHeight/3)];
    [self addSubview:backV];
    backV.backgroundColor = [UIColor whiteColor];

    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 50, 20)];
    [backV addSubview:cancelBtn];
    cancelBtn.titleLabel.font = MFont(15);
    [cancelBtn setTitle:@"取消" forState:BtnNormal];
    [cancelBtn setTitleColor:LH_RGBCOLOR(0, 122, 255) forState:BtnNormal];
    [cancelBtn addTarget:self action:@selector(chooseCancel) forControlEvents:BtnTouchUpInside];

    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-50, 5, 50, 20)];
    [backV addSubview:sureBtn];
    sureBtn.titleLabel.font = MFont(15);
    [sureBtn setTitle:@"确定" forState:BtnNormal];
    [sureBtn setTitleColor:LH_RGBCOLOR(0, 122, 255) forState:BtnNormal];
    [sureBtn addTarget:self action:@selector(chooseSure) forControlEvents:BtnTouchUpInside];

    _pickV =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 25, __kWidth, __kHeight/3-25)];
    [backV addSubview:_pickV];
    _pickV.backgroundColor = [UIColor whiteColor];
    _pickV.delegate = self;
    _pickV.dataSource = self;

}

#pragma mark ==UIPickerViewDelegate==
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _listArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _listArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _index = row;
}




-(void)chooseSure{
    [self.delegate chooseIntegral:_listArr[_index]];
    [self removeFromSuperview];
}


-(void)chooseCancel{
    [self removeFromSuperview];
}

-(void)setListArr:(NSArray *)listArr{
    _listArr = listArr;
    [_pickV reloadAllComponents];
}

@end
