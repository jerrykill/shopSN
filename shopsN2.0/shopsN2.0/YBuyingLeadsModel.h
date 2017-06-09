//
//  YBuyingLeadsModel.h
//  shopsN
//
//  Created by imac on 2017/2/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBuyingGoodModel.h"

@interface YBuyingLeadsModel : NSObject
/**需求单id*/
@property (strong,nonatomic) NSString *purchaseId;
/**标题*/
@property (strong,nonatomic) NSString *title;
/**类型*/
@property (strong,nonatomic) NSString *type;
/**商品信息*/
@property (strong,nonatomic) NSString *godInfo;
/**总预算*/
@property (strong,nonatomic) NSString *total;
/**联系人*/
@property (strong,nonatomic) NSString *cusName;
/**联系电话*/
@property (strong,nonatomic) NSString *phone;
/**收货日期*/
@property (strong,nonatomic) NSString *date;
/**支付方式*/
@property (strong,nonatomic) NSString *payType;
/**发票信息*/
@property (strong,nonatomic) NSString *billType;
/**补充说明*/
@property (strong,nonatomic) NSString *info;
/**商品数组*/
@property (strong,nonatomic) NSMutableArray<YBuyingGoodModel*>*goodArr;
/**创建时间*/
@property (strong,nonatomic) NSString *creatTime;
/**状态*/
@property (strong,nonatomic) NSString *status;

@end
