//
//  YReturnsOrdersModel.h
//  shopsN
//
//  Created by imac on 2017/1/4.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YReturnsGoodModel,YReturnsSpeedInfoModel;
@interface YReturnsOrdersModel : NSObject
/**订单单号*/
@property (strong,nonatomic) NSString *orderId;
/**时间*/
@property (strong,nonatomic) NSString *createDate;
/**状态*/
@property (strong,nonatomic) NSString *status;
/**服务单号*/
@property (strong,nonatomic) NSString *serviceId;
/**申请时间*/
@property (strong,nonatomic) NSString *applyTime;
/**问题描述*/
@property (strong,nonatomic) NSString *info;
/**审核留言*/
@property (strong,nonatomic) NSString *auditInfo;

@property (strong,nonatomic) NSArray <YReturnsSpeedInfoModel*>*datas;

@property (strong,nonatomic) NSArray <YReturnsGoodModel*>*list;

@end

@interface YReturnsGoodModel : NSObject
/**图片*/
@property (strong,nonatomic) NSString *imageName;
/**商品名*/
@property (strong,nonatomic) NSString *title;
/**数量*/
@property (strong,nonatomic) NSString *num;
/**状态*/
@property (strong,nonatomic) NSString *status;
/**商品编号*/
@property (strong,nonatomic) NSString *goodId;
/**时间*/
@property (strong,nonatomic) NSString *date;
/**申请金额*/
@property (strong,nonatomic) NSString *applyMoney;

@end

@interface YReturnsSpeedInfoModel : NSObject
/**审核人*/
@property (strong,nonatomic) NSString *auditor;
/**审核时间*/
@property (strong,nonatomic) NSString *auditTime;
/**审核内容*/
@property (strong,nonatomic) NSString *auditMessage;

@end
