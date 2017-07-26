//
//  YShopCartTotalModel.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YShopCartTotalModel : NSObject
/**总价格*/
@property (strong,nonatomic) NSString *totalMoney;
/**总数量*/
@property (strong,nonatomic) NSString *chooseCount;
/**优惠价格*/
@property (strong,nonatomic) NSString *CouponMoney;

@end
