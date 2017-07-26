//
//  YGoodColorAndWayCheckView.h
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGoodDetailModel.h"
#import "YOrderGoodsModel.h"
#import "YGoodShopModel.h"

@protocol YGoodColorAndWayCheckViewdelegate <NSObject>

-(void)chooseModel:(YShopGoodModel*)model;

-(void)addShop;

-(void)PayNow;


@end

@interface YGoodColorAndWayCheckView : BaseView

@property (strong,nonatomic) YGoodDetailModel *model;

@property (strong,nonatomic) YShopGoodModel *checkModel;


@property (weak,nonatomic) id<YGoodColorAndWayCheckViewdelegate>delegate;

@end
