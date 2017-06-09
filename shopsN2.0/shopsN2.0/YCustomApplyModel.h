//
//  YCustomApplyModel.h
//  shopsN
//
//  Created by imac on 2017/3/31.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCustomApplyModel : NSObject
/**公司名称*/
@property (strong,nonatomic) NSString *company;
/**公司性质*/
//@property (strong,nonatomic) NSString *companyProperty;
///**经营类型*/
//@property (strong,nonatomic) NSString *managementType;
/**省*/
@property (strong,nonatomic) NSString *province;

@property (strong,nonatomic) NSString *provinceId;
/**市*/
@property (strong,nonatomic) NSString *city;

@property (strong,nonatomic) NSString *cityId;
/**区/县*/
@property (strong,nonatomic) NSString *area;

@property (strong,nonatomic) NSString *areaID;
/**详细地址*/
@property (strong,nonatomic) NSString *addressDetail;
/**申请人电话*/
@property (strong,nonatomic) NSString *applyTel;
/**申请人手机*/
@property (strong,nonatomic) NSString *applyPhone;
/**对账负责人电话*/
@property (strong,nonatomic) NSString *payTel;
/**对账负责人手机*/
@property (strong,nonatomic) NSString *payPhone;
/**月采购金额范围*/
@property (strong,nonatomic) NSString *type;
/**备注说明*/
@property (strong,nonatomic) NSString *info;

@end


