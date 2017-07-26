//
//  YIntegralRuleView.m
//  shopsN
//
//  Created by imac on 2016/12/27.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YIntegralRuleView.h"
#import <WebKit/WebKit.h>

@interface YIntegralRuleView ()<WKNavigationDelegate>

@property (strong,nonatomic) UIView *backV;

@property (strong,nonatomic) UIView *ruleV;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) WKWebView *detailV;

@property (strong,nonatomic) UIButton *knowBtn;

@end

@implementation YIntegralRuleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor clearColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.backV];
    [self sendSubviewToBack:_backV];
    [self addSubview:self.ruleV];
    [_ruleV addSubview:self.titleLb];
    [_ruleV addSubview:self.detailV];
    [_ruleV addSubview:self.knowBtn];
}

#pragma mark ==懒加载==
-(UIView *)backV{
    if (!_backV) {
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        _backV.backgroundColor = [UIColor blackColor];
        _backV.alpha = 0.2;
    }
    return _backV;
}

-(UIView *)ruleV{
    if (!_ruleV) {
        _ruleV = [[UIView alloc]initWithFrame:CGRectMake(10, 88, __kWidth-20, __kHeight-140)];
        _ruleV.backgroundColor = [UIColor whiteColor];
        _ruleV.layer.cornerRadius = 5;
    }
    return _ruleV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, __kWidth-20, 21)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = __DefaultColor;
        _titleLb.font = MFont(21);
        _titleLb.text = @"积 分 规 则";
    }
    return _titleLb;
}

-(UIWebView *)detailV{
    if (!_detailV) {
        WKPreferences *prefrence = [[WKPreferences alloc]init];
        prefrence.minimumFontSize = 14;
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = prefrence;
        _detailV = [[WKWebView alloc]initWithFrame:CGRectMake(0, 50, __kWidth-20, __kHeight-300) configuration:config];
        _detailV.backgroundColor = [UIColor whiteColor];
        _detailV.navigationDelegate = self;
        [_detailV setOpaque:NO];
        [_detailV sizeToFit];
        [self loadDocument:@"积分政策.doc" inView:_detailV];
    }
    return _detailV;
}

-(UIButton *)knowBtn{
    if (!_knowBtn) {
        _knowBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectYH(_detailV)+20, __kWidth-60, 52)];
        _knowBtn.layer.cornerRadius = 5;
        _knowBtn.layer.borderWidth = 1;
        _knowBtn.layer.borderColor = __TextColor.CGColor;
        _knowBtn.titleLabel.font = MFont(15);
        [_knowBtn setTitle:@"我知道了" forState:BtnNormal];
        [_knowBtn setTitleColor:LH_RGBCOLOR(153, 153, 153) forState:BtnNormal];
        [_knowBtn addTarget:self action:@selector(chooseKnow) forControlEvents:BtnTouchUpInside];
    }
    return _knowBtn;
}

-(void)chooseKnow{
    [self removeFromSuperview];
}

-(void)loadDocument:(NSString *)documentName inView:(WKWebView *)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

    
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
    [SXLoadingView hideProgressHUD];

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
}
@end
