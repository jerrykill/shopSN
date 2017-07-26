//
//  YSParseTool.m
//  shopsN
//  手动解析类（基于接口并不确定的情况，如果后台已经稳定推荐改为jsonModel解析）
//  Created by imac on 2017/2/22.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSParseTool.h"
#import "YWarnModel.h"
#import "YGoodClassModel.h"
#import "YGoodsModel.h"
#import "YAddressModel.h"
#import "YSGoodTypeEditModel.h"
#import "YSOrderModel.h"
#import "YHeadImage.h"
#import "YReturnsOrdersModel.h"
#import "YGiftGoodModel.h"

@implementation YSParseTool

#pragma mark ==解析公告==
+(NSMutableArray *)getParseAnnounce:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YWarnModel *model = [[YWarnModel alloc]init];
        model.warnTitle = dic[@"title"];
        model.warnId = dic[@"id"];
        [list addObject:model];
    }
    return list;
}

#pragma mark ==解析头部广告==
+ (NSMutableArray *)getParseHeadAD:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YHeadImage *headImg = [[YHeadImage alloc]init];
        headImg.imageName = dic[@"pic_url"];
        [list addObject:headImg];
    }
    return list;
}

+ (NSMutableArray *)getParseBrand:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YSBrandModel *model = [[YSBrandModel alloc]init];
        model.brandId = dic[@"id"];
        model.logo = dic[@"brand_logo"];

        [list addObject:model];
    }
    return list;
}

#pragma mark ==关键字搜索==
+ (NSMutableArray *)getParseSearchKeys:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YSSearchKeyModel *model = [[YSSearchKeyModel alloc]init];
        model.classId = dic[@"goods_class_id"];
        model.name = dic[@"hot_words"];
        [list addObject:model];
    }
    return list;
}

#pragma mark ==品牌馆列表==
+ (NSMutableArray *)getParseBrandList:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YSBrandListModel *letters = [[YSBrandListModel alloc]init];
        letters.sectionName = dic[@"letter"];
        NSMutableArray *brandList = [NSMutableArray array];
        for (NSDictionary *dics in dic[@"value"]) {
            YSBrandModel *model = [[YSBrandModel alloc]init];
            model.brandId =[NSString stringWithFormat:@"%@", dics[@"id"]];
            model.name = dics[@"brand_name"];
            model.logo = dics[@"brand_logo"];
            [brandList addObject:model];
        }
        letters.list = brandList;
        [list addObject:letters];
    }
    return list;
}
#pragma mark ==品牌详情==
+ (YSBrandModel *)getParseBrandDetail:(NSDictionary *)data {
    YSBrandModel *model = [[YSBrandModel alloc]init];
    model.imageName = data[@"brand_banner"];
    model.info = data[@"brand_description"];
    model.detailName = data[@"brand_name"];
    model.logo = data[@"brand_logo"];
    return model;
}

#pragma mark ==品牌详情商品列表==
+ (NSMutableArray *)getparseBrandDetailGoods:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model =[[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodMoney = dic[@"price_market"];
        model.goodUrl = dic[@"pic_url"];
        model.goodeValuateCount = dic[@"comment"];
        [list addObject:model];
    }
    return list;
}

#pragma mark ==商品一级分类==
+(NSMutableArray *)getParseGoodTypes:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodClassModel *model= [[YGoodClassModel alloc]init];
        model.classTitle = dic[@"class_name"];
        model.classdesc = dic[@"description"];
        model.imageName = dic[@"pic_url"];
        model.classID = dic[@"id"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==猜你喜欢==
+(NSMutableArray *)getParseGoodLoves:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodUrl = dic[@"pic_url"];
        model.goodMoney = dic[@"price_member"];
        model.goodOldMoney = dic[@"price_market"];
        if (IsNilString(model.goodMoney)) {
            model.goodMoney = model.goodOldMoney;
        }
        [list addObject:model];
    }
    return list;

}
#pragma mark ==发现好货==
+ (NSMutableArray *)getParseFounds:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodUrl = dic[@"pic_url"];
        model.goodDesc = dic[@"description"];
        model.goodMoney = dic[@"price_market"];
        model.goodstock = dic[@"stock"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==解析广告==
+ (NSMutableArray *)getParseAD:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YHeadImage *headImg = [[YHeadImage alloc]init];
        headImg.imageName = dic[@"pic_url"];
        headImg.imageUrl = dic[@"ad_link"];
        headImg.imageID = dic[@"id"];
        headImg.type = dic[@"title"];
        [list addObject:headImg];
    }
    return list;
}
#pragma mark ==热卖馆人气商品==
+ (NSMutableArray *)getParseHotGoods:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodMoney = dic[@"price_member"];
        model.goodOldMoney = dic[@"price_market"];
        if (IsNilString(model.goodMoney)) {
            model.goodMoney = model.goodOldMoney;
        }
        model.goodTitle = dic[@"title"];
        model.goodUrl = dic[@"img"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==尾货清仓==
+ (NSMutableArray *)getParseClearance:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"class_name"];
        model.goodUrl = dic[@"pic_url"];
        model.goodDesc = dic[@"description"];
        model.activeName = @"timeBuy";
        [list addObject:model];
    }
    return list;
}


#pragma mark ==个人中心==
+(YPersonViewModel *)getParsePersonView:(NSDictionary *)data{
    YPersonViewModel *model = [[YPersonViewModel alloc]init];
    model.headImage = data[@"header_img"];
    model.nick_name = data[@"nick_name"];
    model.balance   = data[@"balance"];
    model.coupon    = data[@"my_coupon"];
    model.integral  = [NSString stringWithFormat:@"%@",data[@"integral"]];
    model.bill      = [NSString stringWithFormat:@"%@",data[@"fapiao"]];
    model.leaveBill = [NSString stringWithFormat:@"%@",data[@"yudan"]];
    return model;
}
#pragma mark ==个人中心商品列表==
+(NSMutableArray *)getParseGoods:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodMoney = dic[@"price_member"];
        model.goodUrl = dic[@"img"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==收藏类别==
+(NSMutableArray *)getParseGoodCollectClass:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YGoodClassModel *class = [[YGoodClassModel alloc]init];
        class.classTitle = dic[@"class_name"];
        class.classID = dic[@"class_id"];
        [list addObject:class];
    }
    return list;
}

#pragma mark ==我的足迹==
+ (NSMutableArray *)getParseFooterGoods:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodMoney = dic[@"price_member"];
        model.goodUrl = dic[@"img"];
        [list addObject:model];
    }
    return list;
}



#pragma mark ==获取地址列表==
+(NSMutableArray *)getParseAddress:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
            YAddressModel *model = [[YAddressModel alloc]init];
            model.addressId = dic[@"id"];
            model.name = dic[@"realname"];
            model.phone = dic[@"mobile"];
            model.province = dic[@"prov"];
            model.city = dic[@"city"];
            NSString *str;
            if (IsNull(dic[@"dist"])) {
                str =@"";
            }else{
                str = dic[@"dist"];
                if ([str isEqualToString:@"-1"]) {
                    str =@"";
                }
            }
            model.area = str;
            model.Address = dic[@"address"];
            model.isDefault = [dic[@"status"] integerValue]==1?YES:NO;
            model.addressId = dic[@"id"];
            [list addObject:model];
    }
    return list;
}

#pragma mark ==我的评价==
+(NSMutableArray *)getParsePersonParise:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YGoodAppraiseModel *model = [[YGoodAppraiseModel alloc]init];
        model.time = dic[@"create_time"];
        model.info = dic[@"content"];
        NSMutableArray *img =[NSMutableArray array];
//        NSString *image = dic[@"img"];
        NSArray*data = dic[@"imgs"];
//        NSArray *data =[image componentsSeparatedByString:@"$"];
        if (data.count) {
            for (NSString *str in data) {
                if (!IsNilString(str)) {
                    [img addObject:str];
                }
            }
            model.imageArr = img;
        }
        model.imageUrl = dic[@"mainImg"];
        YGoodsModel *good= [[YGoodsModel alloc]init];
        good.goodTitle = dic[@"title"];
        good.goodUrl = dic[@"mainImg"];
        model.model = good;
        NSMutableArray *types = [NSMutableArray array];
        for (NSDictionary *ds in dic[@"attra"]) {
            YGoodTypeModel *tp = [[YGoodTypeModel alloc]init];
            tp.name = ds[@"name"];
            tp.size = ds[@"item"];
            [types addObject:tp];
        }
        model.list = types;
        [list addObject:model];
    }
    return list;
}

#pragma mark ==一级分类==
+(NSMutableArray *)getParseClassOne:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YCLassModel *model = [[YCLassModel alloc]init];
        model.classId = dic[@"id"];
        model.className = dic[@"class_name"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==次级分类==
+(NSMutableArray *)getParseClassTwo:(NSArray *)data{
    NSMutableArray *lists = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YClassTwoModel *model = [[YClassTwoModel alloc]init];
        model.classId = dic[@"id"];
        model.sectionName = dic[@"class_name"];
        NSArray *array = dic[@"child"];
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary*dic in array) {
            YClassThreeModel *class = [[YClassThreeModel alloc]init];
            class.imageName = dic[@"pic_url"];
            class.classId = dic[@"id"];
            class.title = dic[@"class_name"];
            [list addObject:class];
        }
        model.array = list;
        [lists addObject:model];
    }
  return lists;
}

#pragma mark ==商品详情==
+(YGoodDetailModel *)getParseGoodDetail:(NSDictionary *)data{
    YGoodDetailModel *model = [[YGoodDetailModel alloc]init];
    model.goodId = data[@"id"];
    model.goodTitle = data[@"title"];
    model.goodOldMoney = data[@"price_market"];
    model.goodMoney = data[@"price_member"];
    model.stock = data[@"minStock"];
    model.picUrl = data[@"goods_detail"];
    model.imageArr = data[@"goods_img"];

    model.isCollected = data[@"is_collect"];
    if (model.imageArr.count) {
        model.goodUrl = model.imageArr[0];
    }
    NSMutableArray *house = [NSMutableArray array];
    NSArray *locations = data[@"warehouse"];
    for (NSDictionary*dic in locations) {
        YSGoodLocationModel *local = [[YSGoodLocationModel alloc]init];
        local.name = dic[@"name"];
        local.locationId = dic[@"id"];
        [house addObject:local];
    }
    model.location = house;
    NSMutableArray *types = [NSMutableArray array];
    for (NSDictionary *dic in data[@"allattrcha"]) {
        YGoodSizeModel *size = [[YGoodSizeModel alloc]init];
        size.typeName = dic[@"name"];
        NSMutableArray *choose = [NSMutableArray array];
        for (NSDictionary *che in dic[@"value"]) {
            YSSizeModel *check = [[YSSizeModel alloc]init];
            check.name = che[@"attr"];
            check.sizeId = che[@"spci"];
            [choose addObject:check];
        }
        size.size =choose;
        [types addObject:size];
    }
    model.goodSize = types;
    model.time = data[@"end_time"];
    if (!IsNilString(model.time)) {
         model.goodMoney = data[@"activity_price"];
        NSArray *activi = data[@"goods_active"];
        NSMutableArray *act = [NSMutableArray array];
        for (NSDictionary *at in activi) {
            YGoodActiveModel *actModel = [[YGoodActiveModel alloc]init];
            actModel.title = at[@"name"];
            actModel.info = at[@"description"];
            [act addObject:actModel];
        }
        model.list = act;
    }
    return model;
}

#pragma mark ==猜你喜欢==
+ (NSMutableArray *)getParseGoodsGuessLoves:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodDetailModel *model = [[YGoodDetailModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodUrl = dic[@"pic_url"];
        model.goodMoney = dic[@"price_market"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==搭配套餐推荐==
+ (NSMutableArray *)getParseGoodMatchs:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodDetailModel *model = [[YGoodDetailModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodUrl = dic[@"pic_url"];
        model.goodMoney = dic[@"price_member"];
        [list addObject:model];
    }
    return list;

}


#pragma mark ==商品详情评论==
+(NSMutableArray *)getParseGoodAppraise:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YGoodAppraiseModel *model = [[YGoodAppraiseModel alloc]init];
        model.name = dic[@"nick_name"];
        if (IsNilString(model.name)) {
            model.name = dic[@"user_name"];
        }
        model.time = dic[@"create_time"];
        model.grade = dic[@"level"];
        model.info = dic[@"content"];
        NSString *image = dic[@"img"];
        if (image.length) {
            NSArray *arr = [image componentsSeparatedByString:@"$"];
            model.imageArr = [NSMutableArray arrayWithArray:arr];
        }
        NSMutableArray *types = [NSMutableArray array];
        for (NSDictionary *ds in dic[@"attr"]) {
            YGoodTypeModel *tp = [[YGoodTypeModel alloc]init];
            tp.name = ds[@"name"];
            tp.size = ds[@"item"];
            [types addObject:tp];
        }
        model.list = types;
        [list addObject:model];
    }
    return list;
}


#pragma mark ==商品列表==
+(NSMutableArray *)getParseFilterGood:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodMoney = dic[@"price_member"];
        model.goodUrl = dic[@"pic_url"];
        model.goodeValuateCount = dic[@"comment_count"];
        [list addObject:model];
    }
    return list;
}

+(NSMutableArray *)getParseFilterGoodSearch:(NSArray*)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YGoodsModel *model = [[YGoodsModel alloc]init];
        model.goodId = dic[@"id"];
        model.goodTitle = dic[@"title"];
        model.goodMoney = dic[@"price_member"];
        model.goodUrl = dic[@"img"];
        model.goodeValuateCount = dic[@"count"];
        [list addObject:model];
    }
    return list;
}

#pragma mark ==购物车商品==
+(NSMutableArray *)getParseShopCart:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YShopGoodModel *model = [[YShopGoodModel alloc]init];
        model.goodTitle = dic[@"title"];
        model.goodUrl = dic[@"pic_url"];
        model.shopCartId = dic[@"id"];
        model.goodId = dic[@"goods_id"];
        model.goodCount = dic[@"goods_num"];
        model.goodMoney = dic[@"price_member"];
        NSArray *types = dic[@"item"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *ak in types) {
            YGoodTypeModel *type = [[YGoodTypeModel alloc]init];
            type.name = ak[@"spec"];
            type.size = ak[@"item"];
            [arr addObject:type];
        }
        model.goodTypeArr = arr;
        [list addObject:model];
    }
    return list;
}
#pragma mark ==规格选择器==
+(NSMutableArray *)getParseGoodCheck:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YGoodSizeModel *model = [[YGoodSizeModel alloc]init];
        model.typeName = dic[@"name"];
        NSMutableArray *type = [NSMutableArray array];
        for (NSDictionary*size in dic[@"children"]) {
            YSSizeModel *gd = [[YSSizeModel alloc]init];
            gd.name = size[@"item"];
            gd.sizeId = size[@"id"];
            [type addObject:gd];
        }
        model.size = type;
        [list addObject:model];
    }
    return list;
}
#pragma mark ==各类商品规格==
+(NSMutableArray *)getParseChooseGood:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YSGoodTypeEditModel *model = [[YSGoodTypeEditModel alloc]init];
        model.goodsId = dic[@"id"];
        model.goodMoney = dic[@"price_member"];
        model.stock = dic[@"stock"];
        model.key = dic[@"key"];
        [list addObject:model];
    }
    return list;
}


#pragma mark ==订单中心==
+(NSMutableArray *)getParseOrders:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YSOrderModel *model = [[YSOrderModel alloc]init];
        model.orderId = dic[@"id"];
        model.payMoney = dic[@"price_sum"];
        model.createTime = dic[@"create_time"];
        model.orderStatus = dic[@"order_status"];
        model.comment = dic[@"comment_status"];
        model.goodCount = dic[@"count"];
        NSArray *goodArr = dic[@"goods"];
        NSMutableArray *imageArr = [NSMutableArray array];
        NSMutableArray *lst = [NSMutableArray array];
        if (model.goodCount.integerValue==1) {
            for (NSDictionary *good in goodArr) {
                if (good[@"selfAttr"]) {
                    NSArray *types = good[@"selfAttr"];
                    for (NSDictionary *type in types) {
                        YGoodTypeModel *size= [[YGoodTypeModel alloc]init];
                        size.size = type[@"item"];
                        size.name = type[@"name"];
                        [lst addObject:size];
                    }
                       model.typeArr =lst;
                }
                model.title = good[@"title"];
                if (good[@"selfImg"]) {
                    model.imageArr = [NSMutableArray arrayWithArray:@[good[@"selfImg"]]];
                }
            }
        }else{
            for (NSDictionary *good in goodArr) {
                if (good[@"selfImg"]) {
                    [imageArr addObject:good[@"selfImg"]];
                }else{
                    [imageArr addObject:@""];
                }
            }
            model.imageArr = imageArr;
        }

        [list addObject:model];
    }
    return  list;
}

#pragma mark ==订单详情商品==
+ (NSMutableArray *)getParseOrderDetailGoods:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YShopGoodModel *model = [[YShopGoodModel alloc]init];
        model.goodId = dic[@"goods_id"];
        model.goodCount = dic[@"goods_num"];
        model.goodMoney = dic[@"goods_price"];
        model.goodUrl = dic[@"img"];
        if (IsNull(model.goodUrl)||IsNilString(model.goodUrl)) {
            model.goodUrl = @"";
        }
        model.goodTitle = dic[@"goods_title"];
        if (IsNull(model.goodTitle)||IsNilString(model.goodTitle)) {
            model.goodTitle = @"";
        }
        NSArray *arr = dic[@"attribute"];
        NSMutableArray *types = [NSMutableArray array];
        for (NSDictionary*type in arr) {
            YGoodTypeModel *size = [[YGoodTypeModel alloc]init];
            size.name = type[@"name"];
            size.size = type[@"item"];
            [types addObject:size];
        }
        model.goodTypeArr = types;
        [list addObject:model];
    }
    return list;
}

#pragma mark ==订单详情==
+ (YSOrderModel *)getParseOrderDetails:(NSDictionary *)data{
    YSOrderModel *model = [[YSOrderModel alloc]init];
    model.orderId = data[@"id"];
    model.showId = data[@"order_sn_id"];
    model.orderInfo = data[@"remarks"];
    model.payType = data[@"pay_type"];
    model.payMoney = data[@"price_sum"];
    model.freight = data[@"shipping_monery"];
    model.createTime = data[@"create_time"];
    model.payTime = data[@"pay_time"];
    model.sendTime =  data[@"delivery_time"];
    model.couponMoney = data[@"coupon_money"];
    model.invoice = data[@"invoice"];
    model.sendType = data[@"shipping"];
    return model;
}

#pragma mark ==优惠券==
+ (NSMutableArray *)getParseCouponArray:(NSArray *)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YScouponModel *model = [[YScouponModel alloc]init];
        model.ticketId = dic[@"id"];
        model.name = dic[@"name"];
        model.value = dic[@"money"];
        model.condition = dic[@"condition"];
        model.startTime = dic[@"use_start_time"];
        model.endTime = dic[@"use_end_time"];
        [list addObject:model];
    }
    return list;
}



#pragma mark ==售后管理列表==
+ (NSMutableArray *)getParseAfterSaleManageList:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YSalesManageModel *model = [[YSalesManageModel alloc]init];
        model.salesId = dic[@"id"];
        model.orderId = dic[@"order_id"];
        model.applyTime = dic[@"create_time"];
        model.info = dic[@"tuihuo_case"];
        model.manageSatus = dic[@"status"];
        [list addObject:model];
    }
    return list;
}

#pragma mark ==售后管理详情==
+ (YSalesManageModel *)getParseAfterSaleManageDetail:(NSDictionary *)data {
    YSalesManageModel *model = [[YSalesManageModel alloc]init];
    model.salesId = data[@"id"];
    model.orderId = data[@"order_id"];
    model.type = data[@"is_receive"];
    model.ask = data[@"type"];
    model.info = data[@"explain"];
    model.applyTime = data[@"create_time"];
    model.cancelTime = data[@"revocation_time"];
    model.money = data[@"price"];
    model.status = data[@"status"];
    return model;
}

#pragma mark ==售后申请列表==
+ (NSMutableArray *)getParseAfterSaleApplyList:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YReturnsOrdersModel *model = [[YReturnsOrdersModel alloc]init];
        model.orderId = dic[@"order_sn_id"];
        model.status = dic[@"order_status"];
        model.createDate = dic[@"create_time"];
        if ([model.status integerValue]==4) {
            if ([dic[@"comment_status"] integerValue]) {
                model.status = @"33";
            }else{
                model.status =  @"22";
            }
        }
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *goods = dic[@"order_goods"];
        for (NSDictionary *good in goods) {
            YReturnsGoodModel *goodModel = [[YReturnsGoodModel alloc]init];
            goodModel.goodId = good[@"goods_id"];
            goodModel.num = good[@"goods_num"];
            goodModel.title = good[@"title"];
            goodModel.imageName = good[@"pic_url"];
            goodModel.applyMoney = good[@"goods_price"];
            [arr addObject:goodModel];
        }
        model.list = arr;
        [list addObject:model];
    }
    return list;
}

#pragma mark ==进度查询列表==
+ (NSMutableArray *)getParseAfterSaleSpeedList:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YReturnsOrdersModel *model = [[YReturnsOrdersModel alloc]init];
        model.serviceId = dic[@"id"];
        model.status = dic[@"status"];
        model.applyTime = dic[@"create_time"];
        NSMutableArray *arr = [NSMutableArray array];
        YReturnsGoodModel *good = [[YReturnsGoodModel alloc]init];
        good.num = dic[@"number"];
        good.title = dic[@"title"];
        good.goodId = dic[@"goods_id"];
        good.imageName = dic[@"pic_url"];
        [arr addObject:good];
        model.list = arr;
        [list addObject:model];
    }
    return list;
}
#pragma mark ==进度查询详情==
+ (YReturnsOrdersModel *)getParseAfterSaleSpeedDetail:(NSDictionary *)data {
    YReturnsOrdersModel *model = [[YReturnsOrdersModel alloc]init];
    model.serviceId = data[@"order_id"];
    model.status = data[@"status"];
    model.info = data[@"tuihuo_case"];
    model.auditInfo = data[@"message"];
    NSMutableArray *goods = [NSMutableArray array];
    YReturnsGoodModel *goodModel = [[YReturnsGoodModel alloc]init];
    goodModel.goodId = data[@"goods_id"];
    goodModel.imageName = data[@"pic_url"];
    goodModel.title = data[@"title"];
    goodModel.num = data[@"number"];
    goodModel.applyMoney = data[@"price"];
    [goods addObject:goodModel];
    model.list = goods;
    NSMutableArray *list = [NSMutableArray array];
    NSArray *audits = data[@"examine"];
    for (NSDictionary*dic in audits) {
        YReturnsSpeedInfoModel *info = [[YReturnsSpeedInfoModel alloc]init];
        info.auditTime = dic[@"update_time"];
        info.auditMessage = dic[@"content"];
        info.auditor = dic[@"auditor"];
        [list addObject:info];
    }
    model.datas = list;
    return model;
}

#pragma mark ==我的消息列表==
+ (NSMutableArray *)getParsePersonNews:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YSMessageModel *model = [[YSMessageModel alloc]init];
        model.title = dic[@"theme"];
        model.content = dic[@"news_info"];
        model.newsId = dic[@"id"];
        model.time = dic[@"create_time"];
        model.imageName = @"news_list01";
        [list addObject:model];
    }
    return list;
}

#pragma mark ==消息详情==
+ (YSMessageModel *)getParsePersonNewsDetail:(NSDictionary *)data {
    YSMessageModel *model = [[YSMessageModel alloc]init];
    model.content = data[@"news_info"];
    model.title = data[@"theme"];
    model.time = data[@"create_time"];
    return model;
}

#pragma mark ==积分筛选列表==
+ (NSMutableArray *)getParseGiftGoods:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YGiftGoodModel *model = [[YGiftGoodModel alloc]init];
        model.goodId = dic[@"goods_id"];
        model.integral = dic[@"integral"];
        model.goodUrl = dic[@"pic_url"];
        model.goodTitle = dic[@"title"];
        model.money = dic[@"price_market"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==积分历史==
+ (NSMutableArray *)getParseGiftHistory:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*dic in data) {
        YPersonIntegralModel *model = [[YPersonIntegralModel alloc]init];
        NSString *type = dic[@"type"];
        if ([type integerValue]==1) {
            model.change = [NSString stringWithFormat:@"+%@",dic[@"integral"]];
        }else{
            model.change = [NSString stringWithFormat:@"%@",dic[@"integral"]];
        }
        model.time = dic[@"trading_time"];
        model.title = dic[@"remarks"];
        [list addObject:model];
    }
    return list;
}

#pragma mark ==积分商品详情==
+ (YGiftGoodModel *)getParseGiftGoodDetail:(NSDictionary *)data {
    YGiftGoodModel *model = [[YGiftGoodModel alloc]init];
    NSDictionary *good = data[@"goods"];
    model.goodTitle = good[@"title"];
    model.integral = good[@"integral"];
    model.money = good[@"price_market"];
    model.brand = good[@"brand_name"];
//    model.goodUrl = good[@"pic_url"];
    NSArray *goods = data[@"pic_url"];
    model.goodUrl = goods.firstObject;
    model.imageArr = goods;
    NSMutableArray *list = [NSMutableArray array];
    NSArray *types = data[@"spec"];
    for (NSDictionary*dic in types) {
        YGiftGoodSpecModel *model = [[YGiftGoodSpecModel alloc]init];
        model.name = dic[@"name"];
        model.item = dic[@"item"];
        [list addObject:model];
    }
    model.list = list;
    return model;
}

#pragma mark ==物流查询==
+ (NSMutableArray *)getParseOrderLogisicInfo:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YLogisicsInfoModel *model = [[YLogisicsInfoModel alloc]init];
        model.info = dic[@"context"];
        model.time = dic[@"time"];
        [list addObject:model];
    }
    return list;
}
#pragma mark ==客服中心文章==
+ (NSMutableArray *)getParseServiceTitles:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YServiceAskModel *ask = [[YServiceAskModel alloc]init];
        ask.className = dic[@"name"];
        NSMutableArray *titleList = [NSMutableArray array];
        NSArray *titles = dic[@"value"];
        for (NSDictionary *titleDic in titles) {
            YServiceTitleModel *model = [[YServiceTitleModel alloc]init];
            model.titleId = titleDic[@"id"];
            model.titleName = titleDic[@"name"];
            [titleList addObject: model];
        }
        ask.titleArr = titleList;
        [list addObject:ask];
    }
    return list;
}
#pragma mark ==文章列表（配送方式）==
+ (NSMutableArray *)getParseTitleList:(NSArray *)data {
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        YServiceTitleModel *model = [[YServiceTitleModel alloc]init];
        model.titleId = dic[@"id"];
        model.titleName = dic[@"name"];
        [list addObject: model];
    }
    return list;
}


@end
