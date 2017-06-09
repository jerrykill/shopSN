//
//  YAddressModel.h
//  shopsN
//
//  Created by imac on 2016/12/5.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAddressModel : NSObject

/**地址id*/
@property (strong,nonatomic) NSString *addressId;
/**姓名*/
@property (strong,nonatomic) NSString *name;
/**手机*/
@property (strong,nonatomic) NSString *phone;
/**详细地址*/
@property (strong,nonatomic) NSString *Address;
/**省*/
@property (strong,nonatomic) NSString *province;
/**省id*/
@property (strong,nonatomic) NSString *provinceID;
/**市*/
@property (strong,nonatomic) NSString *city;
/**市id*/
@property (strong,nonatomic) NSString *cityID;
/**区/县*/
@property (strong,nonatomic) NSString *area;
/**区ID*/
@property (strong,nonatomic) NSString *areaID;

@property (nonatomic) BOOL *isDefault;

@end
