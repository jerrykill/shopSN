//
//  YGiftGoodDetailViewController.m
//  shopsN
//
//  Created by imac on 2017/1/7.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGiftGoodDetailViewController.h"
#import "YGoodDetailPictureHeadView.h"
#import "YGiftGoodTitleView.h"
#import "YGiftGoodDetailView.h"
#import "YGiftGoodBottomView.h"
#import "YGoodShareView.h"

#import "YGiftSureOrderViewController.h"
#import "YSLoginViewController.h"

@interface YGiftGoodDetailViewController ()<UIScrollViewDelegate,YGiftGoodBottomViewDelegate,YGoodShareViewDelegate>

@property (strong,nonatomic) UIScrollView *mainV;

@property (strong,nonatomic) YGoodDetailPictureHeadView *picheadV;

@property (strong,nonatomic) YGiftGoodTitleView *titleV;

@property (strong,nonatomic) YGiftGoodDetailView *detailV;

@property (strong,nonatomic) YGiftGoodBottomView *bottomV;

@property (strong,nonatomic) YGoodShareView *shareV;



@end

@implementation YGiftGoodDetailViewController

-(void)getData{
    NSString *testId = _model.goodId;
    [JKHttpRequestService POST:@"Integral/integral_goodsdetail" withParameters:@{@"goods_id":_model.goodId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            _model = [YSParseTool getParseGiftGoodDetail:data];
            _model.goodId = testId;
            _titleV.model = _model;
            _picheadV.imageArr  = _model.imageArr;
            _detailV.model = _model;
            _detailV.frame = CGRectMake(0, CGRectYH(_titleV), __kWidth, (_model.list.count+1)*20);
            _mainV.contentSize =  CGSizeMake(__kWidth, __kWidth+160+_model.list.count*20);
            _bottomV.model = _model;
        }
    } failure:^(NSError *error) {

    } animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    [self getShare];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getData];
        dispatch_async(dispatch_get_main_queue(), ^{
               [self initView];
        });
    });

}

-(void)getShare{
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth-70, 30, 20, 22)];
    [self.headV addSubview:shareBtn];
    shareBtn.backgroundColor= [UIColor clearColor];
    [shareBtn setImage:MImage(@"head_share") forState:BtnNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:BtnTouchUpInside];
}

-(void)initView{
    [self.view addSubview:self.mainV];

    [_mainV addSubview:self.picheadV];

    [_mainV addSubview:self.titleV];

    [_mainV addSubview:self.detailV];

    _mainV.contentSize =  CGSizeMake(__kWidth, __kWidth+260);

    [self.view addSubview:self.bottomV];

}

#pragma mark ==懒加载==
-(UIScrollView *)mainV{
    if (!_mainV) {
        _mainV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64-50)];
        _mainV.scrollEnabled = YES;
        _mainV.bounces = YES;
        _mainV.showsVerticalScrollIndicator = NO;
        _mainV.showsHorizontalScrollIndicator = NO;
    }
    return _mainV;
}

-(YGoodDetailPictureHeadView *)picheadV{
    if (!_picheadV) {
        _picheadV = [[YGoodDetailPictureHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kWidth)];
    }
    return _picheadV;
}

-(YGiftGoodTitleView *)titleV{
    if (!_titleV) {
        _titleV = [[YGiftGoodTitleView alloc]initWithFrame:CGRectMake(0, CGRectYH(_picheadV), __kWidth, 130)];
    }
    return _titleV;
}

-(YGiftGoodDetailView *)detailV{
    if (!_detailV) {
        _detailV = [[YGiftGoodDetailView alloc]initWithFrame:CGRectMake(0, CGRectYH(_titleV), __kWidth, 120)];
    }
    return _detailV;
}

-(YGiftGoodBottomView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[YGiftGoodBottomView alloc]initWithFrame:CGRectMake(0, CGRectYH(_mainV), __kWidth, 50)];
        _bottomV.delegate = self;
    }
    return _bottomV;
}

#pragma mark ==YGiftGoodBottomViewDelegate==
-(void)makeExchange{
    NSLog(@"兑换");
    if (IsNilString([UdStorage getObjectforKey:Userid])) {
        YSLoginViewController *vc = [[YSLoginViewController alloc]init];
        BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    NSMutableArray *goods = [NSMutableArray array];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_model.goodId forKey:@"id"];
    [dic setValue:@"1" forKey:@"num"];
    [goods addObject:dic];
    NSData *data = [NSJSONSerialization dataWithJSONObject:goods options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [JKHttpRequestService POST:@"Order/goBuy" withParameters:@{@"app_user_id":[UdStorage getObjectforKey:Userid],@"goods":jsonStr,@"is_integral":@"1"} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dics = jsonDic[@"data"];
            YGiftSureOrderViewController *vc = [[YGiftSureOrderViewController alloc]init];
            YShopGoodModel *model = [[YShopGoodModel alloc]init];
            model.goodId = _model.goodId;
            model.goodUrl = _model.goodUrl;
            model.goodTitle = _model.goodTitle;
            model.goodMoney = _model.money;
            model.goodIntegral = _model.integral;
            model.goodCount = @"1";
            vc.datas = [NSMutableArray arrayWithArray:@[model]];
            NSArray *adds = @[dics[@"address"]];
            vc.address = [YSParseTool getParseAddress:adds].firstObject;
            vc.freight = [NSString stringWithFormat:@"%@",dics[@"freight"]];
            vc.totalPay = [NSString stringWithFormat:@"%.2f",dics[@"integral_money"]];
            vc.totalIntegral = _model.integral;
            vc.personIntegral = dics[@"integral"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {

    } animated:YES];


}

-(void)shareAction{
    NSLog(@"分享");
    _shareV = [[YGoodShareView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    [self.view addSubview:_shareV];
    _shareV.delegate = self;
    _shareV.goodID = _model.goodId;
}
#pragma mark ==YGoodShareViewDelegate==
-(void)shareType:(NSInteger)sender Url:(NSString *)goodID {
    NSLog(@"分享%ld",sender);
    [YShareTool shareMessage:@"商品信息" title:@"测试" Url:[NSString stringWithFormat:@"%@%@.html",ShareGoodRoot,goodID] type:sender];
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
