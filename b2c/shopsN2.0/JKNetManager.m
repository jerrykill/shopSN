//
//  JKNetManager.m
//  shopsN2.0
//
//  Created by imac on 2017/7/26.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "JKNetManager.h"

@implementation JKNetManager

+ (void)jk_hasNetWork:(void (^)(bool))hasNet {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                hasNet(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                hasNet(YES);
                break;
        }
    }];
    //结束监听
    [manager stopMonitoring];
}


@end
