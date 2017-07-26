//
//  YOrderGoodListViewController.h
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YGoodShopModel.h"

@protocol YOrderGoodListViewControllerDelegate <NSObject>

- (void)orderListFreight:(NSString *)freight;

@end

@interface YOrderGoodListViewController : YBaseViewController

@property (strong,nonatomic) NSMutableArray <YShopGoodModel*>*datas;

@property (weak,nonatomic) id<YOrderGoodListViewControllerDelegate>delegate;

@end
