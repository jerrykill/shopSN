//
//  YSureOrderViewController.h
//  shopsN
//
//  Created by imac on 2016/12/21.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YGoodShopModel.h"
#import "YAddressModel.h"

@interface YSureOrderViewController : YBaseViewController

@property (strong,nonatomic) NSMutableArray<YShopGoodModel *> *datas;

@property (strong,nonatomic) NSString *totalPay;

@property (strong,nonatomic) NSString *freight;

@property (strong,nonatomic) NSString *personIntegral;//当前积分

@property (strong,nonatomic) YAddressModel *address;

@property (strong,nonatomic) NSString *buyType;

@end
