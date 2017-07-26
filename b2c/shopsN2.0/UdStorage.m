//
//  UdStorage.m
//  shopSN
//
//  Created by yisu on 16/9/6.
//  Copyright © 2016年 yisu. All rights reserved.
//

#import "UdStorage.h"

@implementation UdStorage

+(void)storageObject:(id)object forKey:(NSString*)key{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:object forKey:key];
    [ud synchronize];
}

+(id)getObjectforKey:(NSString*)key{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}



@end
