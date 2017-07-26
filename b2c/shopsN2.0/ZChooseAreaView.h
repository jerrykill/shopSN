//
//  ZChooseAreaView.h
//
//  Created by  on 16/7/5.
//  Copyright © 2016年 yisu. All rights reserved.
//
/* 提供 新建收货地址页面
 *
 *  选择地区 view
 *
 */
#import "BaseView.h"


typedef void(^returnaTFBlock) (NSString *data);

@interface ZChooseAreaView : BaseView

/**
 *  省
 */
@property (strong,nonatomic) NSString *province;
/**
 *  市
 */
@property (strong,nonatomic) NSString *city;
/**
 *  区
 */
@property (strong,nonatomic) NSString *area;

-(instancetype)initWithAreaFrame:(CGRect)frame;

@property (copy,nonatomic) returnaTFBlock returntextfileBlock;

@end
