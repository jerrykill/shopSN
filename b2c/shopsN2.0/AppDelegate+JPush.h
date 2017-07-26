//
//  AppDelegate+JPush.h
//  shopsN
//
//  Created by imac on 2017/3/17.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)

-(void)initJPushService:(UIApplication*)application WithOption:(NSDictionary*)launchOptions;

@end
