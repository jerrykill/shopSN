//
//  YOrderEvalueModel.h
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YOrderEvalueModel : NSObject
/**商品图片*/
@property (strong,nonatomic) NSString *goodUrl;
/**评价内容*/
@property (strong,nonatomic) NSString *evalue;
/**图集*/
@property (strong,nonatomic) NSMutableArray *imageArr;
/**星级*/
@property (strong,nonatomic) NSString *star;
/**商品id*/
@property (strong,nonatomic) NSString *goodId;
/**订单id*/
@property (strong,nonatomic) NSString *orderId;

@end
