//
//  YAddConsModel.h
//  shopsN
//
//  Created by imac on 2016/12/30.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YConsModel;

@interface YAddConsModel : NSObject

@property (strong,nonatomic) NSString *info;

@property (strong,nonatomic) NSMutableArray <YConsModel*>* list;

@end

@interface YConsModel : NSObject
/**详情*/
@property (strong,nonatomic) NSString *title;
/**数量*/
@property (strong,nonatomic) NSString *num;
/**时间*/
@property (strong,nonatomic) NSString *date;
/**支付状态*/
@property (strong,nonatomic) NSString *status;

@end

