//
//  YApplyDrawbackViewController.h
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YSOrderModel.h"

@interface YApplyDrawbackViewController : YBaseViewController

@property (strong,nonatomic) NSArray <YShopGoodModel*>*goodArr;

@property (strong,nonatomic) YSOrderModel *order;

@end
