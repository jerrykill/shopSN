//
//  YAlStatementModel.h
//  shopsN
//
//  Created by imac on 2017/1/3.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface YAlStatementModel : NSObject
/**客户名*/
@property (strong,nonatomic) NSString *title;
/**月*/
@property (strong,nonatomic) NSString *month;
/**总余额*/
@property (strong,nonatomic) NSString *money;
/**收入*/
@property (strong,nonatomic) NSString *income;
/**支出*/
@property (strong,nonatomic) NSString *pay;

@end
