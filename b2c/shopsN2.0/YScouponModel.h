//
//  YScouponModel.h
//  shopsN
//
//  Created by imac on 2017/4/24.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YScouponModel : NSObject
/**优惠券id*/
@property (strong,nonatomic) NSString *ticketId;
/**优惠券名称*/
@property (strong,nonatomic) NSString *name;
/**优惠值*/
@property (strong,nonatomic) NSString *value;
/**优惠条件*/
@property (strong,nonatomic) NSString *condition;
/**开始时间*/
@property (strong,nonatomic) NSString *startTime;
/**结束时间*/
@property (strong,nonatomic) NSString *endTime;

@end
