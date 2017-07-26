//
//  ZChooseAreaView.m
//
//  Created by  on 16/7/5.
//  Copyright © 2016年 yisu. All rights reserved.
//

#import "ZChooseAreaView.h"

@interface ZChooseAreaView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/**
 *  地域选择视图
 */
@property (strong,nonatomic) UIPickerView *areaPickerV;


//data
@property (strong,nonatomic) NSDictionary *pickerDic;
/**
 *  省数据数组
 */
@property (strong,nonatomic) NSArray *provinceArr;
/**
 *  市数据数组
 */
@property (strong,nonatomic) NSArray *cityArr;
/**
 *  区县数据数组
 */
@property (strong,nonatomic) NSArray *townArr;
/**
 *  选择数组
 */
@property (strong,nonatomic) NSArray *selectedArray;

@end

@implementation ZChooseAreaView

- (void)getdata{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc]initWithContentsOfFile:path];
    self.provinceArr = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    if (self.selectedArray.count>0) {
        self.cityArr = [[self.selectedArray objectAtIndex:0]allKeys];
    }
    if (self.cityArr.count>0) {
        self.townArr = [[self.selectedArray objectAtIndex:0]allKeys];
    }
}

- (instancetype)initWithAreaFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
        _provinceArr = [NSArray array];
        _cityArr = [NSArray array];
        _townArr = [NSArray array];
        [self getdata];
    }
    return self;
}

- (void)initView{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 40)];
    [self addSubview:headV];
    headV.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 40, 20)];
    [headV addSubview:cancelBtn];
    cancelBtn.titleLabel.font = MFont(13);
    cancelBtn.backgroundColor =[UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:BtnNormal];
    [cancelBtn setTitleColor:LH_RGBCOLOR(0, 122, 255) forState:BtnNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:BtnTouchUpInside];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-60, 10, 40, 20)];
    [headV addSubview:sureBtn];
    sureBtn.titleLabel.font = MFont(13);
    sureBtn.backgroundColor = [UIColor clearColor];
    [sureBtn setTitle:@"确定" forState:BtnNormal];
    [sureBtn setTitleColor:LH_RGBCOLOR(0, 122, 255) forState:BtnNormal];
    sureBtn.layer.cornerRadius = 4;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:BtnTouchUpInside];
    
    _areaPickerV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 25, __kWidth, self.frame.size.height-40)];
    [self addSubview:_areaPickerV];
    _areaPickerV.delegate =self;
    _areaPickerV.dataSource =self;
}
/**
 *  取消选择
 */
- (void)cancelAction{
    [self removeFromSuperview];
}
/**
 *  确定选择该地区
 */
- (void)sureAction{
    self.province =[self.provinceArr objectAtIndex:[_areaPickerV selectedRowInComponent:0]];
    self.city = [self.cityArr objectAtIndex:[_areaPickerV selectedRowInComponent:1]];
    self.area = [self.townArr objectAtIndex:[_areaPickerV selectedRowInComponent:2]];
    if (self.returntextfileBlock!=nil) {
        NSString *dataStr = [NSString stringWithFormat:@"%@,%@,%@",_province,_city,_area];
        self.returntextfileBlock(dataStr);
    }
    [self removeFromSuperview];
}
#pragma mark -UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArr.count;
    }else if(component ==1){
        return self.cityArr.count;
    }else{
        return self.townArr.count;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [self.provinceArr objectAtIndex:row];
    }else if (component==1){
        return [self.cityArr objectAtIndex:row];
    }else{
        return [self.townArr objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {
        return 110;
    }else if (component==1){
        return 100;
    }else{
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArr objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArr = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArr = nil;
        }
        if (self.cityArr.count > 0) {
            self.townArr = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArr objectAtIndex:0]];
        } else {
            self.townArr = nil;
        }
        
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    if (component==1){
        if (self.selectedArray.count > 0 && self.cityArr.count > 0) {
            self.townArr = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArr objectAtIndex:row]];
        } else {
            self.townArr = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
