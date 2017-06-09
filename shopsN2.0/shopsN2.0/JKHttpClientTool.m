//
//  JKHttpClientTool.m
//  shopsN
//  请求类封装（防止af3.x的内存泄露问题）
//  Created by imac on 2017/5/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "JKHttpClientTool.h"

@interface JKHttpClientTool ()

@end

static AFHTTPSessionManager *_manager;

@implementation JKHttpClientTool

+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 30;
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        _manager.responseSerializer = response;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    });
    return _manager;
}

@end
