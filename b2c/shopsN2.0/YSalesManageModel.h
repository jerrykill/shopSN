//
//  YSalesManageModel.h
//  shopsN
//
//  Created by imac on 2017/1/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSalesManageModel : NSObject
/**售后编号*/
@property (strong,nonatomic) NSString *salesId;
/**订单编号*/
@property (strong,nonatomic) NSString *orderId;
/**售后类型*/
@property (strong,nonatomic) NSString *type;
/**售后要求*/
@property (strong,nonatomic) NSString *ask;
/**货物状态*/
@property (strong,nonatomic) NSString *status;
/**申请时间*/
@property (strong,nonatomic) NSString *applyTime;
/**撤销时间*/
@property (strong,nonatomic) NSString *cancelTime;
/**金额*/
@property (strong,nonatomic) NSString *money;
/**问题描述*/
@property (strong,nonatomic) NSString *info;
/**售后状态*/
@property (strong,nonatomic) NSString *manageSatus;
@end
