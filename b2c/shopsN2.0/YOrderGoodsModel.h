//
//  YOrderGoodsModel.h
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YOrderGoodModel;

@interface YOrderGoodsModel : NSObject

@property (strong,nonatomic) NSMutableArray <YOrderGoodModel*>*dataArr;

@end

@interface YOrderGoodModel : NSObject
/**商品id*/
@property (strong,nonatomic) NSString *goodId;
/**商品名称*/
@property (strong,nonatomic) NSString *goodName;
/**商品图片*/
@property (strong,nonatomic) NSString *goodUrl;
/**商品规格*/
@property (strong,nonatomic) NSString *goodSize;
/**商品颜色*/
@property (strong,nonatomic) NSString *color;
/**商品数量*/
@property (strong,nonatomic) NSString *num;
/**商品实际价格*/
@property (strong,nonatomic) NSString *goodMoney;
/**标价*/
@property (strong,nonatomic) NSString *goodOldMoney;
/**商品包装方式*/
@property (strong,nonatomic) NSString *goodWay;
/**商品仓库id*/
@property (strong,nonatomic) NSString *location;


@end
