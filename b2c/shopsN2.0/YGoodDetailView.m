//
//  YGoodDetailView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailView.h"
#import <WebKit/WebKit.h>

@interface YGoodDetailView()<UIScrollViewDelegate,WKNavigationDelegate>
{
 UIActivityIndicatorView *activityIndicator;
    CGRect _frame;
}


@property (strong,nonatomic) WKWebView *webV;

@property (strong, nonatomic) UILabel *bottomMsgLabel;

@property (nonatomic) BOOL isHead;

@end

@implementation YGoodDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _frame=frame;
        [self addSubview:self.webV];

    }
    return self;
}

#pragma mark ==懒加载==
-(WKWebView *)webV{
    if (!_webV) {
        _webV = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, _frame.size.width, _frame.size.height)];
        _webV.navigationDelegate = self;
        [_webV.scrollView addSubview:self.bottomMsgLabel];
        _webV.scrollView.delegate = self;
        _webV.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webV;
}

-(UILabel *)bottomMsgLabel{
    if (!_bottomMsgLabel) {
        _bottomMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, __kWidth, 40)];
        _bottomMsgLabel.font = [UIFont systemFontOfSize:13.0f];
        _bottomMsgLabel.textAlignment = NSTextAlignmentCenter;
        _bottomMsgLabel.text = @"下拉返回商品详情";
    }
    return _bottomMsgLabel;
}

- (void)setGoodId:(NSString *)goodId {
    _goodId = goodId;
    if (IsNilString(_goodId)) {
        return;
    }else{
        NSString *webUrl= [NSString stringWithFormat:@"%@Goods/goodsDetail/goods_id/%@",RootURL,_goodId];
        NSLog(@"%@",webUrl);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
        [_webV loadRequest:request];
    }
//    WK(weakSelf)
//    __typeof(&*weakSelf) strongSelf = weakSelf;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        [JKHttpRequestService POST:@"Goods/goodsDetail" withParameters:@{@"goods_id":@"51"} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
//            if (succe) {
//                NSDictionary *dic = jsonDic[@"data"];
//                NSString *webUrl =dic[@"detail"];
//                if (IsNilString(webUrl)) {
//                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]];
//                    [strongSelf.webV loadRequest:request];
//                }
//            }
//        } failure:^(NSError *error) {
//
//        } animated:NO];
//    });
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"返回加载");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
//    CGFloat webWidth = [webView.scrollView contentSize].width;
//    CGFloat webHeight = [webView.scrollView contentSize].height;
//    webView.frame = CGRectMake(0, 0, _frame.size.width, webHeight/webWidth*_frame.size.width);


}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
}



#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset<-40&&!scrollView.dragging) {
        if (_isHead) {
            [self.delegate getGoodHead];
            _isHead = NO;
        }else{
            _isHead = YES;
        }
    }
}



@end
