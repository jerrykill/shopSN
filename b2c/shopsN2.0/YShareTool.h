//
//  YShareTool.h
//  shopsN
//  分享类
//  Created by imac on 2017/1/13.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YShareTool : NSObject

+ (void)shareMessage:(NSString *)text title:(NSString *)title Url:(NSString *)URL type:(NSInteger)sender;

@end
