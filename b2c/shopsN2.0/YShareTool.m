//
//  YShareTool.m
//  shopsN
//  分享类
//  Created by imac on 2017/1/13.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YShareTool.h"

@implementation YShareTool

+(void)shareMessage:(NSString *)text title:(NSString *)title Url:(NSString *)URL type:(NSInteger)sender{
    NSArray *imageArr = @[[UIImage imageNamed:@"share"]];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text images:imageArr
                                        url:[NSURL URLWithString:URL]
                                      title:title
                                       type:SSDKContentTypeAuto];
    switch (sender) {
        case 0:
        {
            [ShareSDK share:SSDKPlatformTypeWechat parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                        [SXLoadingView showAlertHUD:@"分享成功" duration:1.5];
                        break;
                    case SSDKResponseStateFail:
                        [SXLoadingView showAlertHUD:@"分享失败" duration:1.5];
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        case 1:
        {
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                        [SXLoadingView showAlertHUD:@"分享成功" duration:1.5];
                        break;
                    case SSDKResponseStateFail:
                        [SXLoadingView showAlertHUD:@"分享失败" duration:1.5];
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        case 2:
        {
            [ShareSDK share:SSDKPlatformTypeQQ parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                        [SXLoadingView showAlertHUD:@"分享成功" duration:1.5];
                        break;
                    case SSDKResponseStateFail:
                        [SXLoadingView showAlertHUD:@"分享失败" duration:1.5];
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        case 3:
        {
            [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                        [SXLoadingView showAlertHUD:@"分享成功" duration:1.5];
                        break;
                    case SSDKResponseStateFail:
                        [SXLoadingView showAlertHUD:@"分享失败" duration:1.5];
                        break;
                    default:
                        break;
                }
            }];
        }
            break;

        default:
            break;
    }
}

@end
