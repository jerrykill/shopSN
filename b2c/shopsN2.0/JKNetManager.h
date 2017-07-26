//
//  JKNetManager.h
//  shopsN2.0
//
//  Created by imac on 2017/7/26.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"


@interface JKNetManager : NSObject

+ (void)jk_hasNetWork:(void(^)(bool has))hasNet;


@end
