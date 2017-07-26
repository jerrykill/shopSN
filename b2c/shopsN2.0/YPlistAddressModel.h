//
//  YPlistAddressModel.h
//  shopsN
//
//  Created by imac on 2017/3/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YPlistCityModel,YPlistAreaModel;

@interface YPlistAddressModel : NSObject
/**省*/
@property (strong,nonatomic) NSString *province;
/**省id*/
@property (strong,nonatomic) NSString *provinceID;

@property (strong,nonatomic) NSMutableArray<YPlistCityModel*>*list;

@end

@interface YPlistCityModel : NSObject
/**城市名*/
@property (strong,nonatomic) NSString *city;
/**城市id*/
@property (strong,nonatomic) NSString *cityId;

@property (strong,nonatomic) NSMutableArray<YPlistAreaModel*>*datas;

@end

@interface YPlistAreaModel : NSObject
/**区/县*/
@property (strong,nonatomic) NSString *area;
/**区id*/
@property (strong,nonatomic) NSString *areaID;

@end
