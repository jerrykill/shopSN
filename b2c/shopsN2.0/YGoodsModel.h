//
//  YGoodsModel.h
//  shopsN
//
//  Created by imac on 2016/11/23.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGoodsModel : NSObject
/*商品id*/
@property (strong,nonatomic) NSString *goodId;

/**商品标题*/
@property (strong,nonatomic) NSString *goodTitle;
/**商品详情*/
@property (strong,nonatomic) NSString *goodDesc;
/**商品价格*/
@property (strong,nonatomic) NSString *goodMoney;
/**商品图片*/
@property (strong,nonatomic) NSString *goodUrl;
/**商品库存*/
@property (strong,nonatomic) NSString *goodstock;
/**商品评价人数*/
@property (strong,nonatomic) NSString *goodeValuateCount;
/**商品老的价格*/
@property (strong,nonatomic) NSString *goodOldMoney;
/**活动图标*/
@property (strong,nonatomic) NSString *activeName;
/**商品颜色*/
@property (strong,nonatomic) NSString *color;
/**商品规格*/
@property (strong,nonatomic) NSString *goodSize;
/**商品包装方式*/
@property (strong,nonatomic) NSString *goodWay;
/**是否常购清单*/
@property (assign,nonatomic) BOOL isBuy;

@end
