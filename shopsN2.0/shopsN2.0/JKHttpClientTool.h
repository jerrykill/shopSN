//
//  JKHttpClientTool.h
//  shopsN
//
//  Created by imac on 2017/5/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface JKHttpClientTool : NSObject

+ (AFHTTPSessionManager *)sharedManager;

@end
