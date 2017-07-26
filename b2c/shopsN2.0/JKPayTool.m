//
//  JKPayTool.m
//  shopsN2.0
//
//  Created by imac on 2017/6/19.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "JKPayTool.h"
#import "UPPaymentControl.h"
#import "WXApi.h"

@implementation JKPayTool

+ (void)payOrderWithOrderId:(NSString *)orderNum title:(NSString *)title price:(NSString *)money complete:(back)complete {
    [JKHttpRequestService POST:@"pay/zf_pay" withParameters:@{@"order_id":orderNum,@"price":money,@"order_name":title} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {

            [self alipayWithorderStr:jsonDic[@"data"] complete:^{
                complete();
            }];

        }
    } failure:^(NSError *error) {

    } animated:YES];

}

+ (void)payOrderWxOrderId:(NSString *)orderNum title:(NSString*)title price:(NSString*)money complete:(back)complete {
    [JKHttpRequestService POST:@"pay/wxpay" withParameters:@{@"body":title,@"out_trade_no":orderNum,@"total_fee":money} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [UdStorage storageObject:orderNum forKey:orderPayId];
            [self jumpToBizPayWithDic:jsonDic[@"data"]];
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

//支付宝
+(void)alipayWithorderStr:(NSString *)orderStr complete:(void (^)())back{

    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AlipayScheme;

    NSLog(@"orderstr---%@",orderStr);
    //获取的orderstr直接调用支付宝
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);

        back();
    }];
}

/**
 *  银联支付
 *
 *  @param Tn 后台返回的tn银联交易流水号
 */
+(void)UnionPayWithTn:(NSString *)Tn withVc:(UIViewController *)target{
    if (Tn!=nil && Tn.length>0) {
        NSLog(@"tn:----  %@", Tn);
        [[UPPaymentControl defaultControl]
         startPay:Tn
         fromScheme:@"UPPayDemo"
         mode:@"00"
         viewController:target];

        [target.navigationController popViewControllerAnimated:YES];

    }
}


//微信支付
+ (NSString *)jumpToBizPayWithDic:(NSDictionary *)dict {

    NSLog(@"weixingxin");

    if (![WXApi isWXAppInstalled]) {
        [SXLoadingView showAlertHUD:@"未安装微信" duration:0.5];
        return @"未安装微信";
    }

    if(![WXApi isWXAppSupportApi]){
        [SXLoadingView showAlertHUD:@"该版本不支持微信支付" duration:0.5];
        return @"该版本不支持微信支付";
    }

    if(dict != nil){
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        [WXApi sendReq:req];
        //日志输出
        NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        return @"";

    }else{
        return [dict objectForKey:@"message"];
    }


}

@end
