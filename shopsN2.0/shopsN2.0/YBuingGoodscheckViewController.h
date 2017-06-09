//
//  YBuingGoodscheckViewController.h
//  shopsN
//
//  Created by imac on 2017/3/9.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YBuyingGoodModel.h"

@protocol YBuingGoodscheckViewControllerDelegate <NSObject>

-(void)chooseGood:(YBuyingGoodModel*)data;

@end

@interface YBuingGoodscheckViewController : YBaseViewController

@property (weak,nonatomic) id<YBuingGoodscheckViewControllerDelegate>delegate;


@end
