//
//  JKHistory.h
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKHistory : NSObject

+(void)Savetext:(NSString *)str;

+(NSMutableArray *)getHistory;

+(void)clearHistory;

@end
