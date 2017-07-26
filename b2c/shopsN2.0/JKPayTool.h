//
//  JKPayTool.h
//  shopsN2.0
//
//  Created by imac on 2017/6/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^back)();

@interface JKPayTool : NSObject
/**
 * 支付宝支付
 * @param orderNum 订单号
 * @param title  商品描述
 * @param money  价格
 */
+ (void)payOrderWithOrderId:(NSString *)orderNum title:(NSString*)title price:(NSString*)money complete:(back)complete;

/**
 * 微信支付
 * @param orderNum 订单号
 * @param title  商品描述
 * @param money  价格
 */
+ (void)payOrderWxOrderId:(NSString *)orderNum title:(NSString*)title price:(NSString*)money complete:(back)complete;

@end
