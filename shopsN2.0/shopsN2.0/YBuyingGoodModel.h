//
//  YBuyingGoodModel.h
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBuyingGoodModel : NSObject

/**商品id*/
@property (strong,nonatomic) NSString *goodID;
/**商品编号*/
@property (strong,nonatomic) NSString *goodNo;
/**商品名称*/
@property (strong,nonatomic) NSString *goodName;
/**商品分类*/
@property (strong,nonatomic) NSString *goodClass;
/**商品数量*/
@property (strong,nonatomic) NSString *goodCount;
/**预算单价*/
@property (strong,nonatomic) NSString *goodMoney;
/**说明*/
@property (strong,nonatomic) NSString *goodInfo;
/**照片*/
@property (strong,nonatomic) NSMutableArray *imageArr;

@end
