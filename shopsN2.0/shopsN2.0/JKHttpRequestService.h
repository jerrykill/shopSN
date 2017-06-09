//
//  JKHttpRequestService.h
//  shopsN
//
//  Created by imac on 2017/2/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "JKHttpClientTool.h"

typedef void(^SuccessCallBack)(id responseObject,BOOL succe,NSDictionary *jsonDic);
typedef  void (^FailureCallBack)(NSError *error);

@interface JKHttpRequestService : NSObject

//单纯的获取数据
+(void)GET:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;
+ (void)POST:(NSString*)path withParameters:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;
+(void)POST:(NSString *)path Params:(NSDictionary *)params NSData:(NSData *)imageData key:(NSString *)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;
//多图上传
+ (void)POST:(NSString *)path Params:(NSDictionary*)params NSArray:(NSArray<NSData*>*)imageArr key:(NSString*)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated;

@end
