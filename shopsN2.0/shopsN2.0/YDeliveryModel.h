//
//  YDeliveryModel.h
//  shopsN
//
//  Created by imac on 2017/1/18.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDeliveryModel : NSObject
/**付款单位*/
@property (strong,nonatomic) NSString *payName;
/**交货单*/
@property (strong,nonatomic) NSString *orderNo;
/**订单类型*/
@property (strong,nonatomic) NSString *orderType;
/**过账日期*/
@property (strong,nonatomic) NSString *date;
/**金额*/
@property (strong,nonatomic) NSString *money;
/**客户编号*/
@property (strong,nonatomic) NSString *payId;
/**创建日期*/
@property (strong,nonatomic) NSString *creatDate;
/**销售单位*/
@property (strong,nonatomic) NSString *saleName;
/**开票日期*/
@property (strong,nonatomic) NSString *billDate;

@end
