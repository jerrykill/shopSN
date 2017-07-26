//
//  YGiftGoodModel.h
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGiftGoodSpecModel;
@interface YGiftGoodModel : NSObject
/**商品id*/
@property (strong,nonatomic) NSString *goodId;
/**商品名称*/
@property (strong,nonatomic) NSString *goodTitle;
/**图片*/
@property (strong,nonatomic) NSString *goodUrl;
/**积分*/
@property (strong,nonatomic) NSString *integral;
/**市场参考价*/
@property (strong,nonatomic) NSString *money;
/**品牌*/
@property (strong,nonatomic) NSString *brand;
/**型号*/
@property (strong,nonatomic) NSString *model;
/**基本单位*/
@property (strong,nonatomic) NSString *unit;
/**包装*/
@property (strong,nonatomic) NSString *way;
/**规格*/
@property (strong,nonatomic) NSString *goodSize;
/**图集*/
@property (strong,nonatomic) NSMutableArray *imageArr;
/**换购金额*/
@property (strong,nonatomic) NSString *exchangeMoney;

@property (strong,nonatomic) NSMutableArray <YGiftGoodSpecModel*>*list;

@end

@interface YGiftGoodSpecModel : NSObject
/**类型*/
@property (strong,nonatomic) NSString *name;
/**详情*/
@property (strong,nonatomic) NSString *item;

@end
