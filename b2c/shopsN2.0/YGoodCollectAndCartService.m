//
//  YGoodCollectAndCartService.m
//  shopsN
//  添加购物车和收藏接口封装
//  Created by imac on 2017/2/24.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodCollectAndCartService.h"

@implementation YGoodCollectAndCartService

+(void)MakeGoodCollect:(NSDictionary *)params{
    [JKHttpRequestService POST:@"Cart/add_collection" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           [SXLoadingView showAlertHUD:@"加入收藏成功" duration:1];
        }
      } failure:^(NSError *error) {

      } animated:NO];
}

+ (void)MakeGoodShopCart:(NSDictionary *)params{
   [JKHttpRequestService POST:@"Cart/add_cart" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
       if (succe) {
           [SXLoadingView showAlertHUD:@"加入购物车成功" duration:1];
           [[NSNotificationCenter defaultCenter] postNotificationName:YSGoodAddtoShopCart object:nil userInfo:nil];
       }
   } failure:^(NSError *error) {

   } animated:NO];
}



@end
