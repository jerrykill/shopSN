//
//  YApplicationModel.h
//  shopsN
//
//  Created by imac on 2016/12/29.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YApplicationModel : NSObject
/**申请人名字*/
@property (strong,nonatomic) NSString *userName;
/**联系方式*/
@property (strong,nonatomic) NSString *phone;
/**联系邮箱*/
@property (strong,nonatomic) NSString *eamil;
/**省*/
@property (strong,nonatomic) NSString *province;
/**市*/
@property (strong,nonatomic) NSString *city;
/**所在地区*/
@property (strong,nonatomic) NSString *area;
/**详细地址*/
@property (strong,nonatomic) NSString *address;
/**年龄*/
@property (strong,nonatomic) NSString *age;
/**QQ*/
@property (strong,nonatomic) NSString *QQ;
/**传真*/
@property (strong,nonatomic) NSString *fax;
/**备注说明*/
@property (strong,nonatomic) NSString *remarks;

@end
