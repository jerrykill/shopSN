//
//  YPlistAddressTool.h
//  shopsN
//
//  Created by imac on 2017/3/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPlistAddressModel.h"

@interface YPlistAddressTool : NSObject

+(void)saveThePlistAddress:(NSArray*)data;

+(NSMutableArray<YPlistAddressModel*>*)getTheDataAddress;

@end
