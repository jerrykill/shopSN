//
//  UdStorage.h
//  shopSN
//
//  Created by yisu on 16/9/6.
//  Copyright © 2016年 yisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UdStorage : NSObject

// NSUserDefaults 存储数据   获取数据
+(void)storageObject:(id)object forKey:(NSString*)key;

+(id)getObjectforKey:(NSString*)key;



@end
