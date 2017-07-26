//
//  YGoodCollectAndCartService.h
//  shopsN
//
//  Created by imac on 2017/2/24.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGoodCollectAndCartService : NSObject
/**添加到收藏*/
+ (void)MakeGoodCollect:(NSDictionary*)params;
/**添加到购物车*/
+ (void)MakeGoodShopCart:(NSDictionary*)params;


@end
