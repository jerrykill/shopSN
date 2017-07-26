//
//  YSParseTool.h
//  shopsN
//  手动解析类（基于接口并不确定的情况，如果后台已经稳定推荐改为jsonModel解析）
//  Created by imac on 2017/2/22.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPersonViewModel.h"
#import "YCLassModel.h"
#import "YGoodDetailModel.h"
#import "YGoodShopModel.h"
#import "YSGoodTypeEditModel.h"
#import "YGoodAppraiseModel.h"
#import "YSOrderModel.h"
#import "YScouponModel.h"
#import "YSalesManageModel.h"
#import "YSMessageModel.h"
#import "YReturnsOrdersModel.h"
#import "YPersonIntegralModel.h"
#import "YGiftGoodModel.h"
#import "YLogisicsInfoModel.h"
#import "YSBrandListModel.h"
#import "YSSearchKeyModel.h"
#import "YServiceAskModel.h"

@interface YSParseTool : NSObject

/**首页*/
+ (NSMutableArray *)getParseGoodTypes:(NSArray*)data;//解析商品分类
+ (NSMutableArray *)getParseHeadAD:(NSArray*)data;//解析头部广告
+ (NSMutableArray *)getParseGoodLoves:(NSArray *)data;//解析猜你喜欢
+ (NSMutableArray *)getParseAnnounce:(NSArray *)data;//解析公告
+ (NSMutableArray *)getParseFounds:(NSArray *)data;//解析发现好货
+ (NSMutableArray *)getParseAD:(NSArray *)data;//解析广告
+ (NSMutableArray *)getParseHotGoods:(NSArray *)data;//热卖解析商品
+ (NSMutableArray *)getParseClearance:(NSArray *)data;//尾货清仓

+ (NSMutableArray *)getParseBrand:(NSArray*)data;//品牌
+ (NSMutableArray *)getParseBrandList:(NSArray*)data;//品牌列表解析
+ (YSBrandModel *)getParseBrandDetail:(NSDictionary *)data;//品牌详情
+ (NSMutableArray *)getparseBrandDetailGoods:(NSArray*)data;//品牌详情页商品列表
+ (NSMutableArray *)getParseSearchKeys:(NSArray*)data;//关键字

/**商品详情*/
+ (YGoodDetailModel *)getParseGoodDetail:(NSDictionary*)data;//商品详情解析
+ (NSMutableArray*)getParseGoodAppraise:(NSArray*)data;//商品详情评价解析
+ (NSMutableArray*)getParseGoodConsult:(NSArray*)data;//商品自选列表
+ (NSMutableArray*)getParseGoodsGuessLoves:(NSArray*)data;//猜你喜欢
+ (NSMutableArray*)getParseGoodMatchs:(NSArray*)data;//搭配套餐



/**个人中心*/
+ (YPersonViewModel*)getParsePersonView:(NSDictionary*)data;//个人中心解析；
+ (NSMutableArray*)getParseAddress:(NSArray*)data;//获取地址列表
+ (NSMutableArray*)getParseGoods:(NSArray*)data;//商品表
+ (NSMutableArray*)getParseGoodCollectClass:(NSArray*)data;//收藏类别
+ (NSMutableArray*)getParsePersonParise:(NSArray*)data;//我的评价
+ (NSMutableArray*)getParseFooterGoods:(NSArray*)data;//足迹
+ (NSMutableArray*)getParseReportsDetail:(NSArray*)data;//举报中心

+ (NSMutableArray*)getParseOrders:(NSArray*)data;//订单中心
+ (NSMutableArray*)getParseOrderDetailGoods:(NSArray*)data;//订单详情商品部分
+ (YSOrderModel*)getParseOrderDetails:(NSDictionary*)data;//订单详情
+ (NSMutableArray*)getParseOrderLogisicInfo:(NSArray*)data;//物流信息

+ (NSMutableArray*)getParseCouponArray:(NSArray*)data;//优惠券
+ (NSMutableArray*)getParseAfterSaleApplyList:(NSArray*)data;//售后申请列表
+ (NSMutableArray*)getParseAfterSaleSpeedList:(NSArray*)data;//进度查询列表

+ (YReturnsOrdersModel*)getParseAfterSaleSpeedDetail:(NSDictionary*)data;//进度查询详情

+ (NSMutableArray*)getParseAfterSaleManageList:(NSArray*)data;//售后管理列表
+ (YSalesManageModel*)getParseAfterSaleManageDetail:(NSDictionary*)data;//售后管理详情

+ (NSMutableArray*)getParsePersonNews:(NSArray*)data;//我的消息列表
+ (YSMessageModel*)getParsePersonNewsDetail:(NSDictionary*)data;//消息详情

+ (NSMutableArray*)getParseGiftHistory:(NSArray*)data;//积分历史
+ (NSMutableArray*)getParseGiftGoods:(NSArray*)data;//积分筛选列表
+ (YGiftGoodModel*)getParseGiftGoodDetail:(NSDictionary*)data;//积分商品详情
+ (NSMutableArray*)getParseServiceTitles:(NSArray*)data;//文章
+ (NSMutableArray*)getParseTitleList:(NSArray*)data;//文章列表（配送方式）

/**分类*/
+ (NSMutableArray *)getParseClassOne:(NSArray*)data;//一级分类
+ (YClassTwoModel*)getParseClassTwo:(NSDictionary*)data;//二级分类

+ (NSMutableArray *)getParseFilterGood:(NSArray*)data;//筛选商品解析
+(NSMutableArray *)getParseFilterGoodSearch:(NSArray*)data;//搜索
/**购物车*/
+ (NSMutableArray *)getParseShopCart:(NSArray*)data;
+ (NSMutableArray *)getParseGoodCheck:(NSArray*)data;
+ (NSMutableArray *)getParseChooseGood:(NSArray*)data;





@end
