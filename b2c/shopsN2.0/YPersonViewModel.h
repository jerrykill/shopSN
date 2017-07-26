//
//  YPersonViewModel.h
//  shopsN
//
//  Created by imac on 2017/2/22.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPersonViewModel : NSObject
/**头像*/
@property (strong,nonatomic) NSString *headImage;
/**昵称*/
@property (strong,nonatomic) NSString *nick_name;
/**余额*/
@property (strong,nonatomic) NSString *balance;
/**优惠券*/
@property (strong,nonatomic) NSString *coupon;
/**积分*/
@property (strong,nonatomic) NSString *integral;
/**发票*/
@property (strong,nonatomic) NSString *bill;
/**余单*/
@property (strong,nonatomic) NSString *leaveBill;
@end
