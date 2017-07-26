//
//  YShopGoodColorAndWayCheckView.h
//  shopsN
//
//  Created by imac on 2016/12/17.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "BaseView.h"
#import "YGoodDetailModel.h"
#import "YGoodShopModel.h"
#import "YSGoodTypeEditModel.h"

@protocol YShopGoodColorAndWayCheckViewDelegate <NSObject>

-(void)changeModel:(YShopGoodModel*)model index:(NSInteger)tag;


@end

@interface YShopGoodColorAndWayCheckView : BaseView

@property (strong,nonatomic) YGoodDetailModel *model;

@property (strong,nonatomic) YShopGoodModel *checkModel;

@property (strong,nonatomic) NSMutableArray<YSGoodTypeEditModel*> *goodList;

@property (weak,nonatomic) id<YShopGoodColorAndWayCheckViewDelegate>delegate;

@end
