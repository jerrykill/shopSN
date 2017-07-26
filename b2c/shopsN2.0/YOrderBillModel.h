//
//  YOrderBillModel.h
//  shopsN
//
//  Created by imac on 2017/1/20.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YOrderBillModel : NSObject
/**类型*/
@property (strong,nonatomic) NSString *type;
/**抬头*/
@property (strong,nonatomic) NSString *header;
/**抬头类型*/
@property (strong,nonatomic) NSString *headType;
/**内容*/
@property (strong,nonatomic) NSString *info;


@end
