//
//  YSOrderModel.h
//  shopsN
//
//  Created by imac on 2017/4/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGoodShopModel.h"

@interface YSOrderModel : NSObject
/**订单id*/
@property (strong,nonatomic) NSString *orderId;
/**显示id*/
@property (strong,nonatomic) NSString *showId;
/**实付款*/
@property (strong,nonatomic) NSString *payMoney;
/**下单时间*/
@property (strong,nonatomic) NSString *createTime;
/**支付时间*/
@property (strong,nonatomic) NSString *payTime;
/**发货时间*/
@property (strong,nonatomic) NSString *sendTime;
/**订单状态*/
@property (strong,nonatomic) NSString *orderStatus;
/**评价状态*/
@property (strong,nonatomic) NSString *comment;
/**多商品图照片组*/
@property (strong,nonatomic) NSArray *imageArr;
/**多少类商品*/
@property (strong,nonatomic) NSString *goodCount;
/**单类商品标题*/
@property (strong,nonatomic) NSString *title;
/**单类商品规格数组*/
@property (strong,nonatomic) NSMutableArray <YGoodTypeModel*>*typeArr;
/**运费*/
@property (strong,nonatomic) NSString *freight;
/**备注*/
@property (strong,nonatomic) NSString *orderInfo;
/**支付方式*/
@property (strong,nonatomic) NSString *payType;
/**发票类型*/
@property (strong,nonatomic) NSString *invoice;
/**配送方式*/
@property (strong,nonatomic) NSString *sendType;
/**优惠券金额*/
@property (strong,nonatomic) NSString *couponMoney;

@end
