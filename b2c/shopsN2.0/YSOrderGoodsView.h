//
//  YSOrderGoodsView.h
//  shopsN2.0
//
//  Created by imac on 2017/7/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YSOrderModel.h"

@protocol YSOrderGoodsViewDelegate <NSObject>

@optional
- (void)makeOrdersRemove:(NSInteger)sender;

@end

@interface YSOrderGoodsView : BaseView

@property (strong,nonatomic) YSOrderModel *model;

@property (weak,nonatomic) id<YSOrderGoodsViewDelegate>delegate;

@end
