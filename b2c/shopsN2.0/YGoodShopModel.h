//
//  YGoodShopModel.h
//  shopsN
//
//  Created by imac on 2016/11/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGoodDetailModel.h"

@class YShopGoodModel,YGoodTypeModel;

@interface YGoodShopModel : NSObject
/**是否全选*/
@property (nonatomic) BOOL isAllChoose;
/**是否编辑*/
@property (nonatomic) BOOL isEdit;

@property (strong,nonatomic) NSMutableArray<YShopGoodModel*> *dataArr;

@end

@interface YShopGoodModel : NSObject

/**购物车id*/
@property (strong,nonatomic) NSString *shopCartId;
/**商品id*/
@property (strong,nonatomic) NSString *goodId;

/**商品图片*/
@property (strong,nonatomic) NSString *goodUrl;
/**商品标题*/
@property (strong,nonatomic) NSString *goodTitle;
/**商品型号*/
@property (strong,nonatomic) NSString *goodType;
/**商品颜色*/
@property (strong,nonatomic) NSString *goodColor;
/**商品包装方式*/
@property (strong,nonatomic) NSString *goodWay;
/**商品价格*/
@property (strong,nonatomic) NSString *goodMoney;
/**兑换积分*/
@property (strong,nonatomic) NSString *goodIntegral;
/**商品数量*/
@property (strong,nonatomic) NSString *goodCount;
/**规格数组*/
@property (strong,nonatomic) NSMutableArray<YGoodTypeModel*> *goodTypeArr;

/**规格选择器数据*/
@property (strong,nonatomic) NSMutableArray<YGoodSizeModel*> *chooseList;
/**是否编辑*/
@property (nonatomic) BOOL isEditing;
/**是否选中*/
@property (nonatomic) BOOL isChoose;
/**仓库*/
@property (strong,nonatomic) NSString *wareHouse;
/**仓库id*/
@property (strong,nonatomic) NSString *wareHouseId;
@end

@interface YGoodTypeModel : NSObject

/**规格类名*/
@property (strong,nonatomic) NSString *name;
/**规格*/
@property (strong,nonatomic) NSString *size;
/**规格id*/
@property (strong,nonatomic) NSString *sizeId;

@end
