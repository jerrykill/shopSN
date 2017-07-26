//
//  AppDelegate.m
//  shopsN
//
//  Created by imac on 2016/11/22.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "AppDelegate.h"
#import "YSTabbarViewController.h"
// iOS10注册APNs所需头 件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max 
#import <UserNotifications/UserNotifications.h> 
#endif
// 如果需要使 idfa功能所需要引 的头 件(可选)
#import <AdSupport/AdSupport.h>
#import "YSBannerView.h"

#import "YSAnnounceDetailViewController.h"
#import "YMessageDetailViewController.h"

#import "AppDelegate+JPush.h"
#import "YJkPushTool.h"
#import "JKHttpRequestService.h"

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@property (assign,nonatomic) BOOL isAlert;

@property (assign,nonatomic) BOOL isShake;

@property (assign,nonatomic) BOOL isRound;

@property (assign,nonatomic) NSInteger  selectIndex;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    if (IsNull([UdStorage getObjectforKey:Userid])||IsNilString([UdStorage getObjectforKey:Userid])) {
        [UdStorage storageObject:@"" forKey:Userid];
    }
    [UdStorage storageObject:@"" forKey:orderPayId];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       //第三方
       [ShareSDK registerApp:MobKey activePlatforms:@[@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
           switch (platformType) {
               case SSDKPlatformTypeQQ:
                   [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                   break;
               case SSDKPlatformTypeWechat:
                   [ShareSDKConnector connectWeChat:[WXApi class]];
                   break;
               case SSDKPlatformTypeSinaWeibo:
                   [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                   break;
               default:
                   break;
           }
       } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
           switch (platformType) {
               case SSDKPlatformTypeQQ:
               {
                   [appInfo SSDKSetupQQByAppId:QQID appKey:QQKEY authType:SSDKAuthTypeBoth];
               }
                   break;
               case SSDKPlatformTypeWechat:
               {
                   [appInfo SSDKSetupWeChatByAppId:WXID  appSecret:WXSecret];
               }
                   break;
               case SSDKPlatformTypeSinaWeibo:
               {
                   [appInfo SSDKSetupSinaWeiboByAppKey:WbID appSecret:WbSecret redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
               }
                   break;
               default:
                   break;
           }
       }];
       //微信支付
       [WXApi registerApp:WXID withDescription:@"youshen1.0"];
       //极光推送
       _isAlert = YES;
       _isRound =YES;
       _isShake = YES;
       [self initJPushService:application WithOption:launchOptions];

       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabSelect:) name:YSTabBarChangeIndex object:nil];
       //环信客服
       [[EaseMob sharedInstance] registerSDKWithAppKey:HXKey apnsCertName:@""];
       [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
   });
  //第三方键盘
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    YSTabbarViewController *ysTabBar = [[YSTabbarViewController alloc]init];
    self.window.rootViewController = ysTabBar;
    return YES;
}
#pragma mark ==获取点击的tabbar==
-(void)tabSelect:(NSNotification*)info{
    NSArray *arr = info.object;
    NSString *str = arr[0];
    _selectIndex =  [str integerValue];
}
#pragma mark ==修改推送类型==
-(void)changeNoti:(NSNotification*)info{
    NSDictionary *arr =info.object;
   NSNumber *num = arr[@"alert"];
    _isAlert = [num boolValue];
    NSNumber *ring = arr[@"sound"];
    _isRound = [ring boolValue];
    NSNumber *shake =arr[@"shake"];
    _isShake = [shake boolValue];
    if (!_isAlert) {
        UIViewController *vc = [self getCurrentVC];
        for (id obj in vc.view.subviews) {
            if ([obj isKindOfClass:[YSBannerView class]]) {
                [obj removeFromSuperview];
            }
        }
    }
}
#pragma mark ==运行时推送==
- (void)showNotiView:(NSString *)title type:(NSString*)type{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseNoti:)];
    YSBannerView *bannerV = [[YSBannerView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 40)];
    UIViewController *vc = [self getCurrentVC];
    [vc.view addSubview:bannerV];
    [vc.view bringSubviewToFront:bannerV];
    bannerV.title = title;
    bannerV.type = type;
    [bannerV addGestureRecognizer:tap];

}

-(void)chooseNoti:(UITapGestureRecognizer*)tap{
    YSBannerView *banner=(YSBannerView*)tap.view;
    if (banner.type) {
        YSAnnounceDetailViewController *vc = [[YSAnnounceDetailViewController alloc]init];
        [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else{
        YMessageDetailViewController *vc = [[YMessageDetailViewController alloc]init];
        [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
    [banner removeFromSuperview];
}

#pragma mark - 私有方法->
//获取当前屏幕显示的ViewController
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[_selectIndex];
        result=nav.childViewControllers.lastObject;
    }else{
        result = window.rootViewController;
    }
    return result;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",deviceToken);
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    if (_isRound) {
        YJkPushTool *single = [YJkPushTool sharedInstanceForSound];
        [single play];
    }
    if (_isShake) {
        YJkPushTool *shake = [YJkPushTool sharedInstanceForVibrate];
        [shake play];
    }
    if (_isAlert) {
        UIViewController *vc = [self getCurrentVC];
        for (id obj in vc.view.subviews) {
            if ([obj isKindOfClass:[YSBannerView class]]) {
                [obj removeFromSuperview];
            }
        }
        [self showNotiView:userInfo[@"aps"][@"alert"][@"body"] type:@"1"];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[UPPaymentControl defaultControl]
     handlePaymentResult:url
     completeBlock:^(NSString *code, NSDictionary *data) {
         //结果code为成功时，先校验签名，校验成功后做后续处理
         if([code isEqualToString:@"success"]) {
             //判断签名数据是否存在
             if(data == nil){
                 //如果没有签名数据，建议商户app后台查询交易结果
                 return;
             }
             //数据从NSDictionary转换为NSString
             NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                options:0
                                                                  error:nil];
             NSString *sign = [[NSString alloc]
                               initWithData:signData
                               encoding:NSUTF8StringEncoding];
             NSLog(@"Sign: %@", sign);
             //验签证书同后台验签证书
             //此处的verify，商户需送去商户后台做验签
             //支付成功且验签成功，展示支付成功提示
             //验签失败，交易结果数据被篡改，商户app后台查询交易结果
         } else if([code isEqualToString:@"fail"]) {
             //交易失败
         } else if([code isEqualToString:@"cancel"]) {
             //交易取消
         }
     }];        //调用其他SDK，例如支付宝SDK等
        if ([sourceApplication isEqualToString:@"com.tencent.xin"]||[sourceApplication isEqualToString:@"pay"]) {
            //微信支付回调
            return [WXApi handleOpenURL:url delegate:self];
        }

        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                NSString *status = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
                if ([status isEqualToString:@"9000"]) {
                    [self checkPay];
                }
            }];
        }
        return YES;
    
}

//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    [[UPPaymentControl defaultControl]
     handlePaymentResult:url
     completeBlock:^(NSString *code, NSDictionary *data) {
         //结果code为成功时，先校验签名，校验成功后做后续处理
         if([code isEqualToString:@"success"]) {
             //判断签名数据是否存在
             if(data == nil){
                 //如果没有签名数据，建议商户app后台查询交易结果
                 return;
             }
             //数据从NSDictionary转换为NSString
             NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                            options:0
                              error:nil];
             NSString *sign = [[NSString alloc]
                               initWithData:signData
                               encoding:NSUTF8StringEncoding];
             NSLog(@"Sign: %@", sign);
             //验签证书同后台验签证书
             //此处的verify，商户需送去商户后台做验签
             //支付成功且验签成功，展示支付成功提示
             //验签失败，交易结果数据被篡改，商户app后台查询交易结果
         } else if([code isEqualToString:@"fail"]) {
             //交易失败
         } else if([code isEqualToString:@"cancel"]) {
             //交易取消
         }
     }];
    //调用其他SDK，例如支付宝SDK等
    if ([url.host isEqualToString:@"com.tencent.xin"]||[url.host isEqualToString:@"pay"]) {
        //微信支付回调
        return [WXApi handleOpenURL:url delegate:self];
    }

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *status = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            if ([status isEqualToString:@"9000"]) {
                [self checkPay];
            }
        }];
    }
        return YES;
}


//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                [UdStorage storageObject:@"" forKey:orderPayId];
                [self checkPay];
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}

- (void)checkPay {
    [[NSNotificationCenter defaultCenter] postNotificationName:YSOrderPayStatus object:@[@"成功"] userInfo:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    [JPUSHService resetBadge];
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (!IsNilString([UdStorage getObjectforKey:orderPayId])) {
        [JKHttpRequestService POST:@"pay/WXReturnApp" withParameters:@{@"order_id":[UdStorage getObjectforKey:orderPayId]} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                [UdStorage storageObject:@"" forKey:orderPayId];
                [self checkPay];

            }
        } failure:^(NSError *error) {

        } animated:YES];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [[EaseMob sharedInstance] applicationWillTerminate:application];
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

//- (void)checkLogin {
//    EMError *error = nil;
//    [[EaseMob sharedInstance].chatManager loginWithUsername:name password:name error:&error];
//}


@end
