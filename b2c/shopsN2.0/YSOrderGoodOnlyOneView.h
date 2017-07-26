//
//  YSOrderGoodOnlyOneView.h
//  shopsN2.0
//
//  Created by imac on 2017/7/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YSOrderModel.h"

@protocol YSOrderGoodOnlyOneViewDelegate <NSObject>

@optional
- (void)makeOrderDelete:(NSInteger)sender;

@end


@interface YSOrderGoodOnlyOneView : BaseView

@property (strong,nonatomic) YSOrderModel *model;

@property (weak,nonatomic) id<YSOrderGoodOnlyOneViewDelegate>delegate;

@end
