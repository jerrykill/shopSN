//
//  YGoodDetailModel.h
//  shopsN
//
//  Created by imac on 2016/12/13.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YGoodActiveModel,YGoodSizeModel,YSSizeModel,YSGoodLocationModel;

@interface YGoodDetailModel : NSObject
/**商品id*/
@property (strong,nonatomic) NSString *goodId;
/**商品名称*/
@property (strong,nonatomic) NSString *goodTitle;
/**商品价格*/
@property (strong,nonatomic) NSString *goodMoney;
/**商品原价*/
@property (strong,nonatomic) NSString *goodOldMoney;
/**商品图标*/
@property (strong,nonatomic) NSString *goodUrl;
/**商品图集*/
@property (strong,nonatomic) NSMutableArray *imageArr;
/**商品促销时间*/
@property (strong,nonatomic) NSString *time;
/**商品促销活动*/
@property (strong,nonatomic) NSMutableArray<YGoodActiveModel*>*list;
/**商品发货点*/
@property (strong,nonatomic) NSMutableArray<YSGoodLocationModel*>*location;
/**商品颜色集合*/
@property (strong,nonatomic) NSMutableArray *color;
/**商品规格集合*/
@property (strong,nonatomic) NSMutableArray<YGoodSizeModel*> *goodSize;
/**商品库存*/
@property (strong,nonatomic) NSString *stock;
/**图文详情*/
@property (strong,nonatomic) NSString *picUrl;
/**是否收藏*/
@property (strong,nonatomic) NSString *isCollected;
/**活动结束时间*/
@property (strong,nonatomic) NSString *endTime;

@end

@interface YGoodActiveModel : NSObject
/**活动标题*/
@property (strong,nonatomic) NSString *title;
/**活动详情*/
@property (strong,nonatomic) NSString *info;

@end

@interface YGoodSizeModel : NSObject;
/**规格类名*/
@property (strong,nonatomic) NSString *typeName;
/**规格*/
@property (strong,nonatomic) NSMutableArray<YSSizeModel*> *size;

/**实际价格*/
@property (strong,nonatomic) NSString *money;
/**原价*/
@property (strong,nonatomic) NSString *oldMoney;

@end

@interface YSSizeModel : NSObject

/**规格名*/
@property (strong,nonatomic) NSString *name;
/**规格id*/
@property (strong,nonatomic) NSString *sizeId;

@end

@interface YSGoodLocationModel : NSObject
/**仓库名*/
@property (strong,nonatomic) NSString *name;
/**仓库id*/
@property (strong,nonatomic) NSString *locationId;

@end



