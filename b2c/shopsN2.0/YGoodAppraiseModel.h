//
//  YGoodAppraiseModel.h
//  shopsN
//
//  Created by imac on 2016/12/15.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGoodsModel.h"
@interface YGoodAppraiseModel : NSObject

/**用户名*/
@property (strong,nonatomic) NSString *name;
/**用户头像*/
@property (strong,nonatomic) NSString *imageUrl;
/**评论时间*/
@property (strong,nonatomic) NSString *time;
/**评价等级*/
@property (strong,nonatomic) NSString *grade;
/**评价详情*/
@property (strong,nonatomic) NSString *info;
/**评价图片集*/
@property (strong,nonatomic) NSMutableArray *imageArr;
/**评价商品详情*/
@property (strong,nonatomic) YGoodsModel *model;

@property (strong,nonatomic) NSMutableArray<YGoodTypeModel*>*list;

@end
