//
//  YSADDetailViewController.m
//  shopsN
//
//  Created by imac on 2017/5/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSADDetailViewController.h"
#import <WebKit/WebKit.h>

@interface YSADDetailViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (strong,nonatomic) WKWebView *webV;

@property (strong,nonatomic) UIProgressView *progressV;

@end

@implementation YSADDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    [self initView];
}

- (void)initView{
    [self.view addSubview:self.webV];
    [self.view addSubview:self.progressV];
    [self.view bringSubviewToFront:_progressV];
}

- (WKWebView *)webV {
    if (!_webV) {
        _webV = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
        _webV.UIDelegate = self;
        _webV.navigationDelegate = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_activityURL]];
        [_webV loadRequest:request];
        [_webV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    }
    return _webV;
}

- (UIProgressView *)progressV {
    if (!_progressV) {
        _progressV = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, 5)];
        _progressV.backgroundColor = [UIColor blueColor];
        _progressV.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    return _progressV;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
    self.progressV.hidden = NO;
    self.progressV.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"返回加载");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
    self.progressV.hidden = YES;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webV) {
        self.progressV.progress = self.webV.estimatedProgress;
        if (self.progressV.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressV.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressV.hidden = YES;

            }];
        }        }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if ([strRequest containsString:@"Cart.newAddCart"]) {
//        NSLog(@"添加购物车");
//    }
//     decisionHandler(WKNavigationActionPolicyAllow);
//}



- (void)dealloc {
    [_webV removeObserver:self forKeyPath:@"estimatedProgress"];

    // if you have set either WKWebView delegate also set these to nil here
    [_webV setNavigationDelegate:nil];
    [_webV setUIDelegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
