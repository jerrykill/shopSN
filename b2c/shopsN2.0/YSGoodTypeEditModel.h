//
//  YSGoodTypeEditModel.h
//  shopsN
//
//  Created by imac on 2017/3/3.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSGoodTypeEditModel : NSObject
/**商品id*/
@property (strong,nonatomic) NSString *goodsId;
/**商品价格*/
@property (strong,nonatomic) NSString *goodMoney;
/**库存*/
@property (strong,nonatomic) NSString *stock;
/**标识*/
@property (strong,nonatomic) NSString *key;

@end
