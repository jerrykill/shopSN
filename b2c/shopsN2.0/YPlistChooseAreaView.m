//
//  YPlistChooseAreaView.m
//  shopsN
//
//  Created by imac on 2017/3/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPlistChooseAreaView.h"
#import "YPlistAddressTool.h"

@interface YPlistChooseAreaView ()
/**
 *  地域选择视图
 */
@property (strong,nonatomic) UIPickerView *areaPickerV;


@property (strong,nonatomic) NSMutableArray<YPlistAddressModel*>* datas;
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

@implementation YPlistChooseAreaView

- (void)getdata{
    _datas = [YPlistAddressTool getTheDataAddress];
    _provinceArr = _datas;
    YPlistAddressModel *model =_datas.firstObject;
    _cityArr = model.list;
    YPlistCityModel *city = _cityArr.firstObject;
    _townArr = city.datas;
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
    YPlistAddressModel *address = [_provinceArr objectAtIndex:[_areaPickerV selectedRowInComponent:0]];
    NSMutableArray *citys =[NSMutableArray array];
    YPlistCityModel *city = [_cityArr objectAtIndex:[_areaPickerV selectedRowInComponent:1]];
    if (city.datas.count) {
        NSMutableArray *areas = [NSMutableArray array];
        YPlistAreaModel *area = [_townArr objectAtIndex:[_areaPickerV selectedRowInComponent:2]];
        [areas addObject:area];
        city.datas = areas;
    }
    [citys addObject:city];
    address.list = citys;
    [self.delegate chooseAddressData:address];
    [self removeFromSuperview];
}

#pragma mark -UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _datas.count;
    }else if(component ==1){
        return _cityArr.count;
    }else{
        return _townArr.count;
    }
}


- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        YPlistAddressModel *model =[_provinceArr objectAtIndex:row];
        return model.province;
    }else if (component==1){
        YPlistCityModel *city = [_cityArr objectAtIndex:row];
        return city.city;
    }else{
        YPlistAreaModel *area = [_townArr objectAtIndex:row];
        return area.area;
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
        YPlistAddressModel *model =[_provinceArr objectAtIndex:row];
        _cityArr = model.list;
        YPlistCityModel *city =_cityArr.firstObject;
        if (city.datas.count) {
            _townArr =city.datas;
        }else{
            _townArr =nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    if (component==1) {
        YPlistCityModel *city = [_cityArr objectAtIndex:row];
        if (city.datas.count) {
            _townArr  = city.datas;
        }else{
            _townArr = nil;
        }

        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
}

@end
