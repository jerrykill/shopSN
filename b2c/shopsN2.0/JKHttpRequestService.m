//
//  JKHttpRequestService.m
//  shopsN
//
//  Created by imac on 2017/2/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "JKHttpRequestService.h"

#import "SXLoadingView.h"

@implementation JKHttpRequestService

+(void)POST:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SXLoadingView showProgressHUD:@"loading..."];
        });
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",RootURL,path];
    NSLog(@"post:path===%@\n%@",url,params);
    [[JKHttpClientTool sharedManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {

        NSError *error;
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        if (succe) {
//            [SXLoadingView showAlertHUD:@"加载成功" duration:SXLoadingTime];
        }else{
            if (![dic[@"msg"] isEqualToString:@"暂无数据"]) {
                [SXLoadingView showAlertHUD:[dic valueForKey:@"msg"] duration:SXLoadingTime];
            }
        }
        [SXLoadingView hideProgressHUD];
        NSLog(@"%@",dic[@"data"]);
        success(responseObject,succe,dic);
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        NSLog(@"%@",error.description);
        [SXLoadingView showAlertHUD:@"网络故障" duration:0.5];
    }];
}

+(void)GET:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SXLoadingView showProgressHUD:@"loading..."];
        });
    }

     NSString *url = [NSString stringWithFormat:@"%@%@",RootURL,path];
    NSLog(@"get:path===%@\n%@",url,params);
    [[JKHttpClientTool sharedManager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error;
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        if (succe) {
//            [SXLoadingView showAlertHUD:@"加载成功" duration:SXLoadingTime];
        }else{
            if (IsNilString(dic[@"msg"])) {
                [SXLoadingView showAlertHUD:@"加载失败" duration:SXLoadingTime];
            }else{
                if (![dic[@"msg"] isEqualToString:@"暂无数据"]) {
                    [SXLoadingView showAlertHUD:[dic valueForKey:@"msg"] duration:SXLoadingTime];
                }
            }
        }
        [SXLoadingView hideProgressHUD];
        NSLog(@"%@",dic[@"data"]);
        success(responseObject,succe,dic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        fail(error);
        [SXLoadingView showAlertHUD:@"网络故障" duration:0.5];
    }];
}

+(void)POST:(NSString *)path Params:(NSDictionary *)params NSData:(NSData *)imageData key:(NSString *)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SXLoadingView showProgressHUD:@"loading..."];
        });
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",RootURL,path];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSLog(@"path ==%@%@",url,params);
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        if (imageData) {
            NSString *file  =[NSString stringWithFormat:@"%@.jpg",imageData];
            [formData appendPartWithFileData:imageData name:name fileName:file mimeType:@"image/png/jpeg/jpg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SXLoadingView hideProgressHUD];
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:&error];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        
        if (succe) {
//            [SXLoadingView showAlertHUD:@"加载成功" duration:SXLoadingTime];
        }else{
            [SXLoadingView showAlertHUD:[dic valueForKey:@"message"] duration:SXLoadingTime];
        }
         NSLog(@"%@",dic[@"data"]);
        success(responseObject,succe,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (animated) {
            [SXLoadingView hideProgressHUD];
        }
        NSLog(@"%@",error.description);
        fail(error);
    }];
}

+(void)POST:(NSString *)path Params:(NSDictionary *)params NSArray:(NSArray<NSData *> *)imageArr key:(NSString *)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SXLoadingView showProgressHUD:@"loading..."];
        });
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",RootURL,path];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSLog(@"path ==%@%@",url,params);
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        if (imageArr.count) {
            for (int i=0; i<imageArr.count; i++) {
                NSData *data = imageArr[i];
                NSString *file  =[NSString stringWithFormat:@"%@.jpg",data];
                NSString *names = [NSString stringWithFormat:@"%@%d",name,i+1];
                [formData appendPartWithFileData:data name:names fileName:file mimeType:@"image/png/jpeg/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SXLoadingView hideProgressHUD];
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:&error];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }

        if (succe) {
            //            [SXLoadingView showAlertHUD:@"加载成功" duration:SXLoadingTime];
        }else{
            [SXLoadingView showAlertHUD:[dic valueForKey:@"message"] duration:SXLoadingTime];
        }
        NSLog(@"%@",dic[@"data"]);
        success(responseObject,succe,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (animated) {
            [SXLoadingView hideProgressHUD];
        }
        NSLog(@"%@",error.description);
        fail(error);
    }];
}

+ (void)payPost:(NSString *)path Params:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated {
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SXLoadingView showProgressHUD:@"loading..."];
        });
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",RootURL,path];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = 30;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSLog(@"path ==%@%@",url,params);
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [SXLoadingView hideProgressHUD];
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
            BOOL succe=NO;
            if ([str isEqualToString:@"1"]) {
                succe = YES;
            }

            if (succe) {
                //            [SXLoadingView showAlertHUD:@"加载成功" duration:SXLoadingTime];
            }else{
                [SXLoadingView showAlertHUD:[dic valueForKey:@"message"] duration:SXLoadingTime];
            }
            NSLog(@"%@",dic[@"data"]);
            success(responseObject,succe,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (animated) {
            [SXLoadingView hideProgressHUD];
        }
        NSLog(@"%@",error.description);
        fail(error);
    }];
}


@end
