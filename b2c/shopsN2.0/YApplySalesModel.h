//
//  YApplySalesModel.h
//  shopsN2.0
//
//  Created by imac on 2017/6/5.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YApplySalesModel : NSObject
/**订单id*/
@property (strong,nonatomic) NSString *orderId;
/**商品id*/
@property (strong,nonatomic) NSString *goodId;
/**服务类型*/
@property (strong,nonatomic) NSString *type;
/**申请金额*/
@property (strong,nonatomic) NSString *price;
/**申请数量*/
@property (strong,nonatomic) NSString *num;
/**详情*/
@property (strong,nonatomic) NSString *info;
/**图片集*/
@property (strong,nonatomic) NSMutableArray *goodArr;

@end
