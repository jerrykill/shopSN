//
//  YGiftSureOrderViewController.h
//  shopsN
//
//  Created by imac on 2017/1/9.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YGoodShopModel.h"
#import "YAddressModel.h"

@interface YGiftSureOrderViewController : YBaseViewController

@property (strong,nonatomic) NSArray<YShopGoodModel *> *datas;

@property (strong,nonatomic) NSString *totalPay;

@property (strong,nonatomic) NSString *freight;

@property (strong,nonatomic) NSString *totalIntegral;

@property (strong,nonatomic) NSString *personIntegral;//当前积分

@property (strong,nonatomic) YAddressModel *address;

@end
