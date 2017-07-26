//
//  YGiftGoodBottomView.h
//  shopsN
//
//  Created by imac on 2017/1/9.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGiftGoodModel.h"

@protocol YGiftGoodBottomViewDelegate <NSObject>

-(void)makeExchange;

@end

@interface YGiftGoodBottomView : BaseView


@property (strong,nonatomic) YGiftGoodModel *model;

@property (weak,nonatomic) id<YGiftGoodBottomViewDelegate>delegate;

@end
