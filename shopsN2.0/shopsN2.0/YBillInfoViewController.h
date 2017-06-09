//
//  YBillInfoViewController.h
//  shopsN
//
//  Created by imac on 2016/12/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YOrderBillModel.h"

@protocol YBillInfoViewControllerDelegate <NSObject>

-(void)getInfo:(YOrderBillModel*)data;

@end

@interface YBillInfoViewController : YBaseViewController

@property (strong,nonatomic) YOrderBillModel *billModel;

@property (weak,nonatomic) id<YBillInfoViewControllerDelegate>delegate;

@end
