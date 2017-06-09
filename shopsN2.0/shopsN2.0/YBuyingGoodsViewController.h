//
//  YBuyingGoodsViewController.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YBaseViewController.h"
#import "YBuyingGoodModel.h"

@protocol YBuyingGoodsViewControllerDelegate <NSObject>

-(void)chooseGoodList:(NSMutableArray<YBuyingGoodModel*>*)data;

@end

@interface YBuyingGoodsViewController : YBaseViewController

@property (weak,nonatomic) id<YBuyingGoodsViewControllerDelegate>delegate;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *orderId;

@property (strong,nonatomic) NSString *isHave;
/**是否可以编辑*/
@property (strong,nonatomic) NSString *status;

@end
