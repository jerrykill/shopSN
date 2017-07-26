//
//  YPromotionBOXScrollView.h
//  shopsN
//
//  Created by imac on 2016/12/12.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGoodsModel.h"

@protocol YPromotionBOXScrollViewDelegate <NSObject>

-(void)chooseGood:(YGoodsModel *)model;

@end

@interface YPromotionBOXScrollView : BaseView

@property (strong,nonatomic) NSMutableArray<YGoodsModel*> *goodArr;

@property (weak,nonatomic) id<YPromotionBOXScrollViewDelegate>delegate;
@end
